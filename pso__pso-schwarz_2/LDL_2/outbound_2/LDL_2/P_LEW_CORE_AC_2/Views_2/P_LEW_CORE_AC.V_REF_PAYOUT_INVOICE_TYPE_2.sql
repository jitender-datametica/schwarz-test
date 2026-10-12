CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_payout_invoice_type_2 (payout_invoice_type_cd
OPTIONS(description='A code for the billing type that is used to separate the contents of the billing amounts (Abrechnungsart).'),
payout_invoice_type_descr OPTIONS(description='A description for the billing type.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `BILLING TYPE THAT IS USED TO SEPARATE THE CONTENTS OF THE BILLING AMOUNTS (ABRECHNUNGSART).`) AS
SELECT payout_invoice_type_cd,
 payout_invoice_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_payout_invoice_type_2;