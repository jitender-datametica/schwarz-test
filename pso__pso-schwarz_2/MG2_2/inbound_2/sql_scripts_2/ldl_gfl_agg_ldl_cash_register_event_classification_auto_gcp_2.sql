/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_cash_register_event_classification_auto.sql
#----------------------------------------------------------------------------
# History:
# 1.0  	12.09.2024  	Piotr Kleysa    	- Script t_cash_register_event_classification_2  - intial version
# 1.1  	18.09.2024  	Andrzej Wandtke 	- Add fields cash_register_event_nr,cashier_nr
# 1.2  	15.10.2024  	Andrzej Wandtke 	- Adjust to the new data model
# 1.3  	16.10.2024  	Andrzej Wandtke 	- Remove use of the flag SMALL_SALE_FG
# 1.4  	22.10.2024  	Andrzej Wandtke 	- Add Lidl Plus part, story 52752 (dev by Mihail Ivanov)
# 1.5  	29.10.2024  	Andrzej Wandtke 	- Add part for subscenarios (scenario_ids higher then 10000)
# 1.6  	04.11.2024  	Andrzej Wandtke 	- Remove aggregation on affected_net_val
# 1.7  	14.11.2024  	Andrzej Wandtke 	- Add sub scenarios
# 1.8  	20.11.2024  	Andrzej Wandtke 	- Add sub scenario 190800
# 1.9  	22.11.2024  	Andrzej Wandtke 	- Add DISTINCT clause
# 1.10  28.11.2024  	Andrzej Wandtke 	- Remove flag_name from CTE cte_fd_scen
# 1.11  02.12.2024  	Mihail Ivanov 		- populating CUST_SID and CUST_IDENT_TYPE_CD in classification table

# 1.12  03.12.2024  	Mihail Ivanov 		- apply threshold for RETURN_SAME_RECEIPT_FG to number of original (purchase) recieps, not to number of return receipts 
													as expected to be fixed in https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/58129/

# 1.13  05.12.2024  	Mihail Ivanov 		- bugix: Threshold for Lidl Plus scenario were switched (daily receipt count was compared to monthly threshold value)

# 1.14  12.12.2024  	Mihail Ivanov 		- bugix: Lid Plus Scenario: Thresholds compared to aggregate values per Cashier + Customer now (before was only Customer)
													 Lidl Plus Scenario: Added logic for threhold "Häufung: Anzahl Tage >="

# 1.15  13.12.2024  	Mihail Ivanov 		- bugix: Lidl Plus Scenario:
													Thresholds comapred now with ">=" instad of ">", and number of unique days that daily threshold is passed is fixed

# 1.16	24.01.2025		Kamil Roszczyk		- bugfix: for scenario "return same cashier and day" changed the daily receipt count to whole period receipt count comparison with accumulation threshold
												https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/62194

# 1.17	27.01.2025		Andrzej Wandtke		- bugfix: 63363 for scenario "Bonrückstellung mit Bonabbruch / Storno / neuer Kunde | remove Neuer Kunde" - skip the "SUSPEND_AND_EXTEND_FG" flag for the scenario_id 15, deactivate scenario_id 150200
                                                - story: 63522 - add subscenarios 170100, 170200

# 1.18  27.01.2025		Kamil Roszczyk		- added EVENT_END_HR field to CORE_APP_FRAUD_DETECTION.t_cash_register_event_classification_2 table, created a mapping for it
													US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/55157
														- as a source for Lidl Plus scenario took event_end_tmsp from CORE_REL.t_retail_event_2 already being a part of a source logic
														- as a source for the rest of scenarios added CORE_REL.t_retail_event_2 to ETL.t_tmp_receipts_selected temp table and took the attribute in the rest of temp tables from there

# 1.19  05.02.2025		Kamil Roszczyk		- bugfix: corrected cash_register_affected_net_val input value for subscenarios' INSERT statement (was: 1, is: txn_net_val from t_fact_fraud_detection_by_cash_register_event_2) 

												US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63522?src=WorkItemMention&src-action=artifact_link
# 1.20	18.02.2025              Andrzej Wandtke - ZKP GF_2 - Remove scenario 1 (deposit_and_one_prod_fg) - https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/64819
                                                           Add subscenarios 180700, 180800, 190500 - https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63798/

# 1.21	03.03.2025              Andrzej Wandtke - ZKP GF_2 - Story 63522: fill the column cash_register_event_affected_gross_val 

# 1.22	10.03.2025              Andrzej Wandtke - ZKP GF_2 - Story 66361: Lidl Plus - if monthly threshold passed in at least one month, show all the months (use variable monthly_threshold_passed_in_whole_period)
                                                           If variable monthly_threshold_passed_once was at least once equal to 1, meaning that in one month number of operations has exceeded the threshold, so data from all months by given cashier has to be shown

# 1.23	11.03.2025              Andrzej Wandtke - ZKP GF_2 - Story 66403: Preisanzeige; scenarios 6, 60100, 60200 - add special marking for chains of show price events

# 1.24	14.03.2025				Kamil Roszczyk	- ZKP GF_2 - removed accumulation threshold "Häufung (Anzahl Bons in 1 beliebigen Woche_2)>=" (param_id = 44) from cte_param_value CTE in first INSERT statement to classification table
												US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/65866

# 1.25	27.03.2025				Kamil Roszczyk	- ZKP GF_2 - removed additional accumulation thresholds "Häufung (Anzahl Bons in 1 beliebigen Woche_2)>=" (param_id in (30, 54)) from cte_param_value CTE in first INSERT statement to classification table
													US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/65866
												- added the exceptions in populating cash_register_event_affected_net_val and cash_register_event_affected_gross_val fields in classification table for scenarios "last position cancel" and "cancel in favour"
													https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66945
													
