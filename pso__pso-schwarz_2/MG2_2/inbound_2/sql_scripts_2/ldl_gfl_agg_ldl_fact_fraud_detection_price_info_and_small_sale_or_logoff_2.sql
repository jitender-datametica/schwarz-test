/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_price_info_and_small_sale_or_logoff.sql
#----------------------------------------------------------------------------
# History:
#  1.0  19.09.2024  Kamil Roszczyk   - ZKP GF_2 - script for scenario 'Price info and small sale or logoff'
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/33397/
#  1.1  09.10.2024  Kamil Roszczyk   - fixed bug to display series of price checks, not only last price checks of each series
#  1.2  15.10.2024  Kamil Roszczyk   - naming convention and logic change: price_info_and_small_sale_or_logoff_fg changed to price_info_and_small_sale_fg

#  1.3  26.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenario is enabled in a country_2 (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios

#  1.4  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script
*/


INSERT INTO
	${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final
		(
			cash_register_event_sid
			, cash_register_event_nr
			, event_start_tmsp
			, bus_dt
			, cash_register_sid
			, cash_register_nr
			, store_sid
			, cashier_hash
			, txn_net_val
			, txn_gross_val
			, curr_cd
			
			, price_info_and_small_sale_fg
			, price_info_and_logoff_fg
		)
WITH
	materialize_param_view AS
		(
			SELECT
				*
			FROM
				core_app_fraud_detection.v_fraud_detection_parameter_current_value_2
			WHERE
				scenario_id = 6
		)
	, price_info_events AS
		(
			SELECT
				price_info_event_sid AS cash_register_event_sid
				, cash_register_event_nr
				, CASE
					WHEN cash_register_event_nr - LAG(cash_register_event_nr) OVER(PARTITION BY bus_dt, cash_register_sid ORDER BY cash_register_event_nr) = 1
					THEN 0
					ELSE 1
					END AS series_change_fg
				, CASE
					WHEN LEAD(cash_register_event_nr, 1, 0) OVER(PARTITION BY bus_dt, cash_register_sid ORDER BY cash_register_event_nr) - cash_register_event_nr <> 1
					THEN 1
					ELSE 0
					END AS series_end_fg
				, bus_dt
				, event_tmsp
				, store_sid
				, country_org_cd
				, cash_register_sid
				, cashier_hash
				, 480 AS cash_register_event_type_cd
				, prod_variant_sid
				, prod_price AS txn_gross_val
				, curr_cd
			FROM
				core_rel.t_price_information_event_2
			WHERE
				bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
				AND (country_org_cd, bus_dt, store_sid) IN
					(
						SELECT
							country_cd, dwh_cal_dt, loc_sid
						FROM
							${FWRK_WORK_DB}.vt1
					)
		)
	, all_non_price_events AS
		(
			SELECT
				retail_event_sid AS cash_register_event_sid
				, cash_register_event_nr
				, bus_dt
				, event_start_tmsp AS event_tmsp
				, store_sid
				, country_org_cd
				, cash_register_sid
				, cashier_hash
				, retail_event_scenario_id AS cash_register_event_type_cd
				, txn_gross_val
				, curr_cd
			FROM
				core_rel.t_retail_event_2
			WHERE
				bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
				AND (country_org_cd, bus_dt, store_sid) IN
					(
						SELECT
							country_cd, dwh_cal_dt, loc_sid
						FROM
							${FWRK_WORK_DB}.vt1
					)
			UNION ALL
			SELECT
				tech_cash_register_event_sid AS cash_register_event_sid
				, cash_register_event_nr
				, bus_dt
				, event_tmsp
				, store_sid
				, country_org_cd
				, cash_register_sid
				, cashier_hash
				, tech_cash_register_event_type_cd AS cash_register_event_type_cd
				, 0 AS txn_gross_val
				, '' AS curr_cd
			FROM
				core_rel.t_technical_cash_register_event_2
			WHERE
				bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
				AND (country_org_cd, bus_dt, store_sid) IN
					(
						SELECT
							country_cd, dwh_cal_dt, loc_sid
						FROM
							${FWRK_WORK_DB}.vt1
					)
				AND cash_register_event_type_cd NOT IN (400, 405, 420, 425, 430)
		)
	, price_infos_gt_threshold AS
		(
			SELECT
				pie.cash_register_event_sid
				, pie.cash_register_event_nr
				, pie.series_change_fg
				, SUM(pie.series_change_fg) OVER(ORDER BY pie.country_org_cd, pie.store_sid, pie.cash_register_sid, pie.cash_register_event_nr ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS series_id
				, pie.series_end_fg
				, pie.bus_dt
				, pie.event_tmsp
				, pie.store_sid
				, pie.country_org_cd
				, pie.cash_register_sid
				, pie.cashier_hash
				, pie.cash_register_event_type_cd
				, pie.prod_variant_sid
				, pie.txn_gross_val
				, pie.curr_cd
			FROM
				price_info_events pie
			INNER JOIN
				materialize_param_view p_pig
					ON pie.country_org_cd = p_pig.country_org_cd
					AND p_pig.param_id = 15
					-- if scneario is not enabled all receipts from that country_2 will be eliminated in the inner join
					and p_pig.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
			WHERE
				pie.txn_gross_val > p_pig.param_val_qty
		)
	, event_and_next_event AS
		(
			SELECT
				pigt.cash_register_event_sid
				, pigt.cash_register_event_nr
				, pigt.series_id
				, pigt.series_end_fg
				, pigt.bus_dt
				, pigt.event_tmsp
				, pigt.store_sid
				, pigt.country_org_cd
				, pigt.cash_register_sid
				, pigt.cashier_hash
				, pigt.cash_register_event_type_cd
				, pigt.prod_variant_sid
				, pigt.txn_gross_val
				, pigt.curr_cd
				, anpe_next.cash_register_event_sid AS next_cash_register_event_sid
				, anpe_next.cash_register_event_type_cd AS next_cash_register_event_type_cd
				, anpe_next.txn_gross_val AS next_txn_gross_val
				, anpe_next.event_tmsp AS next_event_tmsp
			FROM
				price_infos_gt_threshold pigt
			INNER JOIN
				all_non_price_events anpe_next
					ON pigt.country_org_cd = anpe_next.country_org_cd
					AND pigt.store_sid = anpe_next.store_sid
					AND pigt.bus_dt = anpe_next.bus_dt
					AND pigt.cash_register_sid = anpe_next.cash_register_sid
					AND pigt.cash_register_event_nr < anpe_next.cash_register_event_nr
			QUALIFY
				ROW_NUMBER() OVER(PARTITION BY pigt.cash_register_event_sid ORDER BY anpe_next.cash_register_event_nr) = 1
		)
	, next_event_details AS
		(
			SELECT
				eane.cash_register_event_sid
				, eane.cash_register_event_nr
				, eane.series_id
				, eane.series_end_fg
				, eane.bus_dt
				, eane.event_tmsp
				, eane.store_sid
				, eane.country_org_cd
				, eane.cash_register_sid
				, eane.cashier_hash
				, eane.cash_register_event_type_cd
				, eane.prod_variant_sid
				, eane.txn_gross_val
				, eane.curr_cd
				, eane.next_cash_register_event_type_cd
				, eane.next_event_tmsp
				, CASE
					WHEN eane.prod_variant_sid = tprl.prod_variant_sid
					THEN 1
					ELSE 0
					END AS product_in_next_receipt_fg
			FROM
				event_and_next_event eane
			LEFT OUTER JOIN
				(
					SELECT DISTINCT
						retail_event_sid
						, prod_variant_sid
					FROM
						core_rel.t_product_retail_line_2
					WHERE
						bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
						AND (country_org_cd, bus_dt, store_sid) IN
							(
								SELECT
									country_cd, dwh_cal_dt, loc_sid
								FROM
									${FWRK_WORK_DB}.vt1
							)
					QUALIFY
						SUM(CASE WHEN retail_event_line_scenario_id IN (101, 102, 120, 122, 201, 202, 220, 222) THEN 1 ELSE 0 END) OVER(PARTITION BY retail_event_sid) = 1
						AND SUM(CASE WHEN cancel_line_seq IS NOT NULL AND retail_line_gross_val > 0 THEN 1 ELSE 0 END) OVER(PARTITION BY retail_event_sid) = 0
				) tprl
					ON eane.next_cash_register_event_sid = tprl.retail_event_sid
			INNER JOIN
				materialize_param_view p_nrl
					ON eane.country_org_cd = p_nrl.country_org_cd
					AND p_nrl.param_id = 16
					-- if scneario is not enabled all receipts from that country_2 will be eliminated in the inner join
					and p_nrl.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
			WHERE
				eane.next_cash_register_event_type_cd = 410
				OR (eane.next_cash_register_event_type_cd = 100
					AND tprl.retail_event_sid IS NOT NULL
					AND eane.next_txn_gross_val < p_nrl.param_val_qty
					)
			QUALIFY
				SUM(product_in_next_receipt_fg) OVER(PARTITION BY eane.series_id) = 0
		)
	, event_and_prev_event AS
		(
			SELECT
				ned.cash_register_event_sid
				, ned.cash_register_event_nr
				, ned.series_id
				, ned.series_end_fg
				, ned.bus_dt
				, ned.event_tmsp
				, ned.store_sid
				, ned.country_org_cd
				, ned.cash_register_sid
				, ned.cashier_hash
				, ned.cash_register_event_type_cd
				, ned.prod_variant_sid
				, ned.txn_gross_val
				, ned.curr_cd
				, ned.next_cash_register_event_type_cd
				, ned.next_event_tmsp
				, anpe_prev.cash_register_event_sid AS prev_cash_register_event_sid
			FROM
				next_event_details ned
			INNER JOIN
				all_non_price_events anpe_prev
					ON ned.country_org_cd = anpe_prev.country_org_cd
					AND ned.store_sid = anpe_prev.store_sid
					AND ned.bus_dt = anpe_prev.bus_dt
					AND ned.cash_register_sid = anpe_prev.cash_register_sid
					AND ned.cash_register_event_nr > anpe_prev.cash_register_event_nr
			QUALIFY
				ROW_NUMBER() OVER(PARTITION BY ned.cash_register_event_sid ORDER BY anpe_prev.cash_register_event_nr DESC) = 1
		)
	, prev_event_details AS
		(
			SELECT DISTINCT
				cash_register_event_sid
				, cash_register_event_nr
				, bus_dt
				, event_tmsp
				, store_sid
				, country_org_cd
				, cash_register_sid
				, cashier_hash
				, prod_variant_sid
				, txn_gross_val
				, curr_cd
				, next_cash_register_event_type_cd
				, next_event_tmsp
			FROM
				(
					SELECT
						eape.cash_register_event_sid
						, eape.cash_register_event_nr
						, eape.series_id
						, eape.series_end_fg
						, eape.bus_dt
						, eape.event_tmsp
						, eape.store_sid
						, eape.country_org_cd
						, eape.cash_register_sid
						, eape.cashier_hash
						, eape.cash_register_event_type_cd
						, eape.prod_variant_sid
						, eape.txn_gross_val
						, eape.curr_cd
						, eape.next_cash_register_event_type_cd
						, eape.next_event_tmsp
						, CASE
							WHEN eape.prod_variant_sid = tprl.prod_variant_sid
							THEN 1
							ELSE 0
							END AS product_in_prev_receipt_fg
					FROM
						event_and_prev_event eape
					LEFT OUTER JOIN
						(
							SELECT DISTINCT
								retail_event_sid
								, prod_variant_sid
							FROM
								core_rel.t_product_retail_line_2
							WHERE
								bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
								AND (country_org_cd, bus_dt, store_sid) IN
									(
										SELECT
											country_cd, dwh_cal_dt, loc_sid
										FROM
											${FWRK_WORK_DB}.vt1
									)
						) tprl
							ON eape.prev_cash_register_event_sid = tprl.retail_event_sid
					QUALIFY
						SUM(product_in_prev_receipt_fg) OVER(PARTITION BY eape.series_id) = 0
				)
		)
SELECT
	ped.cash_register_event_sid
	, ped.cash_register_event_nr
	, ped.event_tmsp AS event_start_tmsp
	, ped.bus_dt
	, ped.cash_register_sid
	, cr.cash_register_nr
	, ped.store_sid
	, ped.cashier_hash
	, 0 AS txn_net_val
	, ped.txn_gross_val
	, ped.curr_cd
	
	, CASE
		WHEN ped.next_cash_register_event_type_cd = 100
		THEN 1
		ELSE 0
		END AS price_info_and_small_sale_fg
	, CASE
		WHEN ped.next_cash_register_event_type_cd = 410
		THEN 1
		ELSE 0
		END AS price_info_and_logoff_fg
FROM
	prev_event_details ped
INNER JOIN
	core_rel.t_cash_register_2 cr
		ON cr.cash_register_sid = ped.cash_register_sid
		AND cr.dwh_valid_fg = TRUE
WHERE
	DATEDIFF('second', ped.event_tmsp, ped.next_event_tmsp) <= 300
;

