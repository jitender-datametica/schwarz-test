CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_PAYOUT_INVOICE_BILLING_TYPE_2 (
   payout_invoice_billing_type_cd           COMMENT 'Payment mode for the billing amounts (Abrechnungstyp).'
  ,payout_invoice_billing_type_descr        COMMENT 'A description for the payment mode.'
  ,sales_qty_based_calc_fg                  COMMENT 'Indicates if payout happens based on sold quantity.'
  ,sales_amount_based_calc_fg               COMMENT 'Indicates if payout happens based on sold amount.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Payment mode for the billing amounts (Abrechnungstyp).'
AS SELECT
   payout_invoice_billing_type_cd
  ,payout_invoice_billing_type_descr
  ,sales_qty_based_calc_fg
  ,sales_amount_based_calc_fg
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_PAYOUT_INVOICE_BILLING_TYPE_2
;