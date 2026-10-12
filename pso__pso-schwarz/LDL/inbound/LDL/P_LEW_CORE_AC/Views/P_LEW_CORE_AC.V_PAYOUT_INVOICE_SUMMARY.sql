CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_PAYOUT_INVOICE_SUMMARY (
   client_id                                COMMENT 'DWH-Mandant; FK auf CLIENT'
  ,payout_invoice_summary_sid               COMMENT 'Surrogate key for invoice summary.'
  ,cy_month                                 COMMENT 'Month when the payout summary came in.'
  ,payout_cond_sid                          COMMENT 'Surrogate key for invoice conditions. Condition on which a payout was based on.'
  ,cond_valid_from_dt                       COMMENT 'Start date of the condition validity.'
  ,payout_invoice_type_cd                   COMMENT 'Billing type that is used to separate the contents of the billing amounts (Abrechnungsart).'
  ,payout_invoice_billing_type_cd           COMMENT 'Payment mode for the billing amounts (Abrechnungstyp).'
  ,book_cy_month                            COMMENT 'Month for which this payout amount applies '
  ,item_delivery_cy_month                   COMMENT 'Delivery month of goods.'
  ,sup_sid                                  COMMENT 'Surrogate Key SUPPLIER'
  ,item_sid                                 COMMENT 'Surrogate Key ITEM (unique across all countries / clients).'
  ,sub_item_grp_sid                         COMMENT 'Surrogate Key SUBITEMGROUP'
  ,item_fam_grp_sid                         COMMENT 'Surrogate Key ITEM FAMILYGROUP;
CBX: Item.ldlArticleGroup.custText1;'
  ,curr_sid                                 COMMENT 'Invoice currency; FK on CURRENCY.'
  ,curr_iso_cd                              COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'
  ,total_net_val                            COMMENT 'An amount that was billed, netto in given currency.'
  ,delivery_period_start_dt                 COMMENT 'Start date of goods delivery period (relevant only for payout_invoice_billing_type_cd = ''Sonderverguetung'').'
  ,delivery_period_end_dt                   COMMENT 'End date of goods delivery period (relevant only for payout_invoice_billing_type_cd = ''Sonderverguetung'').'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Table contains the summary of rebate invoices aggregated on monthly basis per supplier and agreed upon condition level. This is a summary and not individual invoices.'
AS SELECT
   client_id
  ,payout_invoice_summary_sid
  ,cy_month
  ,payout_cond_sid
  ,cond_valid_from_dt
  ,payout_invoice_type_cd
  ,payout_invoice_billing_type_cd
  ,book_cy_month
  ,item_delivery_cy_month
  ,sup_sid
  ,item_sid
  ,sub_item_grp_sid
  ,item_fam_grp_sid
  ,curr_sid
  ,curr_iso_cd
  ,total_net_val
  ,delivery_period_start_dt
  ,delivery_period_end_dt
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_PAYOUT_INVOICE_SUMMARY
;