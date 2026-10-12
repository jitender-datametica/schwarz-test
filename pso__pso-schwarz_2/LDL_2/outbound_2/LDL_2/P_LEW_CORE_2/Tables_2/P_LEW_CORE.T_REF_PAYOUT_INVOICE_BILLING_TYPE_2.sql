CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_payout_invoice_billing_type_2 (
payout_invoice_billing_type_cd STRING(100) NOT NULL
OPTIONS(description='Payment mode for the billing amounts (Abrechnungstyp).'),
payout_invoice_billing_type_descr STRING(250) OPTIONS(description='A description for the payment mode.'),
sales_qty_based_calc_fg BIGNUMERIC(38,0) OPTIONS(description='Indicates if payout happens based on sold quantity.'),
sales_amount_based_calc_fg BIGNUMERIC(38,0) OPTIONS(description='Indicates if payout happens based on sold amount.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (payout_invoice_billing_type_cd) NOT ENFORCED
) OPTIONS(description='Payment mode for the billing amounts (Abrechnungstyp).');