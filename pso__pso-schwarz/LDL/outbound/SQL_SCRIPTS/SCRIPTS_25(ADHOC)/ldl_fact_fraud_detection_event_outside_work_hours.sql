/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_event_outside_work_hours.sql
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2025  Mihail Ivanov  - ZKP GF 	- Initial implementation. Scenario "Transaktionen außerhalb Öffnungszeiten"	
													Requested here https://jira.schwarz/browse/NEOGFPL-71579

#  1.1  02.09.2025  Mihail Ivanov  - ZKP GF 	- Adjusted logic how to take "next event" based on the type of the main event
														updated requirement here https://jira.schwarz/browse/NEOGFPL-71579
														
#  1.2  04.09.2025  Mihail Ivanov  - ZKP GF 	- Mark receipt for the main scenario only if they qualify for at least one sub-scenario
														updated requirement here https://jira.schwarz/browse/NEOGFPL-71579


#  1.3  16.10.2025  Mihail Ivanov  - ZKP GF 	- Bugfix - Parameters for amount of Deposits, Manual Discounts now compared to the sum of relevant lines
																(not to the total amount of the receipt)
														reported here: https://jira.schwarz/browse/NEOGFPL-71660

#  1.4  23.10.2025  Mihail Ivanov  - ZKP GF 	- Bugfix - Added filter to exlcude "aborted" and "suspended" receipts from "Storno" sub-scenarios
														reported here: https://jira.schwarz/browse/NEOGFPL-71671
														
#  1.5  11.11.2025  Mihail Ivanov  - ZKP GF 	- Bugfix - Threshold "Gesamtwert Rabattwert manuell > X LW" now compared to discount amount (not retail amount)
														reported here: https://jira.schwarz/browse/NEOGFPL-71748
*/

-- all events with the main flag RECEIPT_OUTSIDE_OPENING_HR_FG
-- some of the simple sub-scenarios are also calculated here
-- the Cancellation (Storno) and Return subs-scenarios are more complex and they are calculated later in another temp tables


