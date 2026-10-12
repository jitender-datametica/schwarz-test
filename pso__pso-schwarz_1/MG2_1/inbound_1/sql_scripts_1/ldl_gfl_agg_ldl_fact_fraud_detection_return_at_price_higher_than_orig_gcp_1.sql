-- Converted to BigQuery SQL using Python script

/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_return_at_price_higher_than_orig.sql
#----------------------------------------------------------------------------
# History:
#  1.0  13.09.2024  Kamil Roszczyk   - ZKP GF_1 - script for scenario 'Return at higher price than original'
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/33394/
#  1.1	23.09.2024	Kamil Roszczyk   - Performance optimization, single SQL split into temp tables
#  1.2	24.11.2024	Kamil Roszczyk   - adding the logic for the new flag: return_at_higher_than_official_price_fg
                                           US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/57645
#  1.3  07.03.2025  Kamil Roszczyk   - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63648
										- adjusted the code for extracting the Wawi price
										- replaced prod_variant_sid with local_prod_nr in all places
										- removed condition for lack of original receipt in return_at_higher_than_official_price_fg logic (for this scenario return receipts either with or without original receipt can be qualified)
#  1.4  18.03.2025  Kamil Roszczyk   - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/67104
										- restored filter for return_at_higher_than_official_price_fg to look only for return receipts without original receipts
										
#  1.5  27.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenaio is enabled in a country_1 (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios
#  1.6  01.04.2024  Kamil Roszczyk   - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/67104
										- modified the filter for return_at_higher_than_official_price_fg - qualify only return receipts without any original receipt (previous fix could qualify returns that could also fall into return_not_on_orig_fg - such receipts are also excluded now)

#  1.7  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script
*/
-- CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.t_tmp_return_lines
CREATE OR REPLACE TEMP TABLE T_TMP_RETURN_LINES 
-- DATA_RETENTION_TIME_IN_DAYS = 0
AS
WITH
	materialize_param_view AS
		(
			SELECT
				*
			FROM
				`${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1`
			WHERE
				scenario_id = 11
		)
	, return_receipts AS
		(
			SELECT
				tre.retail_event_sid
				, tre.cash_register_event_nr
				, tre.event_start_tmsp
				, tre.bus_dt
				, tre.cash_register_sid
				, tre.cashier_hash
				, tre.store_sid
				, tre.country_org_cd
				, tre.country_org_sid
				, tre.txn_net_val
				, tre.txn_gross_val
			FROM
			-- ${FWRK_WORK_DB}.vt1
				VT1 VT1
			INNER JOIN
				`${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT_1` tre
					ON tre.store_sid = VT1.loc_sid
					AND tre.country_org_cd  = VT1.country_cd
					AND tre.bus_dt = VT1.dwh_cal_dt
			WHERE
				tre.retail_event_type_cd = 'R'
				AND tre.turnover_relevant_fg = True
		)
	, return_receipt_lines AS
		(
			SELECT
				tprl.retail_event_sid
				, tprl.local_prod_nr
				, tprl.orig_sales_event_sid
				, ANY_VALUE(tprl.store_sid) AS store_sid
				, ANY_VALUE(tprl.country_org_cd) AS country_org_cd
				, ANY_VALUE(tprl.curr_cd) AS curr_cd
				, ANY_VALUE(CONCAT(tprl.country_org_cd, '|', tprl.local_prod_nr)) AS prod_variant_nat_key_nr		--there can be multiple different local_prod_nr values for the same prod_variant_sid within a country_1 but the price will remain the same for them; implementation rule copied from old ZKP
				, MAX(tprl.retail_line_gross_val / COALESCE(tprl.prod_variant_cnt, tprl.prod_variant_qty)) AS adjusted_unit_price
			FROM
				-- ${FWRK_WORK_DB}.vt1
				VT1 VT1
			INNER JOIN
				`${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE_1` tprl
					ON tprl.store_sid = VT1.loc_sid
					AND tprl.country_org_cd  = VT1.country_cd
					AND tprl.bus_dt = VT1.dwh_cal_dt
			INNER JOIN
				materialize_param_view p_arp
					ON tprl.country_org_cd = p_arp.country_org_cd
					AND p_arp.param_id = 32
					-- if scneario is not enabled all receipts from that country_1 will be eliminated in the inner join
					and p_arp.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
			WHERE
				tprl.turnover_relevant_fg = True
				AND COALESCE(tprl.prod_variant_cnt, tprl.prod_variant_qty) <> 0
				AND tprl.retail_line_gross_val / COALESCE(tprl.prod_variant_cnt, tprl.prod_variant_qty) >= p_arp.param_val_qty
			GROUP BY
				tprl.retail_event_sid
				, tprl.local_prod_nr
				, tprl.orig_sales_event_sid
		)