# 1.26  01.04.2025  			Mihail Ivanov  - Changes:
												- added logic to set the flag only in scenario is enabled in a country_2
													This is done for LIDL Plus scenario only. For the other scenarios the flags are already set correctly in their scripts.
													https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803

												- added logic to populate sub-scenario 191000 "CANCEL_IN_FAVOUR_HIGHEST_POS_FG" in the "classification" table
# 1.27	02.04.2025              Andrzej Wandtke - ZKP GF_2 - Story 66946: populate scenario 120800
                                                         - Story 66944: populate scenario 140200
*/

-- All the receipts from stores selected by user
CREATE OR REPLACE TEMP TABLE T_TMP_RECEIPTS_SELECTED
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- )
AS
(
	SELECT 
		s.country_org_cd, 
		EXTRACT(HOUR FROM COALESCE(current_timestamp, current_timestamp,current_timestamp)) AS EVENT_END_HR,
		fde.*
	FROM `${BQ_PROJECT_ID}.CORE_DIM.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_2` fde
		INNER JOIN `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED_2` s
			ON  fde.STORE_SID = s.STORE_SID
			AND fde.BUS_DT = s.BUS_DT
		--left join to t_retail_event_2, t_price_information_event_2 and t_technical_cash_register_event_2 to get event_end_tmsp/event_tmsp value only (only event_start_tmsp available in T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_2) - that's for event_end_hr attribute purposes
		LEFT JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT_2` tre
			ON fde.CASH_REGISTER_EVENT_SID = tre.RETAIL_EVENT_SID
		LEFT JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRICE_INFORMATION_EVENT_2` tpie
			ON fde.CASH_REGISTER_EVENT_SID = tpie.PRICE_INFO_EVENT_SID
		LEFT JOIN `${BQ_PROJECT_ID}.CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT_2` ttcre
			ON fde.CASH_REGISTER_EVENT_SID = ttcre.TECH_CASH_REGISTER_EVENT_SID
	WHERE s.is_directly_ordered = 1
)
;

-- select * from T_TMP_RECEIPTS_SELECTED;

