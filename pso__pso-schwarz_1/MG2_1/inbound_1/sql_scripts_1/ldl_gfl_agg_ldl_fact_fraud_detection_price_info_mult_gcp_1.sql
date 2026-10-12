-- Converted to BigQuery SQL using Python script

/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_price_info_mult.sql
#----------------------------------------------------------------------------
# History:
#  1.0  05.09.2024  Kamil Roszczyk   - ZKP GF_1 - script for scenario 'Multiple price displays in a series'
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/33398
						
#  1.1  26.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenario is enabled in a country_1 (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios

#  1.2  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script
*/

INSERT INTO
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
			
			, price_info_mult_fg
		)
WITH
	materialize_param_view AS
		(
			SELECT
				*
			FROM
				`${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1`
			WHERE
				scenario_id = 5
		)
	, price_info_events AS
		(
			SELECT
				price_info_event_sid AS cash_register_event_sid
				, cash_register_event_nr
				, bus_dt
				, event_tmsp
				, store_sid
				, country_org_cd
				, cash_register_sid
				, cashier_hash,
				-- , 480 AS cash_register_event_type_cd
        CAST(480 AS STRING) AS cash_register_event_type_cd
				, prod_price AS txn_gross_val
				, curr_cd
			FROM
				`${BQ_PROJECT_ID}.CORE_REL.T_PRICE_INFORMATION_EVENT_1`
			WHERE
				bus_dt BETWEEN min_dwh_cal_dt AND max_dwh_cal_dt 
        AND (country_org_cd) IN
					(
						SELECT
							country_cd
						FROM
							VT1 
					)

        AND (bus_dt) IN
					(
						SELECT
							dwh_cal_dt
						FROM
							VT1 
					)

        AND (store_sid) IN
					(
						SELECT
							loc_sid
						FROM
							VT1 
					)



		)
	, retail_events AS
		(
			SELECT
				retail_event_sid AS cash_register_event_sid
				, cash_register_event_nr
				, bus_dt
				, event_end_tmsp AS event_tmsp
				, store_sid
				, country_org_cd
				, cash_register_sid
				, cashier_hash
				-- , retail_event_scenario_id AS cash_register_event_type_cd
        ,CAST(retail_event_scenario_id AS STRING) AS cash_register_event_type_cd
				, txn_gross_val
				, curr_cd
			FROM
				`${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT_1`
			WHERE
				bus_dt BETWEEN min_dwh_cal_dt AND max_dwh_cal_dt 


				AND (country_org_cd) IN
					(
						SELECT
							country_cd
						FROM
							VT1 
					)


				AND (bus_dt) IN
					(
						SELECT
							dwh_cal_dt
						FROM
							VT1 
					)

				AND (store_sid) IN
					(
						SELECT
							loc_sid
						FROM
							VT1 
					)



		)
	, tech_cash_register_events AS
		(
			SELECT
				tech_cash_register_event_sid AS cash_register_event_sid
				, cash_register_event_nr
				, bus_dt
				, event_tmsp
				, store_sid
				, country_org_cd
				, cash_register_sid
				, cashier_hash
				-- , tech_cash_register_event_type_cd AS cash_register_event_type_cd
        ,CAST(tech_cash_register_event_type_cd AS STRING) AS cash_register_event_type_cd
				, 0 AS txn_gross_val
				, '' AS curr_cd
			FROM
				`${BQ_PROJECT_ID}.CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT_1`
			WHERE
				bus_dt BETWEEN min_dwh_cal_dt AND max_dwh_cal_dt 



				AND (country_org_cd) IN
					(
						SELECT
							country_cd
						FROM
							VT1 
					)

				AND (bus_dt) IN
					(
						SELECT
							dwh_cal_dt
						FROM
							VT1 
					)

				AND (store_sid) IN
					(
						SELECT
							loc_sid
						FROM
							VT1 
					)

		)
SELECT
	pi.cash_register_event_sid
	, pi.cash_register_event_nr
	, pi.event_tmsp AS event_start_tmsp
	, pi.bus_dt
	, pi.cash_register_sid
	-- , cr.cash_register_nr
  ,CAST(cr.cash_register_nr AS STRING) AS cash_register_nr

	, pi.store_sid
	, pi.cashier_hash
	, 0 AS txn_net_val
	, pi.txn_gross_val
	, pi.curr_cd
	
	-- , 1 AS price_info_mult_fg
  ,CAST(1 AS BOOL) AS price_info_mult_fg

FROM
	(
		SELECT
			cash_register_event_sid
			, cash_register_event_nr
			, bus_dt
			, event_tmsp
			, store_sid
			, country_org_cd
			, cash_register_sid
			, cashier_hash
			, cash_register_event_type_cd
			, txn_gross_val
			, curr_cd
			, event_type_change_fg
			, SUM(event_type_change_fg) OVER(PARTITION BY cash_register_sid, bus_dt ORDER BY rnk ROWS UNBOUNDED PRECEDING) AS csum_event_type_change
		FROM
			(
				SELECT
					cash_register_event_sid
					, cash_register_event_nr
					, bus_dt
					, event_tmsp
					, store_sid
					, country_org_cd
					, cash_register_sid
					, cashier_hash
					, cash_register_event_type_cd
					, txn_gross_val
					, curr_cd
					, CASE
						WHEN cash_register_event_type_cd <> LAG(cash_register_event_type_cd) OVER(PARTITION BY bus_dt, cash_register_sid ORDER BY cash_register_event_nr)
						THEN 1
						ELSE 0
						END AS event_type_change_fg
					, ROW_NUMBER() OVER(PARTITION BY cash_register_sid, bus_dt ORDER BY event_tmsp, cash_register_event_nr) AS rnk
				FROM
					(
						--All available cash register events as a base for calculations
						SELECT
							cash_register_event_sid
							-- , cash_register_event_nr
              ,CAST(cash_register_event_nr AS STRING) AS cash_register_event_nr

							, bus_dt
							, event_tmsp
							, store_sid
							, country_org_cd
							, cash_register_sid
							, cashier_hash
							, cash_register_event_type_cd
							, txn_gross_val
							, curr_cd
						FROM
							price_info_events
						UNION DISTINCT
						SELECT
							cash_register_event_sid
							-- , cash_register_event_nr
              ,CAST(cash_register_event_nr AS STRING) AS cash_register_event_nr

							, bus_dt
							, event_tmsp
							, store_sid
							, country_org_cd
							, cash_register_sid
							, cashier_hash
							, cash_register_event_type_cd
							, txn_gross_val
							, curr_cd
						FROM
							retail_events
						UNION DISTINCT
						SELECT
							cash_register_event_sid
							-- , cash_register_event_nr
              ,CAST(cash_register_event_nr AS STRING) AS cash_register_event_nr

							, bus_dt
							, event_tmsp
							, store_sid
							, country_org_cd
							, cash_register_sid
							, cashier_hash
							, cash_register_event_type_cd
							, txn_gross_val
							, curr_cd
						FROM
							tech_cash_register_events
					)
			)
	) pi
INNER JOIN
	`${BQ_PROJECT_ID}.CORE_REL.T_CASH_REGISTER_1` cr
		ON cr.cash_register_sid = pi.cash_register_sid
		AND cr.dwh_valid_fg = TRUE
		
--Parameter "Price info events in series over X"
INNER JOIN
	materialize_param_view p_pin
		ON pi.country_org_cd = p_pin.country_org_cd
		AND p_pin.param_id = 13
		-- if scneario is not enabled all receipts from that country_1 will be eliminated in the inner join
		and p_pin.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
		
--Parameter "Total value of items scanned in price info events within a series"
INNER JOIN
	materialize_param_view p_pis
		ON pi.country_org_cd = p_pis.country_org_cd
		AND p_pis.param_id = 14
		-- if scneario is not enabled all receipts from that country_1 will be eliminated in the inner join
		and p_pis.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
WHERE
        --Pick only price display events as starting ones of each series
	pi.cash_register_event_type_cd = "480"
QUALIFY
	pi.event_type_change_fg = 1
	AND COUNT(1) OVER(PARTITION BY pi.cash_register_sid, pi.bus_dt, pi.csum_event_type_change) >= COALESCE(p_pin.param_val_qty, 2)
	AND SUM(pi.txn_gross_val) OVER(PARTITION BY pi.cash_register_sid, pi.bus_dt, pi.csum_event_type_change) > COALESCE(p_pis.param_val_qty, 2)
;
