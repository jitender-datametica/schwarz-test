/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_by_cash_register_event.sql
#----------------------------------------------------------------------------
# History:

# 1.0  16.08.2024  Andrzej Wandtke  - ZKP GF - script for loading the table t_fact_fraud_detection_by_cash_register_event
# 1.1  08.11.2024  Andrzej Wandtke  - ZKP GF - add columns cancel_last_pos_highest_pos_fg, cancel_last_pos_outside_opening_hr_fg, cancel_last_and_other_pos_fg
# 1.2  14.11.2024  Andrzej Wandtke  - ZKP GF - add columns for other sub-scenarios
# 1.3  15.11.2024  Andrzej Wandtke  - ZKP GF - add flags for possible future use, set currently to FALSE
# 1.4  20.11.2024  Andrzej Wandtke  - ZKP GF - add flags for possible future use, set currently to FALSE
# 1.5  27.11.2024  Mihail Ivanov    - ZKP GF - add DELETE part in the MERGE statement to remove receipts if new evaluation considers them "not suspicious"
# 1.6  02.12.2024  Mihail Ivanov    - ZKP GF - populate new cols CUST_SID and CUST_IDENT_TYPE_CD
# 1.7  20.11.2024  Andrzej Wandtke  - ZKP GF - remove call to ldl_fact_fraud_detection_return_same_prod.sql (Bug 56757 - asked to deactivate this scenario)
# 1.8  20.11.2024  Mihail Ivanov  	- ZKP GF - handle special cases for scenarios that evaluate receipts outside delta (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/62548/)
# 1.9  19.02.2025  Mihail Ivanov  	- ZKP GF - Added 4 columns
											3 of them are sub-scenarios requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/63798/
											1 is EVENT_END_TMSP requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/64336
# 1.10 27.03.2025  Kamil Roszczyk	- ZKP GF - removed relevant_cancel_gross_val and relevant_cancel_line_cnt column and replaced with 4 new columns according to the new data model
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/66945
# 1.11 02.04.2025  Andrzej Wandtke  - ZKP GF - add condition final_cashier_hash IS NOT NULL, 
                                               add column return_mult_prod_same_cashier_fg
	
# 1.12 03.04.2025  Mihail Ivanov  	- ZKP GF - Added UPDATEs at the end that set to FALSE any flag that was previously TRUE but the scenario is disabled in the country