-- Delete before insert to update receipts information in case it comes with changes for the same period
DELETE FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_2` c
WHERE c.scenario_id IN (
    SELECT s.scenario_id 
    FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO_2` s
    WHERE scenario_type_cd = 'AUTO'
)
AND EXISTS (
    SELECT 1
    FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED_2` sq
    WHERE sq.store_sid = c.store_sid
      AND sq.bus_dt = c.bus_dt
);

-- Load all the main scenarios based on threshold values
INSERT INTO
  `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_2` (
    cash_register_event_sid,
    cash_register_event_nr,
    scenario_id,
    country_org_cd,
    store_sid,
    bus_dt,
    event_end_hr,
    cashier_nr,
    cust_sid,
    cust_ident_type_cd,
    cash_register_event_cnt,
    cash_register_event_affected_line_cnt,
    cash_register_event_affected_net_val,
    cash_register_event_affected_gross_val,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
  )
WITH cte_param_value AS (
    SELECT
      country_org_cd,
      scenario_id,
      MAX(CASE WHEN param_id IN ( 2, 5, 6, 9, 18, 20, 23, 26, 31, 33, 34, 38, 42, 43, 48, 50, 53, 60) THEN COALESCE(param_val_qty, 0) ELSE NULL END ) AS param_cnt_event_all_analysis_period,
      MAX(CASE WHEN param_id IN (19) THEN COALESCE(param_val_qty, 0) ELSE NULL END ) AS param_cnt_group_event_all_analysis_period, -- "Anzahl Vorgänge" - number of groups of operations is calculated differently, therefore a separate parameter
      MAX(CASE WHEN param_id IN (3) THEN param_val_qty ELSE NULL END ) AS param_cnt_event_1week_in_analysis_period,
      MAX(CASE WHEN param_id IN (-1) THEN param_val_qty ELSE NULL END ) AS param_cnt_event_1day_in_analysis_period,
      MAX(CASE WHEN param_id IN (10, 12, 17, 64) THEN param_val_qty ELSE NULL END) AS param_cnt_days_in_analysis_period
    FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_2`
    GROUP BY country_org_cd, scenario_id
  ),
  cte_fd_scen AS (
    SELECT
      DISTINCT country_org_cd,
      cash_register_event_sid,
      cash_register_event_nr,
      bus_dt,
      event_end_hr,
      store_sid,
      cashier_hash,
      cust_sid,
      cust_ident_type_cd,
      cancel_last_pos_gross_val,
      cancel_in_favour_gross_val,
      txn_net_val,
      txn_gross_val,
      CASE
        WHEN flag_name = 'DEPOSIT_SAME_EAN_FG' THEN 2
        WHEN flag_name = 'DEPOSIT_ONLY_MANUAL_INPUT_FG' THEN 4
        WHEN flag_name = 'PRICE_INFO_MULT_FG' THEN 5
        WHEN flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG' 
        OR flag_name = 'PRICE_INFO_AND_LOGOFF_FG' THEN 6
        WHEN flag_name = 'RETURN_WITHOUT_AUTH_FG' THEN 7
        WHEN flag_name = 'RETURN_SAME_RECEIPT_FG' THEN 8
        WHEN flag_name = 'RETURN_SAME_PROD_FG' THEN 9
        WHEN flag_name = 'RETURN_NOT_ON_RECEIPT_FG' 
        OR flag_name = 'RETURN_QTY_INVALID_FG' THEN 10
        WHEN flag_name = 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG' 
        OR flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG' THEN 11
        WHEN flag_name = 'RETURN_SAME_CASHIER_AND_DAY_FG' THEN 12
        WHEN flag_name = 'RETURN_WITHOUT_RECEIPT_KE_INPUT_FG' THEN 13
        WHEN flag_name = 'RETURN_MULT_PROD_FG' THEN 14
        WHEN flag_name = 'SUSPEND_AND_ABORT_FG' 
        OR flag_name = 'SUSPEND_AND_LINE_CANCEL_FG' THEN 15
        WHEN flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG' 
        OR flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG' THEN 16
        WHEN flag_name = 'ABORT_AND_SALE_FG' 
        OR flag_name = 'ABORT_AND_LOGOFF_FG' THEN 17
        WHEN flag_name = 'CANCEL_LAST_POS_FG' THEN 18
        WHEN flag_name = 'CANCEL_IN_FAVOUR_FG' THEN 19
    ELSE -1 END AS scenario_id,

    CASE WHEN flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG' 
        OR flag_name = 'PRICE_INFO_AND_LOGOFF_FG' THEN
        cash_register_event_sid - ROW_NUMBER() OVER (
            ORDER BY
                CASE
                    WHEN flag_name = 'DEPOSIT_SAME_EAN_FG' THEN 2
                    WHEN flag_name = 'DEPOSIT_ONLY_MANUAL_INPUT_FG' THEN 4
                    WHEN flag_name = 'PRICE_INFO_MULT_FG' THEN 5
                    WHEN flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG' OR flag_name = 'PRICE_INFO_AND_LOGOFF_FG' THEN 6
                    WHEN flag_name = 'RETURN_WITHOUT_AUTH_FG' THEN 7
                    WHEN flag_name = 'RETURN_SAME_RECEIPT_FG' THEN 8
                    WHEN flag_name = 'RETURN_SAME_PROD_FG' THEN 9
                    WHEN flag_name = 'RETURN_NOT_ON_RECEIPT_FG' OR flag_name = 'RETURN_QTY_INVALID_FG' THEN 10
                    WHEN flag_name = 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG' OR flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG' THEN 11
                    WHEN flag_name = 'RETURN_SAME_CASHIER_AND_DAY_FG' THEN 12
                    WHEN flag_name = 'RETURN_WITHOUT_RECEIPT_KE_INPUT_FG' THEN 13
                    WHEN flag_name = 'RETURN_MULT_PROD_FG' THEN 14
                    WHEN flag_name = 'SUSPEND_AND_ABORT_FG' OR flag_name = 'SUSPEND_AND_LINE_CANCEL_FG' THEN 15
                    WHEN flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG' OR flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG' THEN 16
                    WHEN flag_name = 'ABORT_AND_SALE_FG' OR flag_name = 'ABORT_AND_LOGOFF_FG' THEN 17
                    WHEN flag_name = 'CANCEL_LAST_POS_FG' THEN 18
                    WHEN flag_name = 'CANCEL_IN_FAVOUR_FG' THEN 19
                    ELSE -1
                END,
            cash_register_event_sid
        )
    ELSE NULL END AS group_id

    FROM  T_TMP_RECEIPTS_SELECTED
    -- Unpivot the table because one receipt can have multiple flags set to true
    -- This will create separate rows for receipt and active flag
   UNPIVOT (
    flag_value FOR flag_name IN (
          deposit_same_ean_fg, 
          deposit_only_manual_input_fg, 
          price_info_mult_fg, 
          price_info_and_small_sale_fg, 
          price_info_and_logoff_fg, 
          return_without_auth_fg, 
          return_same_receipt_fg, 
          return_same_prod_fg, 
          return_not_on_receipt_fg, 
          return_qty_invalid_fg, 
          return_at_higher_than_sales_price_fg, 
          return_at_higher_than_official_price_fg, 
          return_same_cashier_and_day_fg, 
          return_without_receipt_ke_input_fg, 
          return_mult_prod_fg, 
          suspend_and_abort_fg, 
          suspend_and_line_cancel_fg, 
          suspend_unresolved_and_logoff_fg, 
          suspend_unresolved_and_sale_fg,
          abort_and_sale_fg, 
          abort_and_logoff_fg, 
          cancel_last_pos_fg, 
          cancel_in_favour_fg
    )
)
WHERE flag_value = TRUE
  ),
  fd_sel_return_same_receipt AS (
    SELECT
      *
    FROM
      (
        SELECT
          fd.cash_register_event_sid,
          fd.scenario_id,
          -- all these are descriptive attributes of retail event and do not change granularity
          fd.store_sid,
          ce.cashier_nr,
          fd.country_org_cd,
          fd.cash_register_event_nr,
          fd.bus_dt,
          fd.event_end_hr,
          fd.cashier_hash,
          fd.cust_sid,
          fd.cust_ident_type_cd,
          fd.txn_net_val AS affected_net_val,
          fd.txn_gross_val AS affected_gross_val,
          MAX(prl.ORIG_SALES_EVENT_SID) AS purch_event_sid,
          COUNT(fd.cash_register_event_sid) OVER (PARTITION BY fd.store_sid, ce.cashier_nr, fd.scenario_id) AS cnt_event_all_analysis_period,
          COUNT(DISTINCT MAX(prl.ORIG_SALES_EVENT_SID)) OVER ( PARTITION BY fd.store_sid, ce.cashier_nr, fd.scenario_id) AS cnt_orig_purchases_all_analysis_period,
          pv.param_val_qty
        FROM cte_fd_scen AS fd 
          -- workaround until "relationship" table is ready to be reused in many scenarios
          -- for the Returns, we find the SID of the original purchase from T_PRODUCT_RETAIL_LINE_2
          INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE_2` AS prl ON prl.RETAIL_EVENT_SID = fd.CASH_REGISTER_EVENT_SID AND prl.BUS_DT = fd.BUS_DT AND prl.COUNTRY_ORG_CD = fd.COUNTRY_ORG_CD AND prl.PROD_RETAIL_LINE_TYPE_CD = 'R'
          INNER JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_2` AS pv ON fd.country_org_cd = pv.country_org_cd AND pv.scenario_id = 8 AND pv.param_id = 23
          INNER JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION_2` AS ce ON fd.bus_dt = ce.bus_dt AND fd.cashier_hash = ce.cashier_hash
        WHERE fd.SCENARIO_ID = 8 -- for scenario 8 we have special logic and need to find original purchase receipt
        GROUP BY
          fd.cash_register_event_sid,
          fd.scenario_id,
          -- all these are descriptive attributes of retail event and do not change granularity
          fd.store_sid,
          ce.cashier_nr,
          fd.country_org_cd,
          fd.cash_register_event_nr,
          fd.bus_dt,
          fd.event_end_hr,
          fd.cashier_hash,
          fd.cust_sid,
          fd.cust_ident_type_cd,
          fd.txn_net_val,
          fd.txn_gross_val,
          pv.param_val_qty
      )
      -- take events only if number of original purchases that have been used multiple times for returns exceeds this threshold value
    WHERE cnt_orig_purchases_all_analysis_period >= param_val_qty
  ),
  fd_sel_other AS (
    SELECT
      *
    FROM
      (
        SELECT
          fd.country_org_cd,
          cash_register_event_sid,
          cash_register_event_nr,
          fd.bus_dt,
          fd.event_end_hr,
          store_sid,
          fd.cashier_hash,
          fd.cust_sid,
          fd.cust_ident_type_cd,
          ce.cashier_nr,
          -- special case for Preisanzeige: mark the first operation from the chain by 1, other operations by 0
          CASE
            WHEN fd.scenario_id <> 6 THEN 1
            WHEN fd.scenario_id = 6 AND MIN(cash_register_event_sid) OVER ( PARTITION BY store_sid, fd.bus_dt, group_id ) = cash_register_event_sid THEN 1
            ELSE 0 END AS cash_register_event_cnt,
          fd.scenario_id,
          COUNT(cash_register_event_sid) OVER ( PARTITION BY fd.store_sid, ce.cashier_nr, fd.scenario_id ) AS cnt_event_all_analysis_period,
          param_cnt_event_all_analysis_period,
          fd.group_id,
          COUNT(DISTINCT fd.group_id) OVER (PARTITION BY fd.store_sid, ce.cashier_nr, fd.scenario_id) AS cnt_groups,
          param_cnt_group_event_all_analysis_period,
          COUNT(cash_register_event_sid) OVER (PARTITION BY fd.store_sid, ce.cashier_nr, cd.cal_week, fd.scenario_id) AS cnt_event_1week_in_analysis_period,
          param_cnt_event_1week_in_analysis_period,
          COUNT(cash_register_event_sid) OVER (PARTITION BY fd.store_sid, ce.cashier_nr, cd.cal_dt, fd.scenario_id) AS cnt_event_1day_in_analysis_period,
          param_cnt_event_1day_in_analysis_period,
          COUNT(DISTINCT cd.cal_dt) OVER (PARTITION BY fd.store_sid, ce.cashier_nr, fd.scenario_id) AS cnt_days_in_analysis_period,
          param_cnt_days_in_analysis_period,

          --For scenarios 18 (last position cancel) and 19 (cancel in favour) net val is not needed and gross val should be loaded from fields in CORE_DIM dedicated specifically for these scenarios
          CASE WHEN fd.scenario_id IN (18, 19) THEN NULL ELSE fd.txn_net_val END AS affected_net_val,
          CASE WHEN fd.scenario_id = 18 THEN fd.cancel_last_pos_gross_val WHEN fd.scenario_id = 19 THEN fd.cancel_in_favour_gross_val ELSE fd.txn_gross_val END AS affected_gross_val

        FROM cte_fd_scen AS fd
          INNER JOIN cte_param_value AS pv ON fd.country_org_cd = pv.country_org_cd AND fd.scenario_id = pv.scenario_id
          INNER JOIN `${BQ_PROJECT_ID}.CORE_DIM.T_DIM_CALENDAR_DATE_2` AS cd ON fd.bus_dt = cd.cal_dt
          INNER JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION_2` AS ce ON fd.bus_dt = ce.bus_dt AND fd.cashier_hash = ce.cashier_hash
        WHERE fd.SCENARIO_ID <> 8 -- for scenario 8 we have special logic and need to find original purchase receipt
      )
    WHERE  (
        IF( param_cnt_event_all_analysis_period IS NULL AND param_cnt_event_1week_in_analysis_period IS NULL AND param_cnt_event_1day_in_analysis_period IS NULL, TRUE, FALSE)
        -- When all the parameters based on count are null then set the flag to true as to make the other parameter (based on count of days) valid
        OR -- When single parameters based on count are null or they do not exist - they should not matter - therefore flag set to false as the operand is OR
        IF(scenario_id = 6,
          -- special case for Preisanzeige
          cnt_event_all_analysis_period >= param_cnt_event_all_analysis_period AND cnt_groups >= param_cnt_group_event_all_analysis_period,
          IF( param_cnt_event_all_analysis_period IS NULL, FALSE, cnt_event_all_analysis_period >= param_cnt_event_all_analysis_period))
        OR IF( param_cnt_event_1week_in_analysis_period IS NULL, FALSE, cnt_event_1week_in_analysis_period >= param_cnt_event_1week_in_analysis_period)
        OR IF( param_cnt_event_1day_in_analysis_period IS NULL, FALSE, cnt_event_1day_in_analysis_period >= param_cnt_event_1day_in_analysis_period )
      ) -- When parameter based on days does not exist - it should not matter - therefore flag set to true as the operand is AND
      AND IF( param_cnt_days_in_analysis_period IS NULL, TRUE, cnt_days_in_analysis_period >= param_cnt_days_in_analysis_period
      )
  )