CREATE OR REPLACE TEMPORARY TABLE t_main_events AS WITH MAT_PARAMS AS (SELECT *
  FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE scenario_id = 74 -- Transaktionen außerhalb Öffnungszeiten
   AND is_scenario_enabled_in_country_fg), EVENTS_OUTSIDE_WORK_HOURS AS (SELECT RE.retail_event_sid,
   RE.cash_register_event_nr,
   RE.event_start_tmsp,
   RE.bus_dt,
   RE.cash_register_sid,
   RE.store_sid,
   RE.cashier_hash,
   RE.txn_net_val,
   RE.txn_gross_val,
   RE.curr_cd,
   RE.cancel_fg,
   RE.suspend_fg,
   RE.country_org_cd,
   RE.retail_event_type_cd,
   RE.turnover_relevant_fg
  FROM ${FWRK_WORK_DB}.vt1
   INNER JOIN ldl_data_core_rel.t_retail_event AS RE ON vt1.country_cd = RE.country_org_cd AND vt1.dwh_cal_dt = RE.bus_dt
       AND vt1.loc_sid = RE.store_sid
   INNER JOIN ldl_data_core_rel.t_store_opening_hours AS SOH ON RE.store_sid = SOH.store_sid AND EXTRACT(DAYOFWEEK FROM
        RE.bus_dt) - 1 = SOH.day_of_week AND SOH.dwh_valid_fg
   INNER JOIN MAT_PARAMS AS obo -- offset before opening
        ON RE.country_org_cd = obo.country_org_cd AND obo.param_id = 136
   INNER JOIN MAT_PARAMS AS oac -- offset after closing
        ON RE.country_org_cd = oac.country_org_cd AND oac.param_id = 137
  WHERE 
   -- exclude training receipts
   RE.retail_event_scenario_id NOT IN (101, 151, 201, 251, 301, 351)
   -- take only receipts that are some time before opening or after closing
   AND (TIME(RE.event_start_tmsp) <= TIME_ADD(SOH.open_tm, INTERVAL CAST(- 1 * obo.param_val_qty AS INTEGER) MINUTE)
       OR TIME(RE.event_end_tmsp) >= TIME_ADD(SOH.close_tm, INTERVAL CAST(oac.param_val_qty AS INTEGER) MINUTE))
  -- force the CTE to be executed as a whole, which will limit greatly the number of events
  -- once we have only the small number of events that are outside work hours, they will act as filter for the big tables with RETAIL and DISCOUNT lines
  QUALIFY (COUNT(*) OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0), EVENT_LINE_STATS AS (SELECT
   re.retail_event_sid,
   ANY_VALUE(re.cash_register_event_nr) AS cash_register_event_nr,
   ANY_VALUE(re.event_start_tmsp) AS event_start_tmsp,
   ANY_VALUE(re.bus_dt) AS bus_dt,
   ANY_VALUE(re.cash_register_sid) AS cash_register_sid,
   ANY_VALUE(re.store_sid) AS store_sid,
   ANY_VALUE(re.cashier_hash) AS cashier_hash,
   ANY_VALUE(re.txn_net_val) AS txn_net_val,
   ANY_VALUE(re.txn_gross_val) AS txn_gross_val,
   ANY_VALUE(re.curr_cd) AS curr_cd,
   ANY_VALUE(re.cancel_fg) AS cancel_fg,
   ANY_VALUE(re.suspend_fg) AS suspend_fg,
   ANY_VALUE(re.country_org_cd) AS country_org_cd,
   ANY_VALUE(re.retail_event_type_cd) AS retail_event_type_cd,
   ANY_VALUE(re.turnover_relevant_fg) AS turnover_relevant_fg,
   MAX(PRL.orig_sales_event_sid) AS orig_sales_event_sid,
   SUM(CASE
     WHEN re.retail_event_type_cd = 'S' AND re.turnover_relevant_fg AND PRL.turnover_relevant_fg AND PRL.prod_retail_line_type_cd
        = 'D'
     THEN 1
     ELSE 0
     END) AS returned_deposit_line_cnt,
   SUM(CASE
     WHEN re.retail_event_type_cd = 'S' AND re.turnover_relevant_fg AND PRL.turnover_relevant_fg AND PRL.prod_retail_line_type_cd
        = 'D'
     THEN PRL.retail_line_gross_val
     ELSE 0
     END) AS returned_deposit_gross_val,
   SUM(CASE
     WHEN re.retail_event_type_cd = 'S' AND re.turnover_relevant_fg AND PRL.turnover_relevant_fg AND PRL.prod_retail_line_type_cd
          = 'D' AND PRL.prod_entry_method_cd IN ('KE', 'DV') AND LENGTH(PRL.prod_variant_input_nr) < 19
     THEN 1
     ELSE 0
     END) AS return_deposit_manual_input_line_cnt,
   SUM(CASE
     WHEN re.retail_event_type_cd = 'S' AND re.turnover_relevant_fg AND PRL.turnover_relevant_fg AND PRL.prod_retail_line_type_cd
          = 'D' AND PRL.prod_entry_method_cd IN ('KE', 'DV') AND LENGTH(PRL.prod_variant_input_nr) < 19
     THEN PRL.retail_line_gross_val
     ELSE 0
     END) AS return_deposit_manual_input_gross_val,
   SUM(CASE
     WHEN re.retail_event_type_cd = 'S' AND re.turnover_relevant_fg AND PRL.turnover_relevant_fg AND PRL.prod_retail_line_type_cd
        NOT IN ('D', 'SD')
     THEN 1
     ELSE 0
     END) AS non_deposit_line_cnt,
   SUM(CASE
     WHEN re.retail_event_type_cd = 'S' AND re.turnover_relevant_fg AND PRL.turnover_relevant_fg AND PRL.prod_retail_line_type_cd
        NOT IN ('D', 'SD')
     THEN PRL.retail_line_gross_val
     ELSE 0
     END) AS non_deposit_line_gross_vall,
   SUM(CASE
     WHEN DL.retail_event_line_scenario_id BETWEEN 400 AND 599 AND (NOT LENGTH(PRL.prod_variant_input_nr) BETWEEN 15 AND
         17 OR PRL.prod_variant_input_nr NOT LIKE '55%' AND PRL.prod_variant_input_nr NOT LIKE '56%')
     THEN 1
     ELSE 0
     END) AS manual_discount_line_cnt,
   SUM(CASE
     WHEN DL.retail_event_line_scenario_id BETWEEN 400 AND 599 AND (NOT LENGTH(PRL.prod_variant_input_nr) BETWEEN 15 AND
         17 OR PRL.prod_variant_input_nr NOT LIKE '55%' AND PRL.prod_variant_input_nr NOT LIKE '56%')
     THEN ABS(DL.discount_val)
     ELSE 0
     END) AS manual_discount_line_gross_val
  FROM EVENTS_OUTSIDE_WORK_HOURS AS re
   INNER JOIN ldl_data_core_rel.t_product_retail_line AS PRL ON re.retail_event_sid = PRL.retail_event_sid AND re.country_org_cd
       = PRL.country_org_cd AND re.bus_dt = PRL.bus_dt
   LEFT JOIN ldl_data_core_rel.t_discount_line AS DL ON re.retail_event_sid = DL.retail_event_sid AND PRL.retail_event_line_seq
         = DL.discounted_line_seq AND re.country_org_cd = DL.country_org_cd AND re.bus_dt = DL.bus_dt AND DL.bus_dt
     BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
  GROUP BY re.retail_event_sid) (SELECT els.retail_event_sid AS main_event_sid,
   els.cash_register_event_nr,
   els.event_start_tmsp,
   els.bus_dt,
   els.cash_register_sid,
   els.store_sid,
   els.cashier_hash,
   els.txn_net_val,
   els.txn_gross_val,
   els.curr_cd,
   els.country_org_cd,
   els.retail_event_type_cd,
   els.turnover_relevant_fg,
   els.orig_sales_event_sid AS orig_event_sid,
   1 AS receipt_outside_opening_hr_fg,
   IF(els.suspend_fg AND els.txn_gross_val >= sr_ma.param_val_qty, 1, 0) AS receipt_outside_opening_hr_suspend_fg,
   IF(els.cancel_fg AND els.txn_gross_val >= ar_ma.param_val_qty, 1, 0) AS receipt_outside_opening_hr_abort_fg,
   IF(els.returned_deposit_line_cnt > 0 AND els.non_deposit_line_cnt = 0 AND els.returned_deposit_gross_val >= pdep_ma.param_val_qty
      , 1, 0) AS receipt_outside_opening_hr_deposit_only_fg,
   IF(els.return_deposit_manual_input_line_cnt > 0 AND els.return_deposit_manual_input_gross_val >= mdep_ma.param_val_qty
      , 1, 0) AS receipt_outside_opening_hr_manual_deposit_fg,
   IF(els.manual_discount_line_cnt > 0 AND els.manual_discount_line_gross_val >= disc_ma.param_val_qty, 1, 0) AS
   receipt_outside_opening_hr_manual_discount_fg
  FROM EVENT_LINE_STATS AS els
   INNER JOIN MAT_PARAMS AS sr_ma -- suspended receipt minimum amount ("Bonrückstellungswert > X LW")
        ON els.country_org_cd = sr_ma.country_org_cd AND sr_ma.param_id = 140
   INNER JOIN MAT_PARAMS AS ar_ma -- aborted receipt minimum amount ("Bonabbruchwert > X LW")
        ON els.country_org_cd = ar_ma.country_org_cd AND ar_ma.param_id = 141
   INNER JOIN MAT_PARAMS AS disc_ma -- receipt with manual discount minimum amount ("Gesamtwert Rabattwert manuell > X LW")
        ON els.country_org_cd = disc_ma.country_org_cd AND disc_ma.param_id = 142
   INNER JOIN MAT_PARAMS AS mdep_ma -- receipt with manual deposit minimum amount ("Gesamtwert manuelles Pfand > X LW")
        ON els.country_org_cd = mdep_ma.country_org_cd AND mdep_ma.param_id = 143
   INNER JOIN MAT_PARAMS AS pdep_ma -- receipt with pure depositminimum amount ("Gesamtwert reines Pfand > X LW")
        ON els.country_org_cd = pdep_ma.country_org_cd AND pdep_ma.param_id = 144);


-- original purchase in case the main event is Return
CREATE OR REPLACE TEMPORARY TABLE t_tmp_main_and_next_event AS WITH ORIG_EVENT AS (SELECT SE.main_event_sid,
   SE.orig_event_sid,
   ORIG_RE.bus_dt AS orig_bus_dt,
   ORIG_RE.country_org_cd AS orig_country_org_cd,
   ORIG_RE.cash_register_sid AS orig_cash_register_sid,
   ORIG_RE.cash_register_event_nr AS orig_cash_register_event_nr
  FROM t_main_events AS SE
   INNER JOIN ldl_data_core_rel.t_retail_event AS ORIG_RE ON SE.orig_event_sid = ORIG_RE.retail_event_sid AND SE.country_org_cd
       = ORIG_RE.country_org_cd 
       -- we assume any Original Purchase for a Return is made at most 360 days before the return. 
       AND ORIG_RE.bus_dt > DATE_SUB(SE.bus_dt, INTERVAL 360 DAY)),
 -- a list of Days+CashRegister  that will act as a filter - we will be looking for following events only for these tuples of (bus_Dt, cash_register_sid)
 DAYS_AND_CASH_REGISTERS_FILTER AS (SELECT bus_dt,
    country_org_cd,
    cash_register_sid
   FROM t_main_events AS SE
   UNION DISTINCT
   SELECT orig_bus_dt,
    orig_country_org_cd,
    orig_cash_register_sid
   FROM ORIG_EVENT), 
 -- waiting Lucas Kaiser to confirm what should be included in this list of Events ( only Sales? Sales+Return? Sales+Return+Tech? ... )
 POTENTIAL_NEXT_EVENTS AS (SELECT RE.retail_event_sid AS cash_register_event_sid,
   RE.cash_register_event_nr,
   RE.bus_dt,
   RE.cash_register_sid,
   CE.cashier_nr,
   RE.retail_event_type_cd
  FROM DAYS_AND_CASH_REGISTERS_FILTER AS f
   INNER JOIN ldl_data_core_rel.t_retail_event AS RE ON f.bus_dt = RE.bus_dt AND f.country_org_cd = RE.country_org_cd
    AND f.cash_register_sid = RE.cash_register_sid
   INNER JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption AS CE ON RE.cashier_hash = CE.cashier_hash
  WHERE RE.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
   AND CE.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
   AND RE.turnover_relevant_fg), 
 -- the logic for "next event" is different depending on the type of the main event (return or sale event)
 -- but this keeps it consisten with the logics used in the "Returns" scenarios and "storno" scenarios
 EVENT_AFTER_MAIN_EVENT AS (
   -- for main events which are Returns, the "next event" should be the next purchase or otherwise said "next sales event"
   SELECT t9.main_event_sid,
    t9.cash_register_event_nr,
    t9.event_start_tmsp,
    t9.bus_dt,
    t9.cash_register_sid,
    t9.store_sid,
    t9.cashier_hash,
    t9.txn_net_val,
    t9.txn_gross_val,
    t9.curr_cd,
    t9.country_org_cd,
    t9.retail_event_type_cd,
    t9.turnover_relevant_fg,
    t9.orig_event_sid,
    t9.receipt_outside_opening_hr_fg,
    t9.receipt_outside_opening_hr_suspend_fg,
    t9.receipt_outside_opening_hr_abort_fg,
    t9.receipt_outside_opening_hr_deposit_only_fg,
    t9.receipt_outside_opening_hr_manual_deposit_fg,
    t9.receipt_outside_opening_hr_manual_discount_fg,
    t9.event_after_main_event_sid
   FROM (SELECT SE.main_event_sid,
      SE.cash_register_event_nr,
      SE.event_start_tmsp,
      SE.bus_dt,
      SE.cash_register_sid,
      SE.store_sid,
      SE.cashier_hash,
      SE.txn_net_val,
      SE.txn_gross_val,
      SE.curr_cd,
      SE.country_org_cd,
      SE.retail_event_type_cd,
      SE.turnover_relevant_fg,
      SE.orig_event_sid,
      SE.receipt_outside_opening_hr_fg,
      SE.receipt_outside_opening_hr_suspend_fg,
      SE.receipt_outside_opening_hr_abort_fg,
      SE.receipt_outside_opening_hr_deposit_only_fg,
      SE.receipt_outside_opening_hr_manual_deposit_fg,
      SE.receipt_outside_opening_hr_manual_discount_fg,
      pne.cash_register_event_sid AS event_after_main_event_sid,
      pne.cash_register_event_nr AS cash_register_event_nr0
     FROM t_main_events AS SE
      -- some events are late, after store is closing and there is high chance that they are the last event for the day
      LEFT JOIN POTENTIAL_NEXT_EVENTS AS pne ON SE.bus_dt = pne.bus_dt AND SE.cash_register_sid = pne.cash_register_sid
        AND SE.cash_register_event_nr < pne.cash_register_event_nr AND pne.retail_event_type_cd = 'S'
     WHERE SE.retail_event_type_cd = 'R'
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(SE.main_event_sid AS STRING) ORDER BY cash_register_event_nr0 IS NULL
           , cash_register_event_nr0)) = 1) AS t9
   UNION ALL
   -- for main events which are type Sales Event, the "next event"  could be any type of event, Sales or Return
   SELECT t21.main_event_sid,
    t21.cash_register_event_nr,
    t21.event_start_tmsp,
    t21.bus_dt,
    t21.cash_register_sid,
    t21.store_sid,
    t21.cashier_hash,
    t21.txn_net_val,
    t21.txn_gross_val,
    t21.curr_cd,
    t21.country_org_cd,
    t21.retail_event_type_cd,
    t21.turnover_relevant_fg,
    t21.orig_event_sid,
    t21.receipt_outside_opening_hr_fg,
    t21.receipt_outside_opening_hr_suspend_fg,
    t21.receipt_outside_opening_hr_abort_fg,
    t21.receipt_outside_opening_hr_deposit_only_fg,
    t21.receipt_outside_opening_hr_manual_deposit_fg,
    t21.receipt_outside_opening_hr_manual_discount_fg,
    t21.event_after_main_event_sid
   FROM (SELECT SE.main_event_sid,
      SE.cash_register_event_nr,
      SE.event_start_tmsp,
      SE.bus_dt,
      SE.cash_register_sid,
      SE.store_sid,
      SE.cashier_hash,
      SE.txn_net_val,
      SE.txn_gross_val,
      SE.curr_cd,
      SE.country_org_cd,
      SE.retail_event_type_cd,
      SE.turnover_relevant_fg,
      SE.orig_event_sid,
      SE.receipt_outside_opening_hr_fg,
      SE.receipt_outside_opening_hr_suspend_fg,
      SE.receipt_outside_opening_hr_abort_fg,
      SE.receipt_outside_opening_hr_deposit_only_fg,
      SE.receipt_outside_opening_hr_manual_deposit_fg,
      SE.receipt_outside_opening_hr_manual_discount_fg,
      pne.cash_register_event_sid AS event_after_main_event_sid,
      pne.cash_register_event_nr AS cash_register_event_nr0
     FROM t_main_events AS SE
      -- some events are late, after store is closing and there is high chance that they are the last event for the day
      LEFT JOIN POTENTIAL_NEXT_EVENTS AS pne ON SE.bus_dt = pne.bus_dt AND SE.cash_register_sid = pne.cash_register_sid
       AND SE.cash_register_event_nr < pne.cash_register_event_nr
     WHERE SE.retail_event_type_cd = 'S'
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(SE.main_event_sid AS STRING) ORDER BY cash_register_event_nr0 IS NULL
           , cash_register_event_nr0)) = 1) AS t21) 
 -- add the SID of the event after the original event. 
 -- Only "Returns" have original event associated with them, so we are using the logic for "Returns" and looking for next event of type "Sale"
 (SELECT t34.main_event_sid,
   t34.cash_register_event_nr,
   t34.event_start_tmsp,
   t34.bus_dt,
   t34.cash_register_sid,
   t34.store_sid,
   t34.cashier_hash,
   t34.txn_net_val,
   t34.txn_gross_val,
   t34.curr_cd,
   t34.country_org_cd,
   t34.retail_event_type_cd,
   t34.turnover_relevant_fg,
   t34.orig_event_sid,
   t34.receipt_outside_opening_hr_fg,
   t34.receipt_outside_opening_hr_suspend_fg,
   t34.receipt_outside_opening_hr_abort_fg,
   t34.receipt_outside_opening_hr_deposit_only_fg,
   t34.receipt_outside_opening_hr_manual_deposit_fg,
   t34.receipt_outside_opening_hr_manual_discount_fg,
   t34.event_after_main_event_sid,
   t34.event_after_orig_event_sid
  FROM (SELECT se.main_event_sid,
     se.cash_register_event_nr,
     se.event_start_tmsp,
     se.bus_dt,
     se.cash_register_sid,
     se.store_sid,
     se.cashier_hash,
     se.txn_net_val,
     se.txn_gross_val,
     se.curr_cd,
     se.country_org_cd,
     se.retail_event_type_cd,
     se.turnover_relevant_fg,
     se.orig_event_sid,
     se.receipt_outside_opening_hr_fg,
     se.receipt_outside_opening_hr_suspend_fg,
     se.receipt_outside_opening_hr_abort_fg,
     se.receipt_outside_opening_hr_deposit_only_fg,
     se.receipt_outside_opening_hr_manual_deposit_fg,
     se.receipt_outside_opening_hr_manual_discount_fg,
     se.event_after_main_event_sid,
     pne.cash_register_event_sid AS event_after_orig_event_sid,
     pne.cash_register_event_nr AS cash_register_event_nr0
    FROM EVENT_AFTER_MAIN_EVENT AS se
     LEFT JOIN ORIG_EVENT AS oe ON se.main_event_sid = oe.main_event_sid
     LEFT JOIN POTENTIAL_NEXT_EVENTS AS pne ON oe.orig_bus_dt = pne.bus_dt AND oe.orig_cash_register_sid = pne.cash_register_sid
          AND pne.retail_event_type_cd = 'S' AND oe.orig_cash_register_event_nr < pne.cash_register_event_nr
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(se.main_event_sid AS STRING) ORDER BY cash_register_event_nr0 IS NULL
          , cash_register_event_nr0)) = 1) AS t34);

