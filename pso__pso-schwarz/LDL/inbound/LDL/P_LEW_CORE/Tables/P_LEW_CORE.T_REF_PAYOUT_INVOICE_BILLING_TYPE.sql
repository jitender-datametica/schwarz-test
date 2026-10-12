CREATE TABLE P_LEW_CORE.T_REF_PAYOUT_INVOICE_BILLING_TYPE (
   payout_invoice_billing_type_cd      VARCHAR(100)     NOT NULL COMMENT 'Payment mode for the billing amounts (Abrechnungstyp).',
   payout_invoice_billing_type_descr   VARCHAR(250)     COMMENT 'A description for the payment mode.',
   sales_qty_based_calc_fg             NUMBER(38,0)     COMMENT 'Indicates if payout happens based on sold quantity.',
   sales_amount_based_calc_fg          NUMBER(38,0)     COMMENT 'Indicates if payout happens based on sold amount.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_PAYOUT_INVOICE_BILLING_TYPE PRIMARY KEY (payout_invoice_billing_type_cd) NOT ENFORCED 
)  COMMENT = 'Payment mode for the billing amounts (Abrechnungstyp).';
