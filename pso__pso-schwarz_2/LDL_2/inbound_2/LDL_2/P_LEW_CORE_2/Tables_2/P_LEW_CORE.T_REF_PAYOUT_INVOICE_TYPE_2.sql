CREATE TABLE P_LEW_CORE.T_REF_PAYOUT_INVOICE_TYPE_2 (
   payout_invoice_type_cd              VARCHAR(100)     NOT NULL COMMENT 'A code for the billing type that is used to separate the contents of the billing amounts (Abrechnungsart).',
   payout_invoice_type_descr           VARCHAR(250)     COMMENT 'A description for the billing type.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_PAYOUT_INVOICE_TYPE PRIMARY KEY (payout_invoice_type_cd) NOT ENFORCED 
)  COMMENT = 'Billing type that is used to separate the contents of the billing amounts (Abrechnungsart).';