SELECT
	rr.retail_event_sid
	, rr.cash_register_event_nr
	, rr.event_start_tmsp
	, rr.bus_dt
	, rr.cash_register_sid
	, rr.cashier_hash
	, rr.store_sid
	, rr.country_org_cd
	, rr.country_org_sid
	, rr.txn_net_val
	, rr.txn_gross_val
	, rrl.local_prod_nr
	, rrl.prod_variant_nat_key_nr
	, rrl.adjusted_unit_price
	, rrl.curr_cd
	, rrl.orig_sales_event_sid
FROM
	return_receipts rr
INNER JOIN
	return_receipt_lines rrl
		ON rr.retail_event_sid = rrl.retail_event_sid
		AND rr.store_sid = rrl.store_sid
		AND rr.country_org_cd = rrl.country_org_cd
;


-- CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.t_tmp_orig_receipts
CREATE OR REPLACE TEMP TABLE T_TMP_ORIG_RECEIPTS 
-- DATA_RETENTION_TIME_IN_DAYS = 0
AS
SELECT
	tre.retail_event_sid
	, tre.bus_dt
	, tre.store_sid
	, tre.country_org_cd
FROM
	(
		SELECT DISTINCT
			orig_sales_event_sid
		FROM
			T_TMP_RETURN_LINES ttrl 
			-- ${FWRK_WORK_DB}.t_tmp_return_lines ttrl 
		WHERE
			orig_sales_event_sid IS NOT NULL
	) ret_lines
INNER JOIN
	`${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT_1` tre
		ON ret_lines.orig_sales_event_sid = tre.retail_event_sid
		AND tre.retail_event_type_cd = 'S'
;


-- CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.t_tmp_orig_receipt_lines
CREATE OR REPLACE TEMP TABLE T_TMP_ORIG_RECEIPT_LINES 
-- DATA_RETENTION_TIME_IN_DAYS = 0
AS
SELECT
	ttor.retail_event_sid
	, ANY_VALUE(ttor.bus_dt) AS bus_dt
	, ANY_VALUE(ttor.store_sid) AS store_sid
	, ANY_VALUE(ttor.country_org_cd) AS country_org_cd
	, tprl.local_prod_nr
	, MAX(tprl.retail_line_gross_val / COALESCE(tprl.prod_variant_cnt, tprl.prod_variant_qty)) AS adjusted_unit_price
FROM
	T_TMP_ORIG_RECEIPTS ttor 
	-- ${FWRK_WORK_DB}.t_tmp_orig_receipts ttor
INNER JOIN
	`${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE_1` tprl
		ON ttor.retail_event_sid = tprl.retail_event_sid
		AND ttor.bus_dt = tprl.bus_dt
		AND ttor.store_sid = tprl.store_sid
		AND ttor.country_org_cd = tprl.country_org_cd
WHERE
	COALESCE(tprl.prod_variant_cnt, tprl.prod_variant_qty) <> 0
GROUP BY
	ttor.retail_event_sid
	, tprl.local_prod_nr
;




INSERT INTO
	-- ETL.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_FINAL_copy
	`${BQ_PROJECT_ID}.${FWRK_WORK_DB}.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_FINAL`
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
			, return_at_higher_than_sales_price_fg
			, return_at_higher_than_official_price_fg
		)
