CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_PAYOUT_CONDITION_2 (
   client_id                                COMMENT 'DWH-Mandant_2; FK auf CLIENT'
  ,payout_cond_sid                          COMMENT 'Surrogate key for invoice conditions.'
  ,payout_invoice_type_cd                   COMMENT 'Billing type that is used to separate the contents of the billing amounts (Abrechnungsart).'
  ,payout_invoice_billing_type_cd           COMMENT 'Payment mode for the billing amounts (Abrechnungstyp).'
  ,sup_sid                                  COMMENT 'Surrogate Key SUPPLIER_2'
  ,item_sid                                 COMMENT 'Surrogate Key ITEM_2 (unique across all countries / clients).'
  ,sub_item_grp_sid                         COMMENT 'Surrogate Key SUBITEMGROUP'
  ,item_fam_grp_sid                         COMMENT 'Surrogate Key ITEM_2 FAMILYGROUP;
CBX: Item.ldlArticleGroup.custText1;
'
  ,cond_valid_from_dt                       COMMENT 'Start date of the condition validity.'
  ,cond_valid_to_dt                         COMMENT 'End date of the condition validity.'
  ,curr_sid                                 COMMENT 'Surrogate Key CURRENCY'
  ,curr_iso_cd                              COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'
  ,exchange_rate_cond_fg                    COMMENT 'A flag indicating that exchange rate conditions  bandbreite) are applicable.'
  ,payout_cond_net_val                      COMMENT 'An amount that should be billed, netto in given currency.'
  ,payout_cond_pct                          COMMENT 'A percentage that should be billed, netto in given currency.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'A condition for a rebate that was negotiated with a supplier.'
AS SELECT
   client_id
  ,payout_cond_sid
  ,payout_invoice_type_cd
  ,payout_invoice_billing_type_cd
  ,sup_sid
  ,item_sid
  ,sub_item_grp_sid
  ,item_fam_grp_sid
  ,cond_valid_from_dt
  ,cond_valid_to_dt
  ,curr_sid
  ,curr_iso_cd
  ,exchange_rate_cond_fg
  ,payout_cond_net_val
  ,payout_cond_pct
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_PAYOUT_CONDITION_2
;