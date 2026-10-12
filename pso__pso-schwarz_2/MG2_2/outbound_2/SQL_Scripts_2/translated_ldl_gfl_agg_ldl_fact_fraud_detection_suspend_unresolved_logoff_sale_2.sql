/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_suspend_unresolved_logoff_sale.sql
#----------------------------------------------------------------------------
# History:
#  1.0  12.09.2024  Mihail Ivanov  - ZKP GF_2 - Initial implementation
		UserStory 
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/33390/
		Setting the following flags:
			SUSPEND_UNRESOLVED_AND_LOGOFF_FG
			SUSPEND_UNRESOLVED_AND_SALE_FG
#  1.1  17.09.2024  Andrzej Wandtke - ZKP GF_2 - replace CONT_RETAIL_EVENT_SID by SUSP_RETAIL_EVENT_SID - forced by a change in DB
#  1.2  28.11.2024  Kamil Roszczyk  - ZKP GF_2 - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/59465
									Change log:
										- subsequent receipt logic changed and adjusted to old ZKP (removed 400, 405, 420, 425, 430 and 480 type events from the subsequent receipt candidates - all_cash_reg_events CTE)
										- added conditions to pick not any sales_2 but the small sales_2 according to the old ZKP definition (receipt sales_2 lines + receipt deposit return lines = 1; no cancelled lines; total receipt gross value lesser than the threshold parameter value)
										- added cashier_hash to the join condition for picking the subsequent receipt as per old ZKP ('country_2, store, cash register, cashier, date' combination)
										- rebuilt the code to improve performance
#  1.3  03.01.2025  Osman Yilmaz  - ZKP GF_2 - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/62167
									Change log:
										- The condition is removed during the check of resumed receipt. The resume receipt can be also canceled or suspended in this case it is not open suspended


#  1.4  11.03.2025  Mihail Ivanov  - ZKP GF_2 - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/64821
									Change log:
										added filtering for suspended receipts based on threshold "Bonrückstellung mit Gesamtwert Bonrückstellung > X"
#  1.5	18.03.2025  Andrzej Wandtke   - ZKP GF_2 changes - task 66853 - filter on standard cash registers : POS type TIL

#  1.6  26.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenaio is enabled in a country_2 (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios
						- Using CASHIER_NR to determine next receipt by same employee. This is necessary because sometimes we get two hashes for same Store+Day+CashierNR

#  1.7  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script

#  1.8  29.04.2025  Kamil Roszczyk	- changes: changed 'TIL' filter for non selfcheckout cash registers
										- filter: "cash_register_type_cd = 'TIL'"; replaced with: "cash_register_type_cd = 'TIL' OR cash_register_type_cd IS NULL"
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/69257
*/

