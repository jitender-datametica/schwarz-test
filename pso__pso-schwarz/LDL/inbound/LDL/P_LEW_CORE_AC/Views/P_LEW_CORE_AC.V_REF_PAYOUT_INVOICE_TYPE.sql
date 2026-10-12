CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_PAYOUT_INVOICE_TYPE (
   payout_invoice_type_cd                   COMMENT 'A code for the billing type that is used to separate the contents of the billing amounts (Abrechnungsart).'
  ,payout_invoice_type_descr                COMMENT 'A description for the billing type.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Billing type that is used to separate the contents of the billing amounts (Abrechnungsart).'
AS SELECT
   payout_invoice_type_cd
  ,payout_invoice_type_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_PAYOUT_INVOICE_TYPE
;