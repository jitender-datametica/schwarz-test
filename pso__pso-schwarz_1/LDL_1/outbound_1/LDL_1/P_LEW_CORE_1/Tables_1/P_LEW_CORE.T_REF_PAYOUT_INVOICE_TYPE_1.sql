CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_payout_invoice_type_1 (
payout_invoice_type_cd STRING(100) NOT NULL
OPTIONS(description='A code for the billing type that is used to separate the contents of the billing amounts (Abrechnungsart).'),
payout_invoice_type_descr STRING(250) OPTIONS(description='A description for the billing type.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (payout_invoice_type_cd) NOT ENFORCED
) OPTIONS(description='Billing type that is used to separate the contents of the billing amounts (Abrechnungsart).');