INSERT INTO ${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final (
  cash_register_event_sid,
  cash_register_event_nr,
  event_start_tmsp,
  bus_dt,
  cash_register_sid,
  cash_register_nr,
  store_sid,
  cashier_hash,
  txn_net_val,
  txn_gross_val,
  curr_cd,
  suspend_unresolved_and_logoff_fg,
  suspend_unresolved_and_sale_fg
)
WITH suspended_receipts AS (
  SELECT
    o_re.retail_event_sid, /*  (US: 33390) Offene Bonrückstellung + Kleinstbon oder Abmeldung Kasse */
    o_re.bus_dt,
    o_re.event_start_tmsp,
    o_re.cash_register_sid,
    o_re.cash_register_event_nr,
    o_re.store_sid,
    o_re.cashier_hash,
    o_re.txn_net_val,
    o_re.txn_gross_val,
    o_re.curr_cd,
    ce.cashier_nr
  FROM ldl_data_production.core_rel.t_retail_event_2 AS o_re
  INNER JOIN ldl_data_production.core_app_fraud_detection.t_cashier_encryption_2 AS ce
    ON ce.cashier_hash = o_re.cashier_hash
  WHERE
    CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
    AND o_re.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
    AND (
      o_re.country_org_cd,
      o_re.bus_dt,
      o_re.store_sid /* Delta country_2, date, store logic */
    ) IN (
      SELECT AS STRUCT
        country_cd,
        dwh_cal_dt,
        loc_sid
      FROM ${fwrk_work_db}.vt1
    )
    AND o_re.retail_event_type_cd = 'S'
    AND o_re.suspend_fg = TRUE /* suspended */
    AND o_re.cancel_fg = FALSE /* not cancelled */
    AND (
      o_re.cash_register_type_cd = 'TIL' OR o_re.cash_register_type_cd IS NULL
    ) /* standard cash registers */
    /* not continued  with regular (payed) receipt */  AND NOT EXISTS(
      SELECT
        CAST('1' AS NUMERIC)
      FROM ldl_data_production.core_rel.t_retail_event_2 AS c_re
      WHERE
        o_re.retail_event_sid = c_re.susp_retail_event_sid
        AND c_re.bus_dt = o_re.bus_dt
        AND c_re.retail_event_type_cd = 'S'
        /* the conditions are removed according to change on 03.01.2025, resume transaction can be also canceled */ /* and c_re.SUSPEND_FG = FALSE */ /* and c_re.CANCEL_FG = FALSE */
    )
), all_cash_reg_events AS (
  SELECT
    tcre.tech_cash_register_event_sid AS cash_register_event_sid, 
    tcre.cash_register_event_nr,
    tcre.event_tmsp,
    tcre.bus_dt,
    tcre.country_org_cd,
    tcre.cash_register_sid,
    tcre.cashier_hash,
    'TECH_EVENT' AS event_category,
    tcre.tech_cash_register_event_type_cd AS event_subcategory,
    tcre.cancel_fg,
    tcre.suspend_fg,
    CAST('0' AS NUMERIC) AS txn_gross_val,
    ce.cashier_nr
  FROM ldl_data_production.core_rel.t_technical_cash_register_event_2 AS tcre
  INNER JOIN ldl_data_production.core_app_fraud_detection.t_cashier_encryption_2 AS ce
    ON ce.cashier_hash = tcre.cashier_hash
  WHERE
    CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
    AND /* all technical events apart from 400, 405, 420, 425, 430 and 480 - exclusion logic same as in old ZKP (480 is a price info event - separate subquery removed from subsequent receipts' candidates CTE - 28.11.2024) */ NOT tcre.tech_cash_register_event_type_cd IN (
      CAST('400' AS NUMERIC),
      CAST('405' AS NUMERIC),
      CAST('420' AS NUMERIC),
      CAST('425' AS NUMERIC),
      CAST('430' AS NUMERIC)
    )
    AND tcre.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
    AND (tcre.country_org_cd, tcre.bus_dt, tcre.store_sid) IN (
      SELECT AS STRUCT
        country_cd,
        dwh_cal_dt,
        loc_sid
      FROM ${fwrk_work_db}.vt1
    )
  UNION ALL
  SELECT
    re.retail_event_sid AS cash_register_event_sid,
    re.cash_register_event_nr,
    re.event_start_tmsp AS event_tmsp,
    re.bus_dt,
    re.country_org_cd,
    re.cash_register_sid,
    re.cashier_hash,
    'RETAIL_EVENT' AS event_category,
    re.retail_event_type_cd AS event_subcategory,
    re.cancel_fg,
    re.suspend_fg,
    re.txn_gross_val,
    ce.cashier_nr
  FROM ldl_data_production.core_rel.t_retail_event_2 AS re_2
  INNER JOIN ldl_data_production.core_app_fraud_detection.t_cashier_encryption_2 AS ce
    ON ce.cashier_hash = re.cashier_hash
  WHERE
    CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
    AND re.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
    AND (re.country_org_cd, re.bus_dt, re.store_sid) IN (
      SELECT AS STRUCT
        country_cd,
        dwh_cal_dt,
        loc_sid
      FROM ${fwrk_work_db}.vt1
    )
), event_and_next_event AS (
  SELECT
    sr.retail_event_sid AS cash_register_event_sid,
    sr.cash_register_event_nr AS cash_register_event_nr,
    sr.event_start_tmsp,
    sr.bus_dt,
    sr.cash_register_sid,
    sr.store_sid,
    sr.cashier_hash,
    sr.txn_net_val,
    sr.txn_gross_val,
    sr.curr_cd,
    acre.cash_register_event_sid AS next_cash_register_event_sid,
    acre.event_category AS next_event_category,
    acre.event_subcategory AS next_event_subcategory,
    acre.country_org_cd AS next_country_org_cd,
    acre.suspend_fg AS next_suspend_fg,
    acre.txn_gross_val AS next_txn_gross_val
  FROM suspended_receipts AS sr
  INNER JOIN all_cash_reg_events AS acre
    ON sr.cash_register_sid = acre.cash_register_sid
    AND sr.bus_dt = acre.bus_dt
    AND sr.cashier_nr = acre.cashier_nr /* no need to add condition for same Store, it is already guaranteed because we have condition for same cash_register_sid */
    AND sr.cash_register_event_nr < acre.cash_register_event_nr
  QUALIFY
   -- we take the next event at the same Cash Register (that happened after the suspended receipt)
    row_number() OVER (
      PARTITION BY cash_register_event_sid
      ORDER BY IF(acre.cash_register_event_nr IS NULL, 0, 1) DESC, acre.cash_register_event_nr
    ) = CAST('1' AS NUMERIC)
), mat_params AS (
  SELECT
    *
  FROM ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value_2
  WHERE
    v_fraud_detection_parameter_current_value.scenario_id = CAST('16' AS NUMERIC)
), small_sales_receipt_lines AS (
  SELECT
    tprl.retail_event_sid
  FROM ${fwrk_work_db}.vt1
  INNER JOIN ldl_data_production.core_rel.t_product_retail_line_2 AS tprl
    ON vt1.country_cd = tprl.country_org_cd
    AND vt1.dwh_cal_dt = tprl.bus_dt
    AND vt1.loc_sid = tprl.store_sid
  WHERE
    CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
    AND tprl.turnover_relevant_fg = TRUE
    AND tprl.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
  GROUP BY
    1
  HAVING
  --take only these receipts with only one sale or deposit return line
    sum(
      CASE
        WHEN tprl.retail_event_line_scenario_id IN (
          CAST('101' AS NUMERIC),
          CAST('102' AS NUMERIC),
          CAST('120' AS NUMERIC),
          CAST('122' AS NUMERIC),
          CAST('201' AS NUMERIC),
          CAST('202' AS NUMERIC),
          CAST('220' AS NUMERIC),
          CAST('222' AS NUMERIC)
        )
        THEN CAST('1' AS NUMERIC)
        ELSE CAST('0' AS NUMERIC)
      END
    ) = CAST('1' AS NUMERIC)
    --take only these receipts where there is no cancellation line with relevant value
    AND sum(
      CASE
        WHEN NOT tprl.cancel_line_seq IS NULL
        AND tprl.retail_line_gross_val > CAST('0' AS NUMERIC)
        THEN CAST('1' AS NUMERIC)
        ELSE CAST('0' AS NUMERIC)
      END
    ) = CAST('0' AS NUMERIC)
)
SELECT
  eane.cash_register_event_sid,
  eane.cash_register_event_nr,
  eane.event_start_tmsp,
  eane.bus_dt,
  eane.cash_register_sid,
  cr.cash_register_nr,
  eane.store_sid,
  eane.cashier_hash,
  eane.txn_net_val,
  eane.txn_gross_val,
  eane.curr_cd,
  CASE eane.next_event_category
    WHEN 'TECH_EVENT'
    THEN CAST('1' AS NUMERIC)
    ELSE CAST('0' AS NUMERIC)
  END AS suspend_unresolved_and_logoff_fg,
  CASE eane.next_event_category
    WHEN 'RETAIL_EVENT'
    THEN CAST('1' AS NUMERIC)
    ELSE CAST('0' AS NUMERIC)
  END AS suspend_unresolved_and_sale_fg
FROM event_and_next_event AS eane
INNER JOIN ldl_data_production.core_rel.t_cash_register_2 AS cr
  ON eane.cash_register_sid = cr.cash_register_sid AND cr.dwh_valid_fg = TRUE
INNER JOIN mat_params AS s16_kb /* Scenario 16, parameter "Small sale lesser than X LW" */
  ON s16_kb.country_org_cd = eane.next_country_org_cd
  AND s16_kb.param_id = CAST('49' AS NUMERIC)
  AND /* if scneario is not enabled all receipts from that country_2 will be eliminated in the inner join */ s16_kb.is_scenario_enabled_in_country_fg = TRUE
INNER JOIN mat_params AS s16_sa /* Scenario 16, parameter for Suspended Amount ("Bonrückstellung mit Gesamtwert Bonrückstellung > X") */
  ON s16_sa.country_org_cd = eane.next_country_org_cd
  AND s16_sa.param_id = CAST('127' AS NUMERIC)
  AND /* if scneario is not enabled all receipts from that country_2 will be eliminated in the inner join */ s16_sa.is_scenario_enabled_in_country_fg = TRUE
LEFT OUTER JOIN small_sales_receipt_lines AS ssrl
  ON eane.next_cash_register_event_sid = ssrl.retail_event_sid
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND /* we check if next event is valid (not suspended, cancelled receipts can be included as per old ZKP logic) */ eane.next_suspend_fg = FALSE
  AND eane.txn_gross_val >= s16_sa.param_val_qty
  AND /* and we check if this next event is a sale or a logoff event */ /* "sign off" cash register event */ (
    eane.next_event_category = 'TECH_EVENT'
    AND eane.next_event_subcategory = '410'
    /* "small sale" retail event */
    OR eane.next_event_category = 'RETAIL_EVENT'
    AND eane.next_event_subcategory = 'S'
    AND NOT ssrl.retail_event_sid IS NULL
    AND eane.next_txn_gross_val < s16_kb.param_val_qty
  )
;