-----------------------------------------------------------------------
-----------------------------------------------------------------------
--
--      STORNO
--
-----------------------------------------------------------------------
-----------------------------------------------------------------------

CREATE OR REPLACE TEMPORARY TABLE t_tmp_cancellations AS WITH EVENT_LINES AS (SELECT ME.main_event_sid,
   ME.cash_register_event_nr,
   ME.event_start_tmsp,
   ME.bus_dt,
   ME.cash_register_sid,
   ME.store_sid,
   ME.cashier_hash,
   ME.txn_net_val,
   ME.txn_gross_val,
   ME.curr_cd,
   ME.country_org_cd,
   ME.retail_event_type_cd,
   ME.turnover_relevant_fg,
   ME.orig_event_sid,
   ME.receipt_outside_opening_hr_fg,
   ME.receipt_outside_opening_hr_suspend_fg,
   ME.receipt_outside_opening_hr_abort_fg,
   ME.receipt_outside_opening_hr_deposit_only_fg,
   ME.receipt_outside_opening_hr_manual_deposit_fg,
   ME.receipt_outside_opening_hr_manual_discount_fg,
   ME.event_after_main_event_sid,
   ME.event_after_orig_event_sid,
   PRL.prod_entry_method_cd,
   PRL.local_prod_nr,
   PRL.retail_event_line_seq,
   PRL.cancel_line_seq,
   PRL.prod_variant_input_nr,
   PRL.retail_line_gross_val,
   IFNULL(PRL.prod_variant_cnt, PRL.prod_variant_qty) AS prod_variant_qtyx,
    CASE
    WHEN PRL.retail_line_gross_val > 0 AND IFNULL(PRL.prod_variant_cnt, PRL.prod_variant_qty) < 50 AND PRL.cancel_line_seq
     IS NOT NULL
    THEN 1
    ELSE 0
    END AS cancelled_line_fg,
   ROW_NUMBER() OVER (PARTITION BY CAST(PRL.retail_event_sid AS STRING) ORDER BY PRL.event_start_tmsp IS NULL, PRL.event_start_tmsp
      , PRL.retail_event_line_seq IS NULL, PRL.retail_event_line_seq) AS line_rn
  FROM t_tmp_main_and_next_event AS ME
   INNER JOIN ldl_data_core_rel.t_product_retail_line AS PRL ON ME.main_event_sid = PRL.retail_event_sid AND ME.bus_dt =
      PRL.bus_dt AND ME.country_org_cd = PRL.country_org_cd
  WHERE ME.retail_event_type_cd = 'S'
   AND ME.turnover_relevant_fg), 
 -- for "doppletipper" evaluation we need to assign same GROUP_ID to consecutive lines if they are for same product, same quantity and lines are scanned
 EVENT_LINES_CHANGE_FLAG AS (SELECT main_event_sid,
   cash_register_event_nr,
   event_start_tmsp,
   bus_dt,
   cash_register_sid,
   store_sid,
   cashier_hash,
   txn_net_val,
   txn_gross_val,
   curr_cd,
   country_org_cd,
   retail_event_type_cd,
   turnover_relevant_fg,
   orig_event_sid,
   receipt_outside_opening_hr_fg,
   receipt_outside_opening_hr_suspend_fg,
   receipt_outside_opening_hr_abort_fg,
   receipt_outside_opening_hr_deposit_only_fg,
   receipt_outside_opening_hr_manual_deposit_fg,
   receipt_outside_opening_hr_manual_discount_fg,
   event_after_main_event_sid,
   event_after_orig_event_sid,
   prod_entry_method_cd,
   local_prod_nr,
   retail_event_line_seq,
   cancel_line_seq,
   prod_variant_input_nr,
   retail_line_gross_val,
   prod_variant_qtyx,
   cancelled_line_fg,
   line_rn,
    --Doppeltipper: mark row if this and the previous row were scanned
    CASE
    WHEN (LAG(prod_entry_method_cd) OVER (PARTITION BY CAST(main_event_sid AS STRING) ORDER BY line_rn IS NULL, line_rn
        )) IS NOT DISTINCT FROM prod_entry_method_cd AND prod_entry_method_cd = 'SC'
    THEN 1
    ELSE 0
    END AS curr_and_prev_scanned_fg,
    --Doppeltipper: mark row as not changed only when the item and quantity are the same as in a previous row and when this is the consecutive scan
    CASE
    WHEN CASE
        WHEN (LAG(prod_entry_method_cd) OVER (PARTITION BY CAST(main_event_sid AS STRING) ORDER BY line_rn IS NULL,
              line_rn)) IS NOT DISTINCT FROM prod_entry_method_cd AND prod_entry_method_cd = 'SC'
        THEN 1
        ELSE 0
        END = 1 AND (LAG(local_prod_nr) OVER (PARTITION BY CAST(main_event_sid AS STRING) ORDER BY line_rn IS NULL,
           line_rn)) IS NOT DISTINCT FROM local_prod_nr AND (LAG(prod_variant_qtyx) OVER (PARTITION BY CAST(main_event_sid AS STRING)
          ORDER BY line_rn IS NULL, line_rn)) IS NOT DISTINCT FROM prod_variant_qtyx
    THEN 0
    ELSE 1
    END AS change_fg
  FROM EVENT_LINES AS l), EVENT_LINES_GROUPS AS (SELECT main_event_sid,
   cash_register_event_nr,
   event_start_tmsp,
   bus_dt,
   cash_register_sid,
   store_sid,
   cashier_hash,
   txn_net_val,
   txn_gross_val,
   curr_cd,
   country_org_cd,
   retail_event_type_cd,
   turnover_relevant_fg,
   orig_event_sid,
   receipt_outside_opening_hr_fg,
   receipt_outside_opening_hr_suspend_fg,
   receipt_outside_opening_hr_abort_fg,
   receipt_outside_opening_hr_deposit_only_fg,
   receipt_outside_opening_hr_manual_deposit_fg,
   receipt_outside_opening_hr_manual_discount_fg,
   event_after_main_event_sid,
   event_after_orig_event_sid,
   prod_entry_method_cd,
   local_prod_nr,
   retail_event_line_seq,
   cancel_line_seq,
   prod_variant_input_nr,
   retail_line_gross_val,
   prod_variant_qtyx,
   cancelled_line_fg,
   line_rn,
   curr_and_prev_scanned_fg,
   change_fg,
   SUM(change_fg) OVER (PARTITION BY CAST(main_event_sid AS STRING) ORDER BY line_rn IS NULL, line_rn ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
  FROM EVENT_LINES_CHANGE_FLAG AS l), MANUAL_DISCOUNT_PRODS AS (
   -- it is possible to have two discounts for same ProductRetailLine, and we just want 1 row per ProductRetailLine
   SELECT l.main_event_sid,
   l.local_prod_nr
  FROM EVENT_LINES_GROUPS AS l
   INNER JOIN ldl_data_core_rel.t_discount_line AS D ON l.main_event_sid = D.retail_event_sid AND l.country_org_cd = D.country_org_cd
             AND l.bus_dt = D.bus_dt AND l.retail_event_line_seq = D.discounted_line_seq AND l.cancel_line_seq IS NULL
       AND D.retail_event_line_scenario_id BETWEEN 400 AND 599 AND ABS(D.discount_val) >= 0.011 AND (NOT LENGTH(l.prod_variant_input_nr
         ) BETWEEN 15 AND 17 OR l.prod_variant_input_nr NOT LIKE '55%' AND l.prod_variant_input_nr NOT LIKE '56%') AND D
     .bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
  GROUP BY l.main_event_sid,
   l.local_prod_nr), 
 -- lines of event with suspicious cancellation, but we have to exclude cancelled lines if they exist in next receipt or we have manual discount for same product in this receipt
 EVENT_LINES_FILTERED AS (
   -- Lines that are NOT cancelled. We need the to compare counts for double-tap 
   --    and also to check if there are manual discounts for products which are not cancelled
   SELECT l.main_event_sid,
    l.cash_register_event_nr,
    l.event_start_tmsp,
    l.bus_dt,
    l.cash_register_sid,
    l.store_sid,
    l.cashier_hash,
    l.txn_net_val,
    l.txn_gross_val,
    l.curr_cd,
    l.country_org_cd,
    l.retail_event_type_cd,
    l.turnover_relevant_fg,
    l.orig_event_sid,
    l.receipt_outside_opening_hr_fg,
    l.receipt_outside_opening_hr_suspend_fg,
    l.receipt_outside_opening_hr_abort_fg,
    l.receipt_outside_opening_hr_deposit_only_fg,
    l.receipt_outside_opening_hr_manual_deposit_fg,
    l.receipt_outside_opening_hr_manual_discount_fg,
    l.event_after_main_event_sid,
    l.event_after_orig_event_sid,
    l.prod_entry_method_cd,
    l.local_prod_nr,
    l.retail_event_line_seq,
    l.cancel_line_seq,
    l.prod_variant_input_nr,
    l.retail_line_gross_val,
    l.prod_variant_qtyx,
    l.cancelled_line_fg,
    l.line_rn,
    l.curr_and_prev_scanned_fg,
    l.change_fg,
    l.group_id,
     CASE
     WHEN t9.main_event_sid IS NULL
     THEN 0
     ELSE 1
     END AS is_prod_with_manual_discount_fg
   FROM EVENT_LINES_GROUPS AS l
    LEFT JOIN (SELECT DISTINCT *
     FROM MANUAL_DISCOUNT_PRODS AS mdp) AS t9 ON l.main_event_sid = t9.main_event_sid AND l.local_prod_nr = t9.local_prod_nr
      
   WHERE l.cancelled_line_fg = 0
   UNION ALL
   -- Lines that are cancelled but for the Product there is no Manual Discount and it does not exist in next receipt
   SELECT l.main_event_sid,
    l.cash_register_event_nr,
    l.event_start_tmsp,
    l.bus_dt,
    l.cash_register_sid,
    l.store_sid,
    l.cashier_hash,
    l.txn_net_val,
    l.txn_gross_val,
    l.curr_cd,
    l.country_org_cd,
    l.retail_event_type_cd,
    l.turnover_relevant_fg,
    l.orig_event_sid,
    l.receipt_outside_opening_hr_fg,
    l.receipt_outside_opening_hr_suspend_fg,
    l.receipt_outside_opening_hr_abort_fg,
    l.receipt_outside_opening_hr_deposit_only_fg,
    l.receipt_outside_opening_hr_manual_deposit_fg,
    l.receipt_outside_opening_hr_manual_discount_fg,
    l.event_after_main_event_sid,
    l.event_after_orig_event_sid,
    l.prod_entry_method_cd,
    l.local_prod_nr,
    l.retail_event_line_seq,
    l.cancel_line_seq,
    l.prod_variant_input_nr,
    l.retail_line_gross_val,
    l.prod_variant_qtyx,
    l.cancelled_line_fg,
    l.line_rn,
    l.curr_and_prev_scanned_fg,
    l.change_fg,
    l.group_id,
    0 AS is_prod_with_manual_discount_fg
   FROM EVENT_LINES_GROUPS AS l
    LEFT JOIN (SELECT DISTINCT *
     FROM MANUAL_DISCOUNT_PRODS AS mdp) AS t22 ON l.main_event_sid = t22.main_event_sid AND l.local_prod_nr = t22.local_prod_nr
      
   WHERE l.cancelled_line_fg = 1
    AND t22.main_event_sid IS NULL
    AND NOT EXISTS (SELECT 1
     FROM ldl_data_core_rel.t_product_retail_line AS NE_L
     WHERE retail_event_sid = l.event_after_main_event_sid
      AND bus_dt = l.bus_dt
      AND country_org_cd = l.country_org_cd
      AND local_prod_nr = l.local_prod_nr
      AND bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT)), EVENT_GROUP_COUNTS AS (SELECT
   main_event_sid,
   group_id,
   ANY_VALUE(country_org_cd) AS country_org_cd,
   COUNT(*) AS lines_per_group, -- count of lines per group
   SUM(cancelled_line_fg) AS gen_cancel_lines_per_group, -- count of generic cancelled lines
   SUM(retail_line_gross_val * cancelled_line_fg) AS cancel_gross_val_per_group,
   SUM(prod_variant_qtyx * cancelled_line_fg) AS cancel_qty_per_group
  FROM EVENT_LINES_FILTERED
  GROUP BY main_event_sid,
   group_id
  -- eliminate "doppletipper" situation where 1 item is scanned twice by mistake and remove once to fix the mistake
  -- so we exclude situations with multiple scans and 1 cancel
  -- situations more than 1 cancel are not excluded intentionally.
  -- for example scanning one item 3 times "by mistake" and having to remove 2 scans seems suspicious ... 
  HAVING gen_cancel_lines_per_group > 0 AND (lines_per_group <= 1 OR gen_cancel_lines_per_group <> 1)), EVENT_COUNTS AS
  (SELECT main_event_sid,
   ANY_VALUE(country_org_cd) AS country_org_cd,
   SUM(cancel_gross_val_per_group) AS cancel_gross_val_per_event,
   SUM(cancel_qty_per_group) AS cancel_qty_per_event,
   SUM(gen_cancel_lines_per_group) AS gen_cancel_lines_per_event,
   1 AS event_with_cancel_fg
  FROM EVENT_GROUP_COUNTS
  GROUP BY main_event_sid), MATERIALIZE_PARAM_VIEW AS (SELECT *
  FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE scenario_id = 74
   AND is_scenario_enabled_in_country_fg) (SELECT ec.main_event_sid,
   ec.country_org_cd,
   ec.cancel_gross_val_per_event,
   ec.cancel_qty_per_event,
   ec.gen_cancel_lines_per_event,
   ec.event_with_cancel_fg
  FROM EVENT_COUNTS AS ec
   INNER JOIN MATERIALIZE_PARAM_VIEW AS p_ca -- parameter "cancelled amount" / "Gesamtsumme der stornierten Artikel > X LW"
        ON ec.country_org_cd = p_ca.country_org_cd AND p_ca.param_id = 138
  WHERE ec.cancel_gross_val_per_event >= p_ca.param_val_qty);

-----------------------------------------------------------------------
-----------------------------------------------------------------------
--
--      RETURNs
--
-----------------------------------------------------------------------
-----------------------------------------------------------------------

CREATE OR REPLACE TEMPORARY TABLE t_tmp_returns AS WITH MATERIALIZE_PARAM_VIEW AS (SELECT *
  FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE scenario_id = 74
   AND is_scenario_enabled_in_country_fg), RETURNS_FILTERED_BY_AMOUNT AS (SELECT ME.main_event_sid,
   ME.cash_register_event_nr,
   ME.event_start_tmsp,
   ME.bus_dt,
   ME.cash_register_sid,
   ME.store_sid,
   ME.cashier_hash,
   ME.txn_net_val,
   ME.txn_gross_val,
   ME.curr_cd,
   ME.country_org_cd,
   ME.retail_event_type_cd,
   ME.turnover_relevant_fg,
   ME.orig_event_sid,
   ME.receipt_outside_opening_hr_fg,
   ME.receipt_outside_opening_hr_suspend_fg,
   ME.receipt_outside_opening_hr_abort_fg,
   ME.receipt_outside_opening_hr_deposit_only_fg,
   ME.receipt_outside_opening_hr_manual_deposit_fg,
   ME.receipt_outside_opening_hr_manual_discount_fg,
   ME.event_after_main_event_sid,
   ME.event_after_orig_event_sid
  FROM t_tmp_main_and_next_event AS ME
   INNER JOIN MATERIALIZE_PARAM_VIEW AS p_ra -- parameter for Returned Amount / "Geldrückgabenwert > X LW"
        ON ME.country_org_cd = p_ra.country_org_cd AND p_ra.param_id = 139
   LEFT JOIN ldl_data_core_rel.t_retail_event AS PAME -- purchase after main event
        ON ME.bus_dt = PAME.bus_dt AND ME.country_org_cd = PAME.country_org_cd
        AND ME.event_after_main_event_sid = PAME.retail_event_sid AND PAME.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
   LEFT JOIN ldl_data_core_rel.t_retail_event AS PAOE -- purchase after original event
        ON ME.country_org_cd = PAOE.country_org_cd AND ME.event_after_orig_event_sid
        = PAOE.retail_event_sid AND PAOE.bus_dt BETWEEN DATE_SUB(ME.bus_dt, INTERVAL 360 DAY) AND ME.bus_dt AND PAOE.bus_dt
     BETWEEN DATE_SUB(DATE($MIN_DWH_CAL_DT), INTERVAL 360 DAY) AND $MAX_DWH_CAL_DT
  WHERE ME.retail_event_type_cd = 'R'
   AND ME.turnover_relevant_fg
   AND (PAME.retail_event_sid IS NULL OR PAME.txn_gross_val <> ABS(ME.txn_gross_val))
   AND (PAOE.retail_event_sid IS NULL OR PAOE.txn_gross_val <> ABS(ME.txn_gross_val))
   AND ABS(ME.txn_gross_val) >= ABS(p_ra.param_val_qty)
  -- trick snowflake to execute everythin in this CTE first, and limit the number of events my these filters
  -- otherwise it chooses crazy plan and reads the entire T_PRODUCT_RETAIL_LINE first
  QUALIFY (COUNT(*) OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0), 
 -- prefix RET_ stands for "Return" not "Retail"
 RETURNED_PRODUCTS AS (SELECT
   me.main_event_sid,
   PRL.local_prod_nr AS ret_local_prod_nr,
   ANY_VALUE(me.event_start_tmsp) AS ret_event_start_tmsp,
   ANY_VALUE(me.bus_dt) AS ret_bus_dt,
   ANY_VALUE(me.country_org_cd) AS ret_country_org_cd,
   ANY_VALUE(me.store_sid) AS ret_store_sid,
   ANY_VALUE(me.cash_register_sid) AS ret_cash_register_sid,
   ANY_VALUE(me.cash_register_event_nr) AS ret_cash_register_event_nr,
   ANY_VALUE(me.txn_gross_val) AS ret_txn_gross_val,
   ANY_VALUE(me.txn_net_val) AS ret_txn_net_val,
   SUM(COALESCE(PRL.prod_variant_qty, PRL.prod_variant_cnt)) AS ret_prod_qty, -- returned Product Variant quantity
   SUM(SUM(COALESCE(PRL.prod_variant_qty, PRL.prod_variant_cnt))) OVER (PARTITION BY CAST(me.main_event_sid AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS ret_total_qty, -- returned total quantity
   COUNT(*) AS ret_prod_lines_cnt, -- how many lines exist on the return receipt for this Product Variant
   SUM(COUNT(*)) OVER (PARTITION BY CAST(me.main_event_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS ret_lines_cnt, -- how many lines exists in the whole receipt
   SUM(PRL.retail_line_gross_val) AS ret_prod_lines_gross_amount -- return amount of a Product Variant calculated using only return lines
  FROM RETURNS_FILTERED_BY_AMOUNT AS me
   INNER JOIN ldl_data_core_rel.t_product_retail_line AS PRL ON me.main_event_sid = PRL.retail_event_sid AND me.store_sid
        = PRL.store_sid AND me.country_org_cd = PRL.country_org_cd AND me.bus_dt = PRL.bus_dt
  WHERE me.retail_event_type_cd = 'R'
   AND me.turnover_relevant_fg
   AND PRL.retail_event_line_scenario_id BETWEEN 140 AND 149 -- Return receipt lines
   --Filter removed - not all lines with scenario ID between 140 and 149 are marked as retail line type 'R' or 'RD'. Change compliant with old system
   AND PRL.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT -- Delta date logic
  -- we might have several lines for returning same product (3 lines for returning Chips for example)
  -- we want to evaluate conditions based on LOCAL_PROD_NR, the quantity and amounts for them
  GROUP BY me.main_event_sid,
   ret_local_prod_nr), PURCH_PRODUCTS_AFTER_RETURN_EVENT AS (SELECT ME0.main_event_sid,
   ME0.event_after_main_event_sid,
   PRL0.local_prod_nr AS par_local_prod_nr,
   SUM(COALESCE(PRL0.prod_variant_qty, PRL0.prod_variant_cnt)) AS par_prod_qty,
   SUM(SUM(COALESCE(PRL0.prod_variant_qty, PRL0.prod_variant_cnt))) OVER (PARTITION BY CAST(ME0.main_event_sid AS STRING)
      , CAST(ME0.event_after_main_event_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   par_total_qty,
   COUNT(PRL0.local_prod_nr) OVER (PARTITION BY CAST(ME0.main_event_sid AS STRING), CAST(ME0.event_after_main_event_sid AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS par_distinct_prod_cnt -- how many distinct products exist in the "Purchase After the Return" - used in some scenarios
  FROM t_tmp_main_and_next_event AS ME0
   INNER JOIN ldl_data_core_rel.t_product_retail_line AS PRL0 ON ME0.event_after_main_event_sid = PRL0.retail_event_sid
  WHERE 
   -- Lines of purchases that happen on the same day AS the return
   PRL0.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
   AND ME0.retail_event_type_cd = 'R'
  GROUP BY ME0.main_event_sid,
   ME0.event_after_main_event_sid,
   par_local_prod_nr) (SELECT rp.main_event_sid,
   COUNT(DISTINCT rp.ret_local_prod_nr) AS ret_distinct_prod_cnt, -- how many different Products are returned
   SUM(IF(rp.ret_local_prod_nr = par_p.par_local_prod_nr, 1, 0)) AS ret_and_purch_distinct_prod_cnt -- how many different Products exist in the Return Receipt AND in the Purchase after the return receipt
   -- this logic replaced former one with additional join condition on products to purch_products_after_return_event CTE
  FROM RETURNED_PRODUCTS AS rp
   LEFT JOIN PURCH_PRODUCTS_AFTER_RETURN_EVENT AS par_p ON rp.main_event_sid = par_p.main_event_sid
  GROUP BY rp.main_event_sid
  -- SCENARIO_CONDITION: "ALL items in the Return are NOT in the following Purchase after the Return (some could be)""
  -- if all returned prods are purchased next, left join will not return NULLs for par_pv.PAR_LOCAL_PROD_NR.
  -- then the two counts will be equal, which is fine - no suspicion for a fraud
  HAVING ret_distinct_prod_cnt <> ret_and_purch_distinct_prod_cnt);

-----------------------------------------------------------------------
-----------------------------------------------------------------------
--
-- 			FINAL RESULT
--
-- 		put together all flags
--
-----------------------------------------------------------------------
-----------------------------------------------------------------------

INSERT INTO ${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final (cashier_hash, cash_register_sid,
 event_start_tmsp, bus_dt, txn_gross_val, cash_register_event_sid, curr_cd, store_sid, txn_net_val,
 cash_register_event_nr, cash_register_nr, receipt_outside_opening_hr_fg, receipt_outside_opening_hr_cancel_fg,
 receipt_outside_opening_hr_return_fg, receipt_outside_opening_hr_suspend_fg, receipt_outside_opening_hr_abort_fg,
 receipt_outside_opening_hr_deposit_only_fg, receipt_outside_opening_hr_manual_deposit_fg,
 receipt_outside_opening_hr_manual_discount_fg)
(SELECT ME.cashier_hash,
  CAST(ME.cash_register_sid AS INTEGER) AS cash_register_sid,
  ME.event_start_tmsp,
  ME.bus_dt,
  ME.txn_gross_val,
  ME.main_event_sid AS cash_register_event_sid,
  ME.curr_cd,
  CAST(ME.store_sid AS INTEGER) AS store_sid,
  ME.txn_net_val,
  CAST(ME.cash_register_event_nr AS INTEGER) AS cash_register_event_nr,
  CR.cash_register_nr,
   ME.receipt_outside_opening_hr_fg AS receipt_outside_opening_hr_fg, -- 'An indicator showing, if the retail event took place outside the official opening hours of the store. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'
   IF(C.main_event_sid IS NOT NULL, 1, 0) AS receipt_outside_opening_hr_cancel_fg, -- 'An indicator showing, if the retail event took place outside the official opening hours of the store and if it contained at least one position which was cancelled. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'
   IF(R.main_event_sid IS NOT NULL, 1, 0) AS receipt_outside_opening_hr_return_fg, -- 'An indicator showing, if the retail event took place outside the official opening hours of the store and if it contained at least one return position. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'
   ME.receipt_outside_opening_hr_suspend_fg AS receipt_outside_opening_hr_suspend_fg, -- 'An indicator showing, if the retail event took place outside the official opening hours of the store and if it was suspended. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'
   ME.receipt_outside_opening_hr_abort_fg AS receipt_outside_opening_hr_abort_fg, -- 'An indicator showing, if the retail event took place outside the official opening hours of the store and if it was aborted. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'
   ME.receipt_outside_opening_hr_deposit_only_fg AS receipt_outside_opening_hr_deposit_only_fg, -- 'An indicator showing, if the retail event took place outside the official opening hours of the store and if it contained only deposit lines. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'
   ME.receipt_outside_opening_hr_manual_deposit_fg AS receipt_outside_opening_hr_manual_deposit_fg, -- 'An indicator showing, if the retail event took place outside the official opening hours of the store and if it contained deposits which were manually entered. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'
   ME.receipt_outside_opening_hr_manual_discount_fg AS receipt_outside_opening_hr_manual_discount_fg -- 'An indicator showing, if the retail event took place outside the official opening hours of the store and if it contained discounts which were manually entered. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'
 FROM t_main_events AS ME
  INNER JOIN ldl_data_core_rel.t_cash_register AS CR ON ME.cash_register_sid = CR.cash_register_sid AND CR.dwh_valid_fg
  LEFT JOIN t_tmp_cancellations AS C ON ME.main_event_sid = C.main_event_sid
  LEFT JOIN t_tmp_returns AS R ON ME.main_event_sid = R.main_event_sid
 -- at least one sub-scenario flag must be TRUE to insert the receipt.
 WHERE IF(C.main_event_sid IS NOT NULL, 1, 0) = 1
  OR IF(R.main_event_sid IS NOT NULL, 1, 0) = 1
  OR ME.receipt_outside_opening_hr_suspend_fg = 1
  OR ME.receipt_outside_opening_hr_abort_fg = 1
  OR ME.receipt_outside_opening_hr_deposit_only_fg = 1
  OR ME.receipt_outside_opening_hr_manual_deposit_fg = 1
  OR ME.receipt_outside_opening_hr_manual_discount_fg = 1);