# 1.13 25.04.2025  Andrzej Wandtke  - ZKP - 69046 - Exclude stores from Luxemburg - they belong technically do Belgium, but are based in Luxembourg
*/ /*
    Create working table. This table is not temporary because it has to be accessible outside of this script.
*/
CREATE OR REPLACE TABLE ${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final AS
SELECT
  *
FROM ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event
WHERE
  CAST('1' AS NUMERIC) = CAST('2' AS NUMERIC);

SELECT
  dual.${load_id}
FROM dual;

/* Exclude stores from Luxembourg */
DELETE FROM ${fwrk_work_db}.vt1
WHERE
  vt1.loc_sid IN (
    SELECT
      int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization
    WHERE
      upper(substr(curr_int_org_nr, 1, 2)) = 'LU' AND dwh_valid_fg
  );

/* ---------------------------------------------------------------- */ /*
	Evaluation of scenarios which can affect receipts outside delta interval


	The following scenarios evaluate older receitps which could be outside of the delta interval
		- LDL_FACT_FRAUD_DETECTION_DEPOSIT_SAME_EAN.sql
		- LDL_FACT_FRAUD_DETECTION_RETURN_SAME_RECEIPT.sql
		
	If a receipt was marked in one of these scenarios and is not part of the delta, then the other flags are not revaluated and will all be false
	To avoid setting incorrectly the other flags to FALSE, we create a list(table) of the SIDs of the events and update only relevant flags for these SIDs
*/ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_deposit_same_ean.sql */ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_return_same_receipt.sql */ /* we could have two rows for same Event, if it was evaluated in both scenarios */ /* so we need to know in which scenario it was evaluated */
CREATE OR REPLACE TEMPORARY TABLE t_tmp_events_outside_delta AS
SELECT
  src.cash_register_event_sid,
  ANY_VALUE(src.store_sid) AS store_sid,
  ANY_VALUE(src.bus_dt) AS bus_dt,
  sum(
    IF(NOT src.deposit_same_ean_fg IS NULL, CAST('1' AS NUMERIC), CAST('0' AS NUMERIC))
  ) /* if a flag is set to TRUE or FALSE then the EVENT was evaluated in the given scenario */ /* if a flag is has only NULL values then it was not evaluated */ /* "EOD" stands for "Event is Outside Delta" */ > CAST('0' AS NUMERIC) AS is_eod_deposit_same_ean_fg,
  sum(
    IF(NOT src.return_same_receipt_fg IS NULL, CAST('1' AS NUMERIC), CAST('0' AS NUMERIC))
  ) > CAST('0' AS NUMERIC) AS is_eod_return_same_receipt_fg
FROM ${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final AS src
LEFT OUTER JOIN ${fwrk_work_db}.vt1 AS d /* delta */
  ON src.bus_dt = d.dwh_cal_dt AND src.store_sid = d.loc_sid
WHERE
  d.loc_sid IS NULL /* receipt is evaluated, but is not in delta range */
GROUP BY
  1;

/* ---------------------------------------------------------------- */ /* ---------------------------------------------------------------- */ /* Remaining Scenarios Evaluation */ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_abort_logoff_sale.sql */ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_cancel_in_favour.sql */ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_deposit_only_manual_input.sql */ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_last_position_cancel.sql */ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_price_info_mult.sql */ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_price_info_and_small_sale_or_logoff.sql */ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_return_common.sql */ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_return_no_orig_receipt.sql */ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_suspend_unresolved_logoff_sale.sql */ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_return_at_price_higher_than_orig.sql */ /* ##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_suspended_and_cancelled.sql */ /* ---------------------------------------------------------------- */ /*
    Final rows preparation
*/ /* Create aggregated table (line per event) with no null values */
CREATE OR REPLACE TABLE ${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_agg;

INSERT INTO ${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_agg (
  cash_register_event_sid,
  cash_register_event_nr,
  event_start_tmsp,
  event_end_tmsp,
  bus_dt,
  cash_register_sid,
  cash_register_nr,
  store_sid,
  cashier_hash,
  txn_net_val,
  txn_gross_val,
  cancel_last_pos_gross_val,
  cancel_in_favour_gross_val,
  curr_cd,
  cancel_last_pos_line_cnt,
  cancel_in_favour_line_cnt,
  cust_sid,
  cust_ident_type_cd,
  cancel_last_pos_fg,
  cancel_last_pos_alcohol_tobacco_fg,
  cancel_last_pos_exact_paym_fg,
  cancel_last_pos_after_subtotal_fg,
  cancel_last_pos_without_auth_fg,
  cancel_last_pos_highest_pos_fg,
  cancel_last_pos_outside_opening_hr_fg,
  cancel_last_and_other_pos_fg,
  cancel_last_pos_single_pos_fg,
  cancel_in_favour_fg,
  cancel_in_favour_alcohol_tobacco_fg,
  cancel_in_favour_exact_paym_fg,
  cancel_in_favour_after_subtotal_fg,
  cancel_in_favour_outside_opening_hr_fg,
  cancel_in_favour_manual_discount_fg,
  cancel_in_favour_without_auth_fg,
  cancel_in_favour_highest_pos_fg,
  cancel_in_favour_lidl_plus_fg,
  cancel_in_favour_single_pos_fg,
  return_at_higher_than_sales_price_fg,
  return_at_higher_than_official_price_fg,
  return_same_prod_fg,
  return_mult_prod_fg,
  return_mult_prod_same_cashier_fg,
  return_mult_prod_full_qty_fg,
  return_same_receipt_fg,
  return_same_receipt_full_qty_fg,
  return_same_receipt_same_cashier_fg,
  return_without_receipt_fg,
  return_without_receipt_ke_input_fg,
  return_without_receipt_dv_input_fg,
  return_not_on_receipt_fg,
  return_qty_invalid_fg,
  return_without_auth_fg,
  return_same_cashier_fg,
  return_same_cashier_diff_day_fg,
  return_same_cashier_and_day_fg,
  return_same_cashier_and_day_card_paym_fg,
  return_same_cashier_and_day_cash_paym_fg,
  return_same_cashier_and_day_without_auth_fg,
  return_same_cashier_and_day_manual_fg,
  return_same_cashier_and_day_display_sel_fg,
  deposit_and_one_prod_fg,
  deposit_only_manual_input_fg,
  deposit_same_ean_fg,
  price_info_mult_fg,
  price_info_and_small_sale_fg,
  price_info_and_logoff_fg,
  suspend_and_abort_fg,
  suspend_and_line_cancel_fg,
  suspend_and_extend_fg,
  suspend_unresolved_and_sale_fg,
  suspend_unresolved_and_logoff_fg,
  abort_and_sale_fg,
  abort_and_logoff_fg,
  small_sale_fg,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
)
SELECT
  f.cash_register_event_sid,
  CAST(f.cash_register_event_nr AS BIGNUMERIC),
  f.event_start_tmsp,
  coalesce(re.event_end_tmsp, tcre.event_tmsp, pie.event_tmsp) AS final_event_end_tmsp,
  f.bus_dt,
  f.cash_register_sid,
  MAX(f.cash_register_nr) AS cash_register_nr, /* workaround unil data in T_CASH_REGISTER is fixed */
  f.store_sid,
  final_cashier_hash AS final_cashier_hash,
  MAX(coalesce(f.txn_net_val, CAST('0' AS NUMERIC))),
  MAX(coalesce(f.txn_gross_val, CAST('0' AS NUMERIC))),
  MAX(coalesce(f.cancel_last_pos_gross_val, CAST('0' AS NUMERIC))),
  MAX(coalesce(f.cancel_in_favour_gross_val, CAST('0' AS NUMERIC))),
  f.curr_cd,
  MAX(coalesce(f.cancel_last_pos_line_cnt, CAST('0' AS NUMERIC))),
  MAX(coalesce(f.cancel_in_favour_line_cnt, CAST('0' AS NUMERIC))),
  coalesce(MAX(re.cust_sid), -CAST('1' AS NUMERIC)), /* in core_dim we have dummy values instead of nulls. CUST info is valid only for retail events */
  coalesce(CAST(MAX(re.cust_ident_type_cd) AS STRING), '@'),
  logical_or(coalesce(cancel_last_pos_fg, FALSE)),
  logical_or(coalesce(cancel_last_pos_alcohol_tobacco_fg, FALSE)),
  logical_or(coalesce(cancel_last_pos_exact_paym_fg, FALSE)),
  logical_or(coalesce(cancel_last_pos_after_subtotal_fg, FALSE)),
  logical_or(coalesce(cancel_last_pos_without_auth_fg, FALSE)),
  logical_or(coalesce(cancel_last_pos_highest_pos_fg, FALSE)),
  logical_or(coalesce(cancel_last_pos_outside_opening_hr_fg, FALSE)),
  logical_or(coalesce(cancel_last_and_other_pos_fg, FALSE)),
  logical_or(coalesce(cancel_last_pos_single_pos_fg, FALSE)),
  logical_or(coalesce(cancel_in_favour_fg, FALSE)),
  logical_or(coalesce(cancel_in_favour_alcohol_tobacco_fg, FALSE)),
  logical_or(coalesce(cancel_in_favour_exact_paym_fg, FALSE)),
  logical_or(coalesce(cancel_in_favour_after_subtotal_fg, FALSE)),
  logical_or(coalesce(cancel_in_favour_outside_opening_hr_fg, FALSE)),
  logical_or(coalesce(cancel_in_favour_manual_discount_fg, FALSE)),
  logical_or(coalesce(cancel_in_favour_without_auth_fg, FALSE)),
  logical_or(coalesce(cancel_in_favour_highest_pos_fg, FALSE)),
  logical_or(coalesce(cancel_in_favour_lidl_plus_fg, FALSE)),
  logical_or(coalesce(cancel_in_favour_single_pos_fg, FALSE)),
  logical_or(coalesce(return_at_higher_than_sales_price_fg, FALSE)),
  logical_or(coalesce(return_at_higher_than_official_price_fg, FALSE)),
  logical_or(coalesce(return_same_prod_fg, FALSE)),
  logical_or(coalesce(return_mult_prod_fg, FALSE)),
  logical_or(coalesce(return_mult_prod_same_cashier_fg, FALSE)),
  logical_or(coalesce(return_mult_prod_full_qty_fg, FALSE)),
  logical_or(coalesce(return_same_receipt_fg, FALSE)), /* older receipts could exist */
  logical_or(coalesce(return_same_receipt_full_qty_fg, FALSE)), /* not implemented - ordered and then cancelled by business but for now we keep the col */
  logical_or(coalesce(return_same_receipt_same_cashier_fg, FALSE)),
  logical_or(coalesce(return_without_receipt_fg, FALSE)),
  logical_or(coalesce(return_without_receipt_ke_input_fg, FALSE)),
  logical_or(coalesce(return_without_receipt_dv_input_fg, FALSE)),
  logical_or(coalesce(return_not_on_receipt_fg, FALSE)),
  logical_or(coalesce(return_qty_invalid_fg, FALSE)),
  logical_or(coalesce(return_without_auth_fg, FALSE)),
  logical_or(coalesce(return_same_cashier_fg, FALSE)),
  logical_or(coalesce(return_same_cashier_diff_day_fg, FALSE)),
  logical_or(coalesce(return_same_cashier_and_day_fg, FALSE)),
  logical_or(coalesce(return_same_cashier_and_day_card_paym_fg, FALSE)),
  logical_or(coalesce(return_same_cashier_and_day_cash_paym_fg, FALSE)),
  logical_or(coalesce(return_same_cashier_and_day_without_auth_fg, FALSE)),
  logical_or(coalesce(return_same_cashier_and_day_manual_fg, FALSE)),
  logical_or(coalesce(return_same_cashier_and_day_display_sel_fg, FALSE)),
  logical_or(coalesce(deposit_and_one_prod_fg, FALSE)),
  logical_or(coalesce(deposit_only_manual_input_fg, FALSE)),
  logical_or(coalesce(deposit_same_ean_fg, FALSE)), /* older receipts could exist */
  logical_or(coalesce(price_info_mult_fg, FALSE)),
  logical_or(coalesce(price_info_and_small_sale_fg, FALSE)),
  logical_or(coalesce(price_info_and_logoff_fg, FALSE)),
  logical_or(coalesce(suspend_and_abort_fg, FALSE)),
  logical_or(coalesce(suspend_and_line_cancel_fg, FALSE)),
  logical_or(coalesce(suspend_and_extend_fg, FALSE)),
  logical_or(coalesce(suspend_unresolved_and_sale_fg, FALSE)),
  logical_or(coalesce(suspend_unresolved_and_logoff_fg, FALSE)),
  logical_or(coalesce(abort_and_sale_fg, FALSE)),
  logical_or(coalesce(abort_and_logoff_fg, FALSE)),
  logical_or(coalesce(small_sale_fg, FALSE)),
  current_timestamp(),
  current_timestamp(),
  ${load_id},
  'CORE_REL'
FROM ${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final AS f
LEFT OUTER JOIN ldl_data_production.core_rel.t_price_information_event AS pie
  ON f.cash_register_event_sid = pie.price_info_event_sid AND f.bus_dt = pie.bus_dt
LEFT OUTER JOIN ldl_data_production.core_rel.t_retail_event AS re
  ON f.cash_register_event_sid = re.retail_event_sid
  AND /* absolutely ridiculous condition. Seems moronic and f.BUS_DT will never be null. */ /* but this way we are tricking snowflake to start first from "f", then "pie" and then "re" */ /* otherwise it starts with "re" and reads the full table 25B+ rows no filters, no pruning ... */ coalesce(f.bus_dt, pie.bus_dt) = re.bus_dt
LEFT OUTER JOIN ldl_data_production.core_rel.t_technical_cash_register_event AS tcre
  ON f.cash_register_event_sid = tcre.tech_cash_register_event_sid
  AND f.bus_dt = tcre.bus_dt
CROSS JOIN UNNEST([coalesce(re.cashier_hash, tcre.cashier_hash, pie.cashier_hash)]) AS final_cashier_hash
WHERE
  NOT final_cashier_hash IS NULL
GROUP BY
  1,
  2,
  3,
  4,
  5,
  6,
  8,
  9,
  14 /* ,cash_register_nr */;

MERGE INTO ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event AS tgt
USING (
  SELECT
    n_rows.*,
    'NEW' AS row_type,
    eod.is_eod_deposit_same_ean_fg, /* these flags could be TRUE/FALSE or NULL (becaue of left join). We have special case if they are TRUE */
    eod.is_eod_return_same_receipt_fg
  FROM ${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_agg AS n_rows
  LEFT OUTER JOIN ${fwrk_work_db}.t_tmp_events_outside_delta AS eod
    ON n_rows.cash_register_event_sid = eod.cash_register_event_sid
  UNION ALL
  /* receipts that currenty exist in the target, but we evaluated again the store for same period and now the receipt is not suspicious */ /* 		so, it should be deleted */
  SELECT
    o_rows.*,
    'OLD' AS row_type,
    NULL AS is_eod_deposit_same_ean_fg,
    NULL AS is_eod_return_same_receipt_fg
  FROM ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event AS o_rows
  LEFT OUTER JOIN ${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_agg AS n_rows
    ON o_rows.cash_register_event_sid = n_rows.cash_register_event_sid
  WHERE
    EXISTS(
      SELECT
        CAST('1' AS NUMERIC)
      FROM ${fwrk_work_db}.vt1
      WHERE
        CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
        AND o_rows.bus_dt = vt1.dwh_cal_dt
        AND o_rows.store_sid = vt1.loc_sid
    )
    AND n_rows.cash_register_event_sid IS NULL
) AS src
ON tgt.cash_register_event_sid = src.cash_register_event_sid
WHEN MATCHED AND src.row_type = 'OLD' THEN DELETE
WHEN MATCHED AND src.row_type = 'NEW' /* event was evaluated also this run */
AND CAST(src.is_eod_deposit_same_ean_fg AS BOOL) = TRUE /* event is NOT in delta interval and was evaluated in this scenario */
AND CAST(src.is_eod_return_same_receipt_fg AS BOOL) = TRUE /* event is NOT in delta interval and was evaluated in this scenario */ THEN UPDATE SET
  return_same_receipt_fg = src.return_same_receipt_fg,
  deposit_same_ean_fg = src.deposit_same_ean_fg,
  dwh_updated_tmsp = current_timestamp(),
  dwh_load_id = ${load_id}
WHEN MATCHED AND src.row_type = 'NEW' /* event was evaluated also this run */
AND CAST(src.is_eod_deposit_same_ean_fg AS BOOL) = TRUE /* event is NOT in delta interval and was evaluated in ONLY this scenario */ THEN UPDATE SET
  deposit_same_ean_fg = src.deposit_same_ean_fg,
  dwh_updated_tmsp = current_timestamp(),
  dwh_load_id = ${load_id}
WHEN MATCHED AND src.row_type = 'NEW' /* event was evaluated also this run */
AND CAST(src.is_eod_return_same_receipt_fg AS BOOL) = TRUE /* event is NOT in delta interval and was evaluated in ONLY this scenario */ THEN UPDATE SET
  return_same_receipt_fg = src.return_same_receipt_fg,
  dwh_updated_tmsp = current_timestamp(),
  dwh_load_id = ${load_id}
WHEN MATCHED AND src.row_type = 'NEW' THEN UPDATE SET
  cash_register_event_nr = src.cash_register_event_nr,
  event_start_tmsp = src.event_start_tmsp,
  event_end_tmsp = src.event_end_tmsp,
  bus_dt = src.bus_dt,
  cash_register_sid = src.cash_register_sid,
  cash_register_nr = src.cash_register_nr,
  store_sid = src.store_sid,
  cashier_hash = src.cashier_hash,
  txn_net_val = src.txn_net_val,
  txn_gross_val = src.txn_gross_val,
  cancel_last_pos_gross_val = src.cancel_last_pos_gross_val,
  cancel_in_favour_gross_val = src.cancel_in_favour_gross_val,
  curr_cd = src.curr_cd,
  cancel_last_pos_line_cnt = src.cancel_last_pos_line_cnt,
  cancel_in_favour_line_cnt = src.cancel_in_favour_line_cnt,
  cust_sid = src.cust_sid,
  cust_ident_type_cd = src.cust_ident_type_cd,
  cancel_last_pos_fg = src.cancel_last_pos_fg,
  cancel_last_pos_alcohol_tobacco_fg = src.cancel_last_pos_alcohol_tobacco_fg,
  cancel_last_pos_exact_paym_fg = src.cancel_last_pos_exact_paym_fg,
  cancel_last_pos_after_subtotal_fg = src.cancel_last_pos_after_subtotal_fg,
  cancel_last_pos_without_auth_fg = src.cancel_last_pos_without_auth_fg,
  cancel_last_pos_highest_pos_fg = src.cancel_last_pos_highest_pos_fg,
  cancel_last_pos_outside_opening_hr_fg = src.cancel_last_pos_outside_opening_hr_fg,
  cancel_last_and_other_pos_fg = src.cancel_last_and_other_pos_fg,
  cancel_last_pos_single_pos_fg = src.cancel_last_pos_single_pos_fg,
  cancel_in_favour_fg = src.cancel_in_favour_fg,
  cancel_in_favour_alcohol_tobacco_fg = src.cancel_in_favour_alcohol_tobacco_fg,
  cancel_in_favour_exact_paym_fg = src.cancel_in_favour_exact_paym_fg,
  cancel_in_favour_after_subtotal_fg = src.cancel_in_favour_after_subtotal_fg,
  cancel_in_favour_outside_opening_hr_fg = src.cancel_in_favour_outside_opening_hr_fg,
  cancel_in_favour_manual_discount_fg = src.cancel_in_favour_manual_discount_fg,
  cancel_in_favour_without_auth_fg = src.cancel_in_favour_without_auth_fg,
  cancel_in_favour_highest_pos_fg = src.cancel_in_favour_highest_pos_fg,
  cancel_in_favour_lidl_plus_fg = src.cancel_in_favour_lidl_plus_fg,
  cancel_in_favour_single_pos_fg = src.cancel_in_favour_single_pos_fg,
  return_at_higher_than_sales_price_fg = src.return_at_higher_than_sales_price_fg,
  return_at_higher_than_official_price_fg = src.return_at_higher_than_official_price_fg,
  return_same_prod_fg = src.return_same_prod_fg,
  return_mult_prod_fg = src.return_mult_prod_fg,
  return_mult_prod_same_cashier_fg = src.return_mult_prod_same_cashier_fg,
  return_mult_prod_full_qty_fg = src.return_mult_prod_full_qty_fg,
  return_same_receipt_fg = src.return_same_receipt_fg,
  return_same_receipt_full_qty_fg = src.return_same_receipt_full_qty_fg,
  return_same_receipt_same_cashier_fg = src.return_same_receipt_same_cashier_fg,
  return_without_receipt_fg = src.return_without_receipt_fg,
  return_without_receipt_ke_input_fg = src.return_without_receipt_ke_input_fg,
  return_without_receipt_dv_input_fg = src.return_without_receipt_dv_input_fg,
  return_not_on_receipt_fg = src.return_not_on_receipt_fg,
  return_qty_invalid_fg = src.return_qty_invalid_fg,
  return_without_auth_fg = src.return_without_auth_fg,
  return_same_cashier_fg = src.return_same_cashier_fg,
  return_same_cashier_diff_day_fg = src.return_same_cashier_diff_day_fg,
  return_same_cashier_and_day_fg = src.return_same_cashier_and_day_fg,
  return_same_cashier_and_day_card_paym_fg = src.return_same_cashier_and_day_card_paym_fg,
  return_same_cashier_and_day_cash_paym_fg = src.return_same_cashier_and_day_cash_paym_fg,
  return_same_cashier_and_day_without_auth_fg = src.return_same_cashier_and_day_without_auth_fg,
  return_same_cashier_and_day_manual_fg = src.return_same_cashier_and_day_manual_fg,
  return_same_cashier_and_day_display_sel_fg = src.return_same_cashier_and_day_display_sel_fg,
  deposit_and_one_prod_fg = src.deposit_and_one_prod_fg,
  deposit_only_manual_input_fg = src.deposit_only_manual_input_fg,
  deposit_same_ean_fg = src.deposit_same_ean_fg,
  price_info_mult_fg = src.price_info_mult_fg,
  price_info_and_small_sale_fg = src.price_info_and_small_sale_fg,
  price_info_and_logoff_fg = src.price_info_and_logoff_fg,
  suspend_and_abort_fg = src.suspend_and_abort_fg,
  suspend_and_line_cancel_fg = src.suspend_and_line_cancel_fg,
  suspend_and_extend_fg = src.suspend_and_extend_fg,
  suspend_unresolved_and_sale_fg = src.suspend_unresolved_and_sale_fg,
  suspend_unresolved_and_logoff_fg = src.suspend_unresolved_and_logoff_fg,
  abort_and_sale_fg = src.abort_and_sale_fg,
  abort_and_logoff_fg = src.abort_and_logoff_fg,
  small_sale_fg = src.small_sale_fg,
  dwh_updated_tmsp = current_timestamp(),
  dwh_load_id = ${load_id}
WHEN NOT MATCHED THEN INSERT (
  cash_register_event_sid,
  cash_register_event_nr,
  event_start_tmsp,
  event_end_tmsp,
  bus_dt,
  cash_register_sid,
  cash_register_nr,
  store_sid,
  cashier_hash,
  txn_net_val,
  txn_gross_val,
  cancel_last_pos_gross_val,
  cancel_in_favour_gross_val,
  curr_cd,
  cancel_last_pos_line_cnt,
  cancel_in_favour_line_cnt,
  cust_sid,
  cust_ident_type_cd,
  cancel_last_pos_fg,
  cancel_last_pos_alcohol_tobacco_fg,
  cancel_last_pos_exact_paym_fg,
  cancel_last_pos_after_subtotal_fg,
  cancel_last_pos_without_auth_fg,
  cancel_last_pos_highest_pos_fg,
  cancel_last_pos_outside_opening_hr_fg,
  cancel_last_and_other_pos_fg,
  cancel_last_pos_single_pos_fg,
  cancel_in_favour_fg,
  cancel_in_favour_alcohol_tobacco_fg,
  cancel_in_favour_exact_paym_fg,
  cancel_in_favour_after_subtotal_fg,
  cancel_in_favour_outside_opening_hr_fg,
  cancel_in_favour_manual_discount_fg,
  cancel_in_favour_without_auth_fg,
  cancel_in_favour_highest_pos_fg,
  cancel_in_favour_lidl_plus_fg,
  cancel_in_favour_single_pos_fg,
  return_at_higher_than_sales_price_fg,
  return_at_higher_than_official_price_fg,
  return_same_prod_fg,
  return_mult_prod_fg,
  return_mult_prod_same_cashier_fg,
  return_mult_prod_full_qty_fg,
  return_same_receipt_fg,
  return_same_receipt_full_qty_fg,
  return_same_receipt_same_cashier_fg,
  return_without_receipt_fg,
  return_without_receipt_ke_input_fg,
  return_without_receipt_dv_input_fg,
  return_not_on_receipt_fg,
  return_qty_invalid_fg,
  return_without_auth_fg,
  return_same_cashier_fg,
  return_same_cashier_diff_day_fg,
  return_same_cashier_and_day_fg,
  return_same_cashier_and_day_card_paym_fg,
  return_same_cashier_and_day_cash_paym_fg,
  return_same_cashier_and_day_without_auth_fg,
  return_same_cashier_and_day_manual_fg,
  return_same_cashier_and_day_display_sel_fg,
  deposit_and_one_prod_fg,
  deposit_only_manual_input_fg,
  deposit_same_ean_fg,
  price_info_mult_fg,
  price_info_and_small_sale_fg,
  price_info_and_logoff_fg,
  suspend_and_abort_fg,
  suspend_and_line_cancel_fg,
  suspend_and_extend_fg,
  suspend_unresolved_and_sale_fg,
  suspend_unresolved_and_logoff_fg,
  abort_and_sale_fg,
  abort_and_logoff_fg,
  small_sale_fg,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
) VALUES (
  src.cash_register_event_sid,
  src.cash_register_event_nr,
  src.event_start_tmsp,
  src.event_end_tmsp,
  src.bus_dt,
  src.cash_register_sid,
  src.cash_register_nr,
  src.store_sid,
  src.cashier_hash,
  src.txn_net_val,
  src.txn_gross_val,
  src.cancel_last_pos_gross_val,
  src.cancel_in_favour_gross_val,
  src.curr_cd,
  src.cancel_last_pos_line_cnt,
  src.cancel_in_favour_line_cnt,
  src.cust_sid,
  src.cust_ident_type_cd,
  src.cancel_last_pos_fg,
  src.cancel_last_pos_alcohol_tobacco_fg,
  src.cancel_last_pos_exact_paym_fg,
  src.cancel_last_pos_after_subtotal_fg,
  src.cancel_last_pos_without_auth_fg,
  src.cancel_last_pos_highest_pos_fg,
  src.cancel_last_pos_outside_opening_hr_fg,
  src.cancel_last_and_other_pos_fg,
  src.cancel_last_pos_single_pos_fg,
  src.cancel_in_favour_fg,
  src.cancel_in_favour_alcohol_tobacco_fg,
  src.cancel_in_favour_exact_paym_fg,
  src.cancel_in_favour_after_subtotal_fg,
  src.cancel_in_favour_outside_opening_hr_fg,
  src.cancel_in_favour_manual_discount_fg,
  src.cancel_in_favour_without_auth_fg,
  src.cancel_in_favour_highest_pos_fg,
  src.cancel_in_favour_lidl_plus_fg,
  src.cancel_in_favour_single_pos_fg,
  src.return_at_higher_than_sales_price_fg,
  src.return_at_higher_than_official_price_fg,
  src.return_same_prod_fg,
  src.return_mult_prod_fg,
  src.return_mult_prod_same_cashier_fg,
  src.return_mult_prod_full_qty_fg,
  src.return_same_receipt_fg,
  src.return_same_receipt_full_qty_fg,
  src.return_same_receipt_same_cashier_fg,
  src.return_without_receipt_fg,
  src.return_without_receipt_ke_input_fg,
  src.return_without_receipt_dv_input_fg,
  src.return_not_on_receipt_fg,
  src.return_qty_invalid_fg,
  src.return_without_auth_fg,
  src.return_same_cashier_fg,
  src.return_same_cashier_diff_day_fg,
  src.return_same_cashier_and_day_fg,
  src.return_same_cashier_and_day_card_paym_fg,
  src.return_same_cashier_and_day_cash_paym_fg,
  src.return_same_cashier_and_day_without_auth_fg,
  src.return_same_cashier_and_day_manual_fg,
  src.return_same_cashier_and_day_display_sel_fg,
  src.deposit_and_one_prod_fg,
  src.deposit_only_manual_input_fg,
  src.deposit_same_ean_fg,
  src.price_info_mult_fg,
  src.price_info_and_small_sale_fg,
  src.price_info_and_logoff_fg,
  src.suspend_and_abort_fg,
  src.suspend_and_line_cancel_fg,
  src.suspend_and_extend_fg,
  src.suspend_unresolved_and_sale_fg,
  src.suspend_unresolved_and_logoff_fg,
  src.abort_and_sale_fg,
  src.abort_and_logoff_fg,
  src.small_sale_fg,
  current_timestamp(),
  current_timestamp(),
  src.${load_id},
  'CORE_REL'
) /* Final merge with the destination table */;

/* -------------------------------------------------------------- */ /* the following updates will affect rows only once when scenario status is changed from Enabled to Disabled for given country */ /* otherwise they will not update any rows, and not change anything - so no need to worry that we are doing many UPDATEs on one table (which would be bad if it were true) */ /* ------------------------------------------------------------ */ /* SCENARIO_ID: 2	Gleiche Pfandbon-EAN-Nr. */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET deposit_same_ean_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND t_fact_fraud_detection_by_cash_register_event.deposit_same_ean_fg = TRUE
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('2' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 4	Pfandbon manuell + rein */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET deposit_only_manual_input_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND t_fact_fraud_detection_by_cash_register_event.deposit_only_manual_input_fg = TRUE
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('4' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 5	Mehrfachepreisanzeige in Folge */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET price_info_mult_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND t_fact_fraud_detection_by_cash_register_event.price_info_mult_fg = TRUE
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('5' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 6	Preisanzeige + Kleinstbon oder Abmeldung Kasse */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET price_info_and_small_sale_fg = FALSE, price_info_and_logoff_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND (
    t_fact_fraud_detection_by_cash_register_event.price_info_and_small_sale_fg = TRUE
    OR t_fact_fraud_detection_by_cash_register_event.price_info_and_logoff_fg = TRUE
  )
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('6' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 7	Geldrückgabe nicht autorisierungspflichtig */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET return_without_auth_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND t_fact_fraud_detection_by_cash_register_event.return_without_auth_fg = TRUE
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('7' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 8	Mehrfache Geldrückgabe mit gleichem Originalbon */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET return_same_receipt_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND t_fact_fraud_detection_by_cash_register_event.return_same_receipt_fg = TRUE
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('8' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 10	Rückgabe nicht auf Originalbon oder häufiger mit gleichem Originalbon */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET return_not_on_receipt_fg = FALSE, return_qty_invalid_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND (
    t_fact_fraud_detection_by_cash_register_event.return_not_on_receipt_fg = TRUE
    OR t_fact_fraud_detection_by_cash_register_event.return_qty_invalid_fg = TRUE
  )
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('10' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 11	Rücknahmepreis größer höchster Wawi-Preis */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET return_at_higher_than_sales_price_fg = FALSE, return_at_higher_than_official_price_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND (
    t_fact_fraud_detection_by_cash_register_event.return_at_higher_than_sales_price_fg = TRUE
    OR t_fact_fraud_detection_by_cash_register_event.return_at_higher_than_official_price_fg = TRUE
  )
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('11' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 12	Geldrückgabe - Originalbon gleicher Tag, gleicher Bediener */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET return_same_cashier_fg = FALSE, return_same_cashier_diff_day_fg = FALSE, return_same_cashier_and_day_fg = FALSE, return_same_cashier_and_day_without_auth_fg = FALSE, return_same_cashier_and_day_manual_fg = FALSE, return_same_cashier_and_day_display_sel_fg = FALSE, return_same_cashier_and_day_cash_paym_fg = FALSE, return_same_cashier_and_day_card_paym_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND t_fact_fraud_detection_by_cash_register_event.return_same_cashier_fg = TRUE
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('12' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 13	Geldrückgabe ohne Originalbon (manuell) */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET return_without_receipt_fg = FALSE, return_without_receipt_ke_input_fg = FALSE, return_without_receipt_dv_input_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND t_fact_fraud_detection_by_cash_register_event.return_without_receipt_fg = TRUE
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('13' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 14	Geldrückgabe mehrerer Artikel eines Originalbons */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET return_mult_prod_fg = FALSE, return_mult_prod_full_qty_fg = FALSE, return_mult_prod_same_cashier_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND t_fact_fraud_detection_by_cash_register_event.return_mult_prod_fg = TRUE
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('14' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 15	Bonrückstellung mit Bonabbruch/Storno */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET suspend_and_abort_fg = FALSE, suspend_and_line_cancel_fg = FALSE, suspend_and_extend_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND (
    t_fact_fraud_detection_by_cash_register_event.suspend_and_abort_fg = TRUE
    OR t_fact_fraud_detection_by_cash_register_event.suspend_and_line_cancel_fg = TRUE
    OR t_fact_fraud_detection_by_cash_register_event.suspend_and_extend_fg = TRUE
  )
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('15' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 16	Offene Bonrückstellung + Kleinstbon o. Abmeldung Kasse */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET suspend_unresolved_and_logoff_fg = FALSE, suspend_unresolved_and_sale_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND (
    t_fact_fraud_detection_by_cash_register_event.suspend_unresolved_and_logoff_fg = TRUE
    OR t_fact_fraud_detection_by_cash_register_event.suspend_unresolved_and_sale_fg = TRUE
  )
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('16' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 17	Bonabbruch + Kleinstbon oder Abmeldung Kasse */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET abort_and_sale_fg = FALSE, abort_and_logoff_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND (
    t_fact_fraud_detection_by_cash_register_event.abort_and_sale_fg = TRUE
    OR t_fact_fraud_detection_by_cash_register_event.abort_and_logoff_fg = TRUE
  )
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('17' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 18	Storno an letzter Position */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET cancel_last_pos_fg = FALSE, cancel_last_pos_after_subtotal_fg = FALSE, cancel_last_pos_exact_paym_fg = FALSE, cancel_last_pos_alcohol_tobacco_fg = FALSE, cancel_last_pos_highest_pos_fg = FALSE, cancel_last_pos_outside_opening_hr_fg = FALSE, cancel_last_and_other_pos_fg = FALSE, cancel_last_pos_without_auth_fg = FALSE, cancel_last_pos_single_pos_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND t_fact_fraud_detection_by_cash_register_event.cancel_last_pos_fg = TRUE
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('18' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );

/* ------------------------------------------------------------ */ /* SCENARIO_ID: 19	Storno Begünstigungskauf */
UPDATE ldl_data_production.core_dim.t_fact_fraud_detection_by_cash_register_event SET cancel_in_favour_fg = FALSE, cancel_in_favour_alcohol_tobacco_fg = FALSE, cancel_in_favour_outside_opening_hr_fg = FALSE, cancel_in_favour_without_auth_fg = FALSE, cancel_in_favour_manual_discount_fg = FALSE, cancel_in_favour_after_subtotal_fg = FALSE, cancel_in_favour_highest_pos_fg = FALSE, cancel_in_favour_single_pos_fg = FALSE, cancel_in_favour_exact_paym_fg = FALSE, cancel_in_favour_lidl_plus_fg = FALSE, dwh_load_id = t_fact_fraud_detection_by_cash_register_event.${load_id}, dwh_updated_tmsp = current_timestamp()
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND t_fact_fraud_detection_by_cash_register_event.cancel_in_favour_fg = TRUE
  AND /* stores from countries where the scneario is disabled */ t_fact_fraud_detection_by_cash_register_event.store_sid IN (
    SELECT DISTINCT
      io.int_org_sid
    FROM ldl_data_production.core_dim.t_dim_internal_organization AS io
    INNER JOIN ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value AS v
      ON io.country_org_cd = v.country_org_cd
    WHERE
      CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND v.scenario_id = CAST('19' AS NUMERIC)
      AND v.is_scenario_enabled_in_country_fg = FALSE
      AND io.dwh_valid_fg = TRUE
      AND io.int_org_type_cd = 'STORE'
  );