WITH
	wawi_item_variant_max_price AS
		(
			/* Preaggregate the prices on Wawi item_1 variant level */
			SELECT
				wawi_item_variant_sid
				, MAX(sales_gross_price) AS max_sales_gross_price
			FROM
				`${BQ_PROJECT_ID}.CORE_REL.T_WAWI_ITEM_VARIANT_SALES_PRICE_1`
			GROUP BY
				wawi_item_variant_sid
		)
	, wawi_item_max_price AS
		(
			/* Aggregate the prices on Wawi item_1 level */
			SELECT
				ik.wawi_item_nat_key_nr
				, cast(ik.dwh_valid_from_tmsp as DATE) AS dwh_valid_from_dt
				, cast(ik.dwh_valid_to_tmsp as DATE) AS dwh_valid_to_dt
				, MAX(ivp.max_sales_gross_price) AS max_sales_gross_price
			FROM
				wawi_item_variant_max_price ivp
			INNER JOIN
				`${BQ_PROJECT_ID}.CORE_REL.T_WAWI_ITEM_VARIANT_1` iv
					ON ivp.wawi_item_variant_sid = iv.wawi_item_variant_sid
					AND iv.dwh_valid_fg
			INNER JOIN
				`${BQ_PROJECT_ID}.META.T_WAWI_ITEM_KEY_1` ik
					ON iv.wawi_item_sid = ik.wawi_item_sid
					AND ik.wawi_item_key_type_cd = 'WAWI'
					AND ik.dwh_valid_fg = True
			GROUP BY
				ik.wawi_item_nat_key_nr
				, dwh_valid_from_dt
				, dwh_valid_to_dt
		)
	, calc_flags AS
		(
			SELECT
				rl.retail_event_sid AS cash_register_event_sid
				-- , rl.cash_register_event_nr
				, CAST(rl.cash_register_event_nr AS STRING) AS cash_register_event_nr

				, rl.event_start_tmsp
				, rl.bus_dt
				, rl.cash_register_sid
				-- , cr.cash_register_nr
				, CAST(cr.cash_register_nr AS STRING) AS cash_register_nr

				, rl.store_sid
				, rl.cashier_hash
				, rl.txn_net_val
				, rl.txn_gross_val
				, rl.curr_cd
				-- , CASE
				-- 		WHEN rl.adjusted_unit_price > orl.adjusted_unit_price
				-- 			AND rl.local_prod_nr = orl.local_prod_nr THEN 1
				-- 		ELSE 0
				-- 	END AS return_at_higher_than_sales_price_fg 

			,	CAST(
    CASE
        WHEN rl.adjusted_unit_price > orl.adjusted_unit_price
             AND rl.local_prod_nr = orl.local_prod_nr THEN TRUE
        ELSE FALSE
    END AS BOOL
) AS return_at_higher_than_sales_price_fg


				-- , CASE
				-- 		WHEN rl.adjusted_unit_price > wimp.max_sales_gross_price
				-- 			AND orl.retail_event_sid IS NULL THEN 1
				-- 		ELSE 0
				-- 	END AS return_at_higher_than_official_price_fg

			,	CAST(
    CASE
        WHEN rl.adjusted_unit_price > wimp.max_sales_gross_price
             AND orl.retail_event_sid IS NULL THEN TRUE
        ELSE FALSE
    END AS BOOL
) AS return_at_higher_than_official_price_fg

-- 		,(rl.adjusted_unit_price > wimp.max_sales_gross_price
--  AND orl.retail_event_sid IS NULL) AS return_at_higher_than_official_price_fg

				
			FROM
				T_TMP_RETURN_LINES rl
				-- ${FWRK_WORK_DB}.t_tmp_return_lines rl
			INNER JOIN
				`${BQ_PROJECT_ID}.CORE_REL.T_CASH_REGISTER_1` cr
					ON rl.cash_register_sid = cr.cash_register_sid
					AND cr.dwh_valid_fg
			LEFT OUTER JOIN
				T_TMP_ORIG_RECEIPT_LINES orl 
					-- ${FWRK_WORK_DB}.t_tmp_orig_receipt_lines orl
					ON orl.retail_event_sid = rl.orig_sales_event_sid
			LEFT OUTER JOIN
				wawi_item_max_price wimp
					ON rl.prod_variant_nat_key_nr = wimp.wawi_item_nat_key_nr
					AND rl.bus_dt BETWEEN wimp.dwh_valid_from_dt AND wimp.dwh_valid_to_dt   --filtering on dates as there can be a different product assigned to the same key through the time
			WHERE
				(rl.adjusted_unit_price > orl.adjusted_unit_price
                                        AND rl.local_prod_nr = orl.local_prod_nr)			--return price higher than original price
				OR (rl.adjusted_unit_price > wimp.max_sales_gross_price
										AND orl.retail_event_sid IS NULL)				--OR return price higher than the Wawi max price
		)
SELECT
	cash_register_event_sid
	, ANY_VALUE(cash_register_event_nr) AS cash_register_event_nr
	, ANY_VALUE(event_start_tmsp) AS event_start_tmsp
	, ANY_VALUE(bus_dt) AS bus_dt
	, ANY_VALUE(cash_register_sid) AS cash_register_sid
	, ANY_VALUE(cash_register_nr) AS cash_register_nr
	, ANY_VALUE(store_sid) AS store_sid
	, ANY_VALUE(cashier_hash) AS cashier_hash
	, ANY_VALUE(txn_net_val) AS txn_net_val
	, ANY_VALUE(txn_gross_val) AS txn_gross_val
	, ANY_VALUE(curr_cd) AS curr_cd
	
	, MAX(return_at_higher_than_sales_price_fg) AS return_at_higher_than_sales_price_fg
	, MAX(return_at_higher_than_official_price_fg) AS return_at_higher_than_official_price_fg
FROM
	calc_flags
GROUP BY
    cash_register_event_sid
;
