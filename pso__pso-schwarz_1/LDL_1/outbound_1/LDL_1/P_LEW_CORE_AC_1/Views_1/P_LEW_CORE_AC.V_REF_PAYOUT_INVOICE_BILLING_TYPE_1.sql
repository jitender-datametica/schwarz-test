CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_payout_invoice_billing_type_1 (payout_invoice_billing_type_cd
OPTIONS(description='Payment mode for the billing amounts (Abrechnungstyp).'), payout_invoice_billing_type_descr
OPTIONS(description='A description for the payment mode.'), sales_qty_based_calc_fg
OPTIONS(description='Indicates if payout happens based on sold quantity.'), sales_amount_based_calc_fg
OPTIONS(description='Indicates if payout happens based on sold amount.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `PAYMENT MODE FOR THE BILLING AMOUNTS (ABRECHNUNGSTYP).`) AS SELECT payout_invoice_billing_type_cd
 ,
 payout_invoice_billing_type_descr,
 sales_qty_based_calc_fg,
 sales_amount_based_calc_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_payout_invoice_billing_type_1;