SELECT
  cash_register_event_sid,
  cash_register_event_nr,
  scenario_id,
  country_org_cd,
  store_sid,
  bus_dt,
  event_end_hr,
  cashier_nr,
  IFNULL(cust_sid, -1),
  IFNULL(cust_ident_type_cd, '@'),
  cash_register_event_cnt AS cash_register_event_cnt,
  cnt_event_all_analysis_period AS cash_register_affected_event_cnt,
  affected_net_val AS cash_register_affected_net_val,
  affected_gross_val AS cash_register_affected_gross_val,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  ${LOAD_ID},
  'MANUAL'
FROM fd_sel_other

UNION ALL

SELECT
  cash_register_event_sid,
  cash_register_event_nr,
  scenario_id,
  country_org_cd,
  store_sid,
  bus_dt,
  event_end_hr,
  cashier_nr,
  IFNULL(cust_sid, -1),
  IFNULL(cust_ident_type_cd, '@'),
  1 AS cash_register_event_cnt,
  cnt_event_all_analysis_period AS cash_register_affected_event_cnt,
  affected_net_val AS cash_register_affected_net_val,
  affected_gross_val AS cash_register_affected_gross_val,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  ${LOAD_ID},
  'MANUAL'
FROM fd_sel_return_same_receipt;

