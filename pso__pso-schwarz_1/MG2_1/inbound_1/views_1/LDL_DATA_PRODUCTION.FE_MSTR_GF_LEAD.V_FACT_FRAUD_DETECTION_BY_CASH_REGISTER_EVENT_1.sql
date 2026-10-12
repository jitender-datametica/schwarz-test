create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1(
	CASH_REGISTER_EVENT_SID,
	CASH_REGISTER_EVENT_NR,
	EVENT_START_TMSP,
	BUS_DT,
	HR,
	HALF_HR,
	QTR_HR,
	CASH_REGISTER_SID,
	CASH_REGISTER_NR,
	STORE_SID,
	CASHIER_HASH,
	TXN_NET_VAL,
	TXN_GROSS_VAL,
	RELEVANT_CANCEL_GROSS_VAL,
	CURR_CD,
	CURR_GROUP_FG,
	CURR_LOCAL_FG,
	RELEVANT_CANCEL_LINE_CNT,
	CANCEL_LAST_POS_FG,
	CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG,
	CANCEL_LAST_POS_EXACT_PAYM_FG,
	CANCEL_LAST_POS_AFTER_SUBTOTAL_FG,
	CANCEL_IN_FAVOUR_FG,
	CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG,
	CANCEL_IN_FAVOUR_EXACT_PAYM_FG,
	CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG,
	RETURN_AT_HIGHER_THAN_SALES_PRICE_FG,
	RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG,
	RETURN_SAME_PROD_FG,
	RETURN_MULT_PROD_FG,
	RETURN_SAME_RECEIPT_FG,
	RETURN_WITHOUT_RECEIPT_FG,
	RETURN_NOT_ON_RECEIPT_FG,
	RETURN_QTY_INVALID_FG,
	RETURN_WITHOUT_AUTH_FG,
	RETURN_SAME_CASHIER_AND_DAY_FG,
	DEPOSIT_AND_ONE_PROD_FG,
	DEPOSIT_ONLY_MANUAL_INPUT_FG,
	DEPOSIT_SAME_EAN_FG,
	PRICE_INFO_MULT_FG,
	PRICE_INFO_AND_LOGOFF_FG,
	SUSPEND_AND_ABORT_FG,
	SUSPEND_AND_LINE_CANCEL_FG,
	SUSPEND_AND_EXTEND_FG,
	SUSPEND_UNRESOLVED_AND_SALE_FG,
	SUSPEND_UNRESOLVED_AND_LOGOFF_FG,
	ABORT_AND_SALE_FG,
	ABORT_AND_LOGOFF_FG,
	CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG,
	CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG,
	SMALL_SALE_FG,
	CANCEL_IN_FAVOUR_HIGHEST_POS_FG,
	DWH_CREATED_TMSP,
	DWH_UPDATED_TMSP,
	DWH_LOAD_ID,
	DWH_NODE_CD,
	CANCEL_IN_FAVOUR_LIDL_PLUS_FG,
	CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG,
	CANCEL_LAST_AND_OTHER_POS_FG,
	CANCEL_LAST_POS_HIGHEST_POS_FG,
	CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG,
	CUST_IDENT_TYPE_CD,
	CUST_SID,
	PRICE_INFO_AND_SMALL_SALE_FG,
	RETURN_MULT_PROD_FULL_QTY_FG,
	RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG,
	RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG,
	RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG,
	RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG,
	RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG,
	RETURN_SAME_CASHIER_DIFF_DAY_FG,
	RETURN_SAME_CASHIER_FG,
	RETURN_SAME_RECEIPT_FULL_QTY_FG,
	RETURN_SAME_RECEIPT_SAME_CASHIER_FG,
	RETURN_WITHOUT_RECEIPT_DV_INPUT_FG,
	RETURN_WITHOUT_RECEIPT_KE_INPUT_FG
) as
SELECT 
main.cash_register_event_sid::VARCHAR(100) AS cash_register_event_sid
,main.cash_register_event_nr AS cash_register_event_nr
,main.event_start_tmsp AS event_start_tmsp
,main.bus_dt AS bus_dt
,HOUR(main.event_start_tmsp)::NUMBER(38,0) AS hr
,HOUR(main.event_start_tmsp) * 100 + FLOOR(MINUTE(main.event_start_tmsp) / 30 ) * 30::NUMBER(38,0) AS half_hr
,HOUR(main.event_start_tmsp) * 100 + FLOOR(MINUTE(main.event_start_tmsp) / 15 ) * 15::NUMBER(38,0) AS qtr_hr
,main.cash_register_sid AS cash_register_sid
,main.cash_register_nr AS cash_register_nr
,main.store_sid AS store_sid
,main.cashier_hash AS cashier_hash
,main.txn_net_val / fer.exchange_rate AS txn_net_val
,main.txn_gross_val / fer.exchange_rate AS txn_gross_val
,main.CANCEL_IN_FAVOUR_GROSS_VAL / fer.exchange_rate AS CANCEL_IN_FAVOUR_GROSS_VAL
,fer.src_curr_cd AS curr_cd
,DECODE(fer.src_curr_cd,'EUR',1,0) AS curr_group_fg
,DECODE(fer.src_curr_cd,fer.tgt_curr_cd,1,0) AS curr_local_fg
,main.CANCEL_IN_FAVOUR_LINE_CNT AS CANCEL_IN_FAVOUR_LINE_CNTs
,main.cancel_last_pos_fg AS cancel_last_pos_fg
,main.cancel_last_pos_alcohol_tobacco_fg AS cancel_last_pos_alcohol_tobacco_fg
,main.cancel_last_pos_exact_paym_fg AS cancel_last_pos_exact_paym_fg
,main.cancel_last_pos_after_subtotal_fg AS cancel_last_pos_after_subtotal_fg
,main.cancel_in_favour_fg AS cancel_in_favour_fg
,main.cancel_in_favour_alcohol_tobacco_fg AS cancel_in_favour_alcohol_tobacco_fg
,main.cancel_in_favour_exact_paym_fg AS cancel_in_favour_exact_paym_fg
,main.cancel_in_favour_after_subtotal_fg AS cancel_in_favour_after_subtotal_fg
,main.return_at_higher_than_sales_price_fg AS return_at_higher_than_sales_price_fg
,main.return_at_higher_than_official_price_fg AS return_at_higher_than_official_price_fg
,main.return_same_prod_fg AS return_same_prod_fg
,main.return_mult_prod_fg AS return_mult_prod_fg
,main.return_same_receipt_fg AS return_same_receipt_fg
,main.return_without_receipt_fg AS return_without_receipt_fg
,main.return_not_on_receipt_fg AS return_not_on_receipt_fg
,main.return_qty_invalid_fg AS return_qty_invalid_fg
,main.return_without_auth_fg AS return_without_auth_fg
,main.return_same_cashier_and_day_fg AS return_same_cashier_and_day_fg
,main.deposit_and_one_prod_fg AS deposit_and_one_prod_fg
,main.deposit_only_manual_input_fg AS deposit_only_manual_input_fg
,main.deposit_same_ean_fg AS deposit_same_ean_fg
,main.price_info_mult_fg AS price_info_mult_fg
,main.price_info_and_logoff_fg AS price_info_and_logoff_fg
,main.suspend_and_abort_fg AS suspend_and_abort_fg
,main.suspend_and_line_cancel_fg AS suspend_and_line_cancel_fg
,main.suspend_and_extend_fg AS suspend_and_extend_fg
,main.suspend_unresolved_and_sale_fg AS suspend_unresolved_and_sale_fg
,main.suspend_unresolved_and_logoff_fg AS suspend_unresolved_and_logoff_fg
,main.abort_and_sale_fg AS abort_and_sale_fg
,main.abort_and_logoff_fg AS abort_and_logoff_fg
,main.cancel_in_favour_manual_discount_fg AS cancel_in_favour_manual_discount_fg
,main.cancel_in_favour_without_auth_fg AS cancel_in_favour_without_auth_fg
,main.small_sale_fg AS small_sale_fg
,main.cancel_in_favour_highest_pos_fg AS cancel_in_favour_highest_pos_fg
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd
,main.cancel_in_favour_lidl_plus_fg AS cancel_in_favour_lidl_plus_fg
,main.cancel_in_favour_outside_opening_hr_fg AS cancel_in_favour_outside_opening_hr_fg
,main.cancel_last_and_other_pos_fg AS cancel_last_and_other_pos_fg
,main.cancel_last_pos_highest_pos_fg AS cancel_last_pos_highest_pos_fg
,main.cancel_last_pos_outside_opening_hr_fg AS cancel_last_pos_outside_opening_hr_fg
,main.cust_ident_type_cd AS cust_ident_type_cd
,main.cust_sid AS cust_sid
,main.price_info_and_small_sale_fg AS price_info_and_small_sale_fg
,main.return_mult_prod_full_qty_fg AS return_mult_prod_full_qty_fg
,main.return_same_cashier_and_day_card_paym_fg AS return_same_cashier_and_day_card_paym_fg
,main.return_same_cashier_and_day_cash_paym_fg AS return_same_cashier_and_day_cash_paym_fg
,main.return_same_cashier_and_day_display_sel_fg AS return_same_cashier_and_day_display_sel_fg
,main.return_same_cashier_and_day_manual_fg AS return_same_cashier_and_day_manual_fg
,main.return_same_cashier_and_day_without_auth_fg AS return_same_cashier_and_day_without_auth_fg
,main.return_same_cashier_diff_day_fg AS return_same_cashier_diff_day_fg
,main.return_same_cashier_fg AS return_same_cashier_fg
,main.return_same_receipt_full_qty_fg AS return_same_receipt_full_qty_fg
,main.return_same_receipt_same_cashier_fg AS return_same_receipt_same_cashier_fg
,main.return_without_receipt_dv_input_fg AS return_without_receipt_dv_input_fg
,main.return_without_receipt_ke_input_fg AS return_without_receipt_ke_input_fg
FROM CORE_DIM.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1 main
INNER JOIN  CORE_DIM.T_FACT_EXCHANGE_RATE_1 fer
ON main.curr_cd = fer.tgt_curr_cd
WHERE exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE;