CREATE TABLE P_LEW_CORE.T_PAYOUT_CONDITION_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   payout_cond_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key for invoice conditions.',
   payout_invoice_type_cd              VARCHAR(100)     COMMENT 'Billing type that is used to separate the contents of the billing amounts (Abrechnungsart).',
   payout_invoice_billing_type_cd      VARCHAR(100)     COMMENT 'Payment mode for the billing amounts (Abrechnungstyp).',
   sup_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SUPPLIER_2',
   item_sid                            NUMBER(38,0)     COMMENT 'Surrogate Key ITEM_2 (unique across all countries / clients).',
   sub_item_grp_sid                    NUMBER(38,0)     COMMENT 'Surrogate Key SUBITEMGROUP',
   item_fam_grp_sid                    NUMBER(38,0)     COMMENT 'Surrogate Key ITEM_2 FAMILYGROUP;
            CBX: Item.ldlArticleGroup.custText1;
            ',
   cond_valid_from_dt                  DATE             NOT NULL COMMENT 'Start date of the condition validity.',
   cond_valid_to_dt                    DATE             COMMENT 'End date of the condition validity.',
   curr_sid                            NUMBER(38,0)     COMMENT 'Surrogate Key CURRENCY',
   curr_iso_cd                         VARCHAR(3)       COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd',
   exchange_rate_cond_fg               NUMBER(38,0)     COMMENT 'A flag indicating that exchange rate conditions  bandbreite) are applicable.',
   payout_cond_net_val                 NUMBER(38,5)     COMMENT 'An amount that should be billed, netto in given currency.',
   payout_cond_pct                     NUMBER(38,5)     COMMENT 'A percentage that should be billed, netto in given currency.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PAYOUT_CONDITION PRIMARY KEY (payout_cond_sid, cond_valid_from_dt) NOT ENFORCED 
)  COMMENT = 'A condition for a rebate that was negotiated with a supplier.';