-- Insert receipts having flags for subscenarios (above 100000)
-- Objective here is to add rows for the receipts having sub-scenarios (multiple flags set to true)
-- Eg. when a receipt has the flags CANCEL_LAST_POS_FG and CANCEL_LAST_POS_EXACT_PAYM_FG - row with scenario 18 is already inserted in the previous step, but the row corresponding to the flag CANCEL_LAST_POS_EXACT_PAYM_FG (scenario 180100) will be inserted below.
INSERT INTO `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_2`
(
  cash_register_event_sid,
  cash_register_event_nr,
  scenario_id,
  country_org_cd,
  store_sid,
  bus_dt,
  event_end_hr,
  cashier_nr,
  cust_sid,
  cust_ident_type_cd,
  cash_register_event_cnt,
  cash_register_event_affected_line_cnt,
  cash_register_event_affected_net_val,
  cash_register_event_affected_gross_val,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
)
WITH cte_inserted AS (
-- all the receipts added in current run
  SELECT * FROM T_TMP_RECEIPTS_SELECTED
),
cte_fd_subscen AS (
  SELECT
    country_org_cd,
    cash_register_event_sid,
    cash_register_event_nr,
    bus_dt,
    event_end_hr,
    store_sid,
    cashier_hash,
    cust_sid,
    cust_ident_type_cd,
    txn_net_val AS affected_net_val,
    txn_gross_val AS affected_gross_val,
    flag_name,
    CASE
      WHEN flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG' THEN 60100
      WHEN flag_name = 'PRICE_INFO_AND_LOGOFF_FG' THEN 60200
      WHEN flag_name = 'RETURN_NOT_ON_RECEIPT_FG' THEN 100100
      WHEN flag_name = 'RETURN_QTY_INVALID_FG' THEN 100200
      WHEN flag_name = 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG' THEN 110100
      WHEN flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG' THEN 110200
      WHEN flag_name = 'RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG' THEN 120100
      WHEN flag_name = 'RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG' THEN 120200
      WHEN flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG' THEN 120300
      WHEN flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG' THEN 120400
      WHEN flag_name = 'RETURN_SAME_CASHIER_DIFF_DAY_FG' THEN 120600
      WHEN flag_name = 'RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG' THEN 120700
      WHEN flag_name = 'RETURN_SAME_CASHIER_FG' THEN 120800
      WHEN flag_name = 'RETURN_WITHOUT_RECEIPT_DV_INPUT_FG' THEN 130100
      WHEN flag_name = 'RETURN_WITHOUT_RECEIPT_FG' THEN 130200
      WHEN flag_name = 'RETURN_MULT_PROD_FULL_QTY_FG' THEN 140100
      WHEN flag_name = 'RETURN_MULT_PROD_SAME_CASHIER_FG' THEN 140200
      WHEN flag_name = 'SUSPEND_AND_ABORT_FG' THEN 150100
      WHEN flag_name = 'SUSPEND_AND_LINE_CANCEL_FG' THEN 150300
      WHEN flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG' THEN 160100
      WHEN flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG' THEN 160200
      WHEN flag_name = 'ABORT_AND_SALE_FG' THEN 170100
      WHEN flag_name = 'ABORT_AND_LOGOFF_FG' THEN 170200
      WHEN flag_name = 'CANCEL_LAST_POS_EXACT_PAYM_FG' THEN 180100
      WHEN flag_name = 'CANCEL_LAST_POS_AFTER_SUBTOTAL_FG' THEN 180200
      WHEN flag_name = 'CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG' THEN 180300
      WHEN flag_name = 'CANCEL_LAST_POS_HIGHEST_POS_FG' THEN 180400
      WHEN flag_name = 'CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG' THEN 180500
      WHEN flag_name = 'CANCEL_LAST_AND_OTHER_POS_FG' THEN 180600
      WHEN flag_name = 'CANCEL_LAST_POS_WITHOUT_AUTH_FG' THEN 180700
      WHEN flag_name = 'CANCEL_LAST_POS_SINGLE_POS_FG' THEN 180800
      WHEN flag_name = 'CANCEL_IN_FAVOUR_EXACT_PAYM_FG' THEN 190100
      WHEN flag_name = 'CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG' THEN 190200
      WHEN flag_name = 'CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG' THEN 190300
      WHEN flag_name = 'CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG' THEN 190400
      WHEN flag_name = 'CANCEL_IN_FAVOUR_SINGLE_POS_FG' THEN 190500
      WHEN flag_name = 'CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG' THEN 190600
      WHEN flag_name = 'CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG' THEN 190700
      WHEN flag_name = 'CANCEL_IN_FAVOUR_LIDL_PLUS_FG' THEN 190800
      WHEN flag_name = 'CANCEL_IN_FAVOUR_HIGHEST_POS_FG' THEN 191000
      ELSE -1 END AS scenario_id,
    CASE  WHEN flag_name IN ('PRICE_INFO_AND_SMALL_SALE_FG', 'PRICE_INFO_AND_LOGOFF_FG') 
    -- special case for Preisanzeige: give a group id (Vorgang)
    THEN  cash_register_event_sid - ROW_NUMBER() OVER (ORDER BY     CASE
      WHEN flag_name = 'PRICE_INFO_AND_SMALL_SALE_FG' THEN 60100
      WHEN flag_name = 'PRICE_INFO_AND_LOGOFF_FG' THEN 60200
      WHEN flag_name = 'RETURN_NOT_ON_RECEIPT_FG' THEN 100100
      WHEN flag_name = 'RETURN_QTY_INVALID_FG' THEN 100200
      WHEN flag_name = 'RETURN_AT_HIGHER_THAN_SALES_PRICE_FG' THEN 110100
      WHEN flag_name = 'RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG' THEN 110200
      WHEN flag_name = 'RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG' THEN 120100
      WHEN flag_name = 'RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG' THEN 120200
      WHEN flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG' THEN 120300
      WHEN flag_name = 'RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG' THEN 120400
      WHEN flag_name = 'RETURN_SAME_CASHIER_DIFF_DAY_FG' THEN 120600
      WHEN flag_name = 'RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG' THEN 120700
      WHEN flag_name = 'RETURN_SAME_CASHIER_FG' THEN 120800
      WHEN flag_name = 'RETURN_WITHOUT_RECEIPT_DV_INPUT_FG' THEN 130100
      WHEN flag_name = 'RETURN_WITHOUT_RECEIPT_FG' THEN 130200
      WHEN flag_name = 'RETURN_MULT_PROD_FULL_QTY_FG' THEN 140100
      WHEN flag_name = 'RETURN_MULT_PROD_SAME_CASHIER_FG' THEN 140200
      WHEN flag_name = 'SUSPEND_AND_ABORT_FG' THEN 150100
      WHEN flag_name = 'SUSPEND_AND_LINE_CANCEL_FG' THEN 150300
      WHEN flag_name = 'SUSPEND_UNRESOLVED_AND_SALE_FG' THEN 160100
      WHEN flag_name = 'SUSPEND_UNRESOLVED_AND_LOGOFF_FG' THEN 160200
      WHEN flag_name = 'ABORT_AND_SALE_FG' THEN 170100
      WHEN flag_name = 'ABORT_AND_LOGOFF_FG' THEN 170200
      WHEN flag_name = 'CANCEL_LAST_POS_EXACT_PAYM_FG' THEN 180100
      WHEN flag_name = 'CANCEL_LAST_POS_AFTER_SUBTOTAL_FG' THEN 180200
      WHEN flag_name = 'CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG' THEN 180300
      WHEN flag_name = 'CANCEL_LAST_POS_HIGHEST_POS_FG' THEN 180400
      WHEN flag_name = 'CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG' THEN 180500
      WHEN flag_name = 'CANCEL_LAST_AND_OTHER_POS_FG' THEN 180600
      WHEN flag_name = 'CANCEL_LAST_POS_WITHOUT_AUTH_FG' THEN 180700
      WHEN flag_name = 'CANCEL_LAST_POS_SINGLE_POS_FG' THEN 180800
      WHEN flag_name = 'CANCEL_IN_FAVOUR_EXACT_PAYM_FG' THEN 190100
      WHEN flag_name = 'CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG' THEN 190200
      WHEN flag_name = 'CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG' THEN 190300
      WHEN flag_name = 'CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG' THEN 190400
      WHEN flag_name = 'CANCEL_IN_FAVOUR_SINGLE_POS_FG' THEN 190500
      WHEN flag_name = 'CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG' THEN 190600
      WHEN flag_name = 'CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG' THEN 190700
      WHEN flag_name = 'CANCEL_IN_FAVOUR_LIDL_PLUS_FG' THEN 190800
      WHEN flag_name = 'CANCEL_IN_FAVOUR_HIGHEST_POS_FG' THEN 191000
      ELSE -1 END, cash_register_event_sid)
      ELSE NULL END AS group_id
  FROM cte_inserted
-- Unpivot the table because one receipt can have multiple flags set to true
-- This will create separate rows for receipt and active flag
  UNPIVOT (
    flag_value FOR flag_name IN (
      price_info_and_small_sale_fg,
      price_info_and_logoff_fg,
      return_not_on_receipt_fg,
      return_qty_invalid_fg,
      return_at_higher_than_sales_price_fg,
      return_at_higher_than_official_price_fg,
      return_same_cashier_and_day_manual_fg,
      return_same_cashier_and_day_without_auth_fg,
      return_same_cashier_and_day_cash_paym_fg,
      return_same_cashier_and_day_card_paym_fg,
      return_same_cashier_diff_day_fg,
      return_same_cashier_and_day_display_sel_fg,
      return_same_cashier_fg,
      return_without_receipt_dv_input_fg,
      return_without_receipt_fg,
      return_mult_prod_full_qty_fg,
      return_mult_prod_same_cashier_fg,
      suspend_and_abort_fg,
      suspend_and_line_cancel_fg,
      suspend_unresolved_and_sale_fg,
      suspend_unresolved_and_logoff_fg,
      abort_and_sale_fg,
      abort_and_logoff_fg,
      cancel_last_pos_exact_paym_fg,
      cancel_last_pos_after_subtotal_fg,
      cancel_last_pos_alcohol_tobacco_fg,
      cancel_last_pos_highest_pos_fg,
      cancel_last_pos_outside_opening_hr_fg,
      cancel_last_and_other_pos_fg,
      cancel_last_pos_without_auth_fg,
      cancel_last_pos_single_pos_fg,
      cancel_in_favour_exact_paym_fg,
      cancel_in_favour_after_subtotal_fg,
      cancel_in_favour_manual_discount_fg,
      cancel_in_favour_without_auth_fg,
      cancel_in_favour_alcohol_tobacco_fg,
      cancel_in_favour_single_pos_fg,
      cancel_in_favour_outside_opening_hr_fg,
      cancel_in_favour_lidl_plus_fg,
      cancel_in_favour_highest_pos_fg
    )
  )
  WHERE flag_value = TRUE
)
SELECT
  fd.cash_register_event_sid,
  fd.cash_register_event_nr,
  fd.scenario_id,
  fd.country_org_cd,
  fd.store_sid,
  fd.bus_dt,
  fd.event_end_hr,
  ce.cashier_nr,
  IFNULL(fd.cust_sid, -1),
  IFNULL(fd.cust_ident_type_cd, '@'),
  -- special case for Preisanzeige: mark the first operation from the chain by 1, others by 0
  CASE WHEN fd.scenario_id NOT IN (60100, 60200) THEN 1
    WHEN fd.scenario_id IN (60100, 60200) AND MIN(fd.cash_register_event_sid) OVER (PARTITION BY fd.store_sid, fd.bus_dt, group_id) = fd.cash_register_event_sid THEN 1
    ELSE 0 END AS cash_register_event_cnt,
  1 AS cash_register_affected_event_cnt,
  fd.affected_net_val AS cash_register_affected_net_val,
  fd.affected_gross_val AS cash_register_affected_gross_val,
  CURRENT_TIMESTAMP() AS dwh_created_tmsp,
  CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
  ${LOAD_ID} AS dwh_load_id,
  'MANUAL' AS dwh_node_cd
FROM cte_fd_subscen fd
INNER JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION_2` ce 
  ON fd.bus_dt = ce.bus_dt
  AND fd.cashier_hash = ce.cashier_hash
-- Only the receipts that have been inserted in the current run
-- And having sub-scenario ids belonging to the main scenario
-- Eg select a receipt with CANCEL_LAST_POS_EXACT_PAYM_FG only if this receipt is inserted in the previous step (so with scenario id 18)
-- It is obvious that a receipt CANCEL_LAST_POS_EXACT_PAYM_FG has also CANCEL_LAST_POS_FG
-- But it is not obvious whether it has been qualified (passed through thresholds) and inserted in the previous step
-- Function ROUND(scenario_id / 10000) would give 19 for 19070. This logic will work only if the scenarios and subscenarios are consistently defined.
-- WHERE (fd.cash_register_event_sid, ROUND(fd.scenario_id / 10000)) IN
-- (
--   SELECT cash_register_event_sid, scenario_id
--   FROM CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_2
-- )

JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_2` t
  ON fd.cash_register_event_sid = t.cash_register_event_sid
 AND ROUND(fd.scenario_id / 10000) = t.scenario_id
-- Sometimes the sub-scenario can include receipt that do not belong to the main scenario
-- Ex. main scenario is "Geldrückgabe - Originalbon gleicher Tag_2, gleicher Bediener" - and this needs to be used to apply thresholds
-- But the sub-scenario is "Anzahl Geldrückgaben mit Originalbon vom anderen Tag_2 vom selben Bediener" - so the receipts should be qualified even when they do not qualify to the main scenario
OR fd.scenario_id IN (120600, 120800, 130100, 130200)
;




-- Lidl Plus 
-- This scenario has no conditions that evaluate single receipt and therefore there is not flag for it in CORE_DIM.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_2
-- Because of this we use separate SQL(s) to see if usage of same LDL Plus cards is suspiciously high on a give day/month 
--      and insert such receipts directly into CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_2
--


-- Temp table with the receipts.
-- We materialize this in a temp table because otherwise snowflake reads full T_PRODUCT_RETAIL_LINE_2 first ( 300B rows, no filters)
--       and only after that it reads other tables.
-- What we want to happen in the execution plan is the following order T_STORES_QUALIFIED_2 -> T_RETAIL_EVENT_2 -> and only then T_PRODUCT_RETAIL_LINE_2
-- but because snowflake for some unexplicable reason, refuses to pick the optimal order, we split what should have been one query, into two queries
-- Create a temporary table with expiration (equivalent to Snowflake TEMPORARY TABLE)
-- Create a temporary table scoped to the session (BigQuery handles cleanup automatically)
CREATE OR REPLACE TEMP TABLE T_TMP_LDL_PLUS_MISUSE 
-- OPTIONS (
--   expiration_timestamp = TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 0 DAY)
-- )
 AS
WITH mat_params AS (
  SELECT *
  FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_2`
  WHERE SCENARIO_ID = 20 -- Mehfache Verwendung Lidl Plus
),
eval_thresholds AS (
  SELECT
    re.RETAIL_EVENT_SID,
    re.CASH_REGISTER_EVENT_NR,
    re.COUNTRY_ORG_CD,
    re.STORE_SID,
    re.BUS_DT,
    EXTRACT(HOUR FROM re.EVENT_END_TMSP) AS EVENT_END_HR,
    re.CASHIER_HASH,
    ce.CASHIER_NR,
    re.CUST_SID,
    re.CUST_IDENT_TYPE_CD,
    re.TXN_NET_VAL,
    re.TXN_GROSS_VAL,

    COUNT(*) OVER (PARTITION BY re.CUST_SID, re.STORE_SID, ce.CASHIER_NR, re.BUS_DT) AS daily_cnt,
    COUNT(*) OVER (PARTITION BY re.CUST_SID, re.STORE_SID, ce.CASHIER_NR, cd.CAL_MONTH) AS monthly_cnt,

    IF((COUNT(*) OVER (PARTITION BY re.CUST_SID, re.STORE_SID, ce.CASHIER_NR, re.BUS_DT)) >= p_dc.PARAM_VAL_QTY, 1, 0) AS daily_threshold_passed_once,
    IF((COUNT(*) OVER (PARTITION BY re.CUST_SID, re.STORE_SID, ce.CASHIER_NR, cd.CAL_MONTH)) >= p_mc.PARAM_VAL_QTY, 1, 0) AS monthly_threshold_passed_once,

    p_dadt.PARAM_VAL_QTY AS param_passed_days_cnt

  FROM `${BQ_PROJECT_ID}.ETL.T_STORES_QUALIFIED_2` sq
  JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT_2` re_2
    ON re.BUS_DT = sq.BUS_DT
    AND re.STORE_SID = sq.STORE_SID
    AND re.COUNTRY_ORG_CD = sq.COUNTRY_ORG_CD
  JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION_2` ce
    ON ce.CASHIER_HASH = re.CASHIER_HASH
  JOIN `${BQ_PROJECT_ID}.CORE_DIM.T_DIM_CALENDAR_DATE_2` cd
    ON cd.CAL_DT = re.BUS_DT
  JOIN mat_params p_dadt -- param for Days Above Daily Threshold ("Häufung: Anzahl Tage >=")
    ON p_dadt.COUNTRY_ORG_CD = re.COUNTRY_ORG_CD
    AND p_dadt.PARAM_ID = 64
    -- if scneario is not enabled all receipts from that country_2 will be eliminated in the inner join
    AND p_dadt.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
  JOIN mat_params p_dc-- param for daily count ("Anzahl Kassenbons mit Verwendung der gleichen Lidl Plus ID am Tag_2 >=")
	ON p_dc.COUNTRY_ORG_CD = re.COUNTRY_ORG_CD
    AND p_dc.PARAM_ID = 63
    -- if scneario is not enabled all receipts from that country_2 will be eliminated in the inner join
	AND p_dc.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
  JOIN mat_params p_mc-- param for monthly count ("Anzahl Kassenbons mit Verwendung der gleichen Lidl Plus ID im Monat_2 >=")
    ON p_mc.COUNTRY_ORG_CD = re.COUNTRY_ORG_CD
    AND p_mc.PARAM_ID = 62
    -- if scneario is not enabled all receipts from that country_2 will be eliminated in the inner join
    AND p_mc.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
  WHERE 1=1
	AND re.CUST_IDENT_TYPE_CD IS NOT NULL
    AND re.CUST_SID IS NOT NULL
    AND re.TURNOVER_RELEVANT_FG = TRUE
)
SELECT * EXCEPT(param_passed_days_cnt)
FROM (
  SELECT 
    RETAIL_EVENT_SID,
    CASH_REGISTER_EVENT_NR,
    COUNTRY_ORG_CD,
    STORE_SID,
    BUS_DT,
    EVENT_END_HR,
    CASHIER_HASH,
    CASHIER_NR,
    CUST_SID,
    CUST_IDENT_TYPE_CD,
    TXN_NET_VAL,
    TXN_GROSS_VAL,
	-- in how many different dates, the daily threshold is passed
    COUNT(DISTINCT IF(daily_threshold_passed_once > 0, BUS_DT, NULL)) OVER (PARTITION BY CUST_SID, STORE_SID, CASHIER_NR) AS daily_threshold_passes_cnt,
    MAX(monthly_threshold_passed_once) OVER (PARTITION BY CUST_SID, STORE_SID, CASHIER_NR) AS monthly_threshold_passed_in_whole_period,
    param_passed_days_cnt
  FROM eval_thresholds
)
WHERE 
  monthly_threshold_passed_in_whole_period > 0
  OR daily_threshold_passes_cnt >= param_passed_days_cnt
;


INSERT INTO `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASH_REGISTER_EVENT_CLASSIFICATION_2`
(
   CASH_REGISTER_EVENT_SID,
   CASH_REGISTER_EVENT_NR,
   SCENARIO_ID,
   COUNTRY_ORG_CD,
   STORE_SID,
   BUS_DT,
   EVENT_END_HR,
   CASHIER_NR,
   CUST_SID,
   CUST_IDENT_TYPE_CD,
   CASH_REGISTER_EVENT_CNT,
   CASH_REGISTER_EVENT_AFFECTED_LINE_CNT,
   CASH_REGISTER_EVENT_AFFECTED_NET_VAL,
   CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL,
   DWH_CREATED_TMSP,
   DWH_UPDATED_TMSP,
   DWH_LOAD_ID,
   DWH_NODE_CD 
)
SELECT
   qe.RETAIL_EVENT_SID                      AS CASH_REGISTER_EVENT_SID,
   CAST(ANY_VALUE(qe.CASH_REGISTER_EVENT_NR) AS STRING)     AS CASH_REGISTER_EVENT_NR,
   20                                       AS SCENARIO_ID,
   ANY_VALUE(qe.COUNTRY_ORG_CD)             AS COUNTRY_ORG_CD,
   ANY_VALUE(qe.STORE_SID)                  AS STORE_SID,
   ANY_VALUE(qe.BUS_DT)                     AS BUS_DT,
   ANY_VALUE(qe.EVENT_END_HR)               AS EVENT_END_HR,
   ANY_VALUE(qe.CASHIER_NR)                 AS CASHIER_NR,
   ANY_VALUE(qe.CUST_SID)                   AS CUST_SID,
   ANY_VALUE(qe.CUST_IDENT_TYPE_CD)         AS CUST_IDENT_TYPE_CD,

   1                                        AS CASH_REGISTER_EVENT_CNT,
   COUNT(*)                                 AS CASH_REGISTER_EVENT_AFFECTED_LINE_CNT,
   ANY_VALUE(qe.TXN_NET_VAL)                AS CASH_REGISTER_EVENT_AFFECTED_NET_VAL,
   ANY_VALUE(qe.TXN_GROSS_VAL)              AS CASH_REGISTER_EVENT_AFFECTED_GROSS_VAL,
   CURRENT_TIMESTAMP()                      AS DWH_CREATED_TMSP,
   CURRENT_TIMESTAMP()                      AS DWH_UPDATED_TMSP,
   ${LOAD_ID}                               AS DWH_LOAD_ID,
   'CORE_REL'                               AS DWH_NODE_CD
FROM T_TMP_LDL_PLUS_MISUSE qe  
JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE_2` prl
  ON IFNULL(prl.RETAIL_EVENT_SID, -1) = qe.RETAIL_EVENT_SID
  AND prl.BUS_DT = qe.BUS_DT
  AND prl.STORE_SID = qe.STORE_SID
  AND prl.COUNTRY_ORG_CD = qe.COUNTRY_ORG_CD
GROUP BY qe.RETAIL_EVENT_SID
;
