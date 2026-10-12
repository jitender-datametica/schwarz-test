CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_payout_invoice_summary_2 (client_id
OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'), payout_invoice_summary_sid
OPTIONS(description='Surrogate key for invoice summary.'), cy_month
OPTIONS(description='Month when the payout summary came in.'), payout_cond_sid
OPTIONS(description='Surrogate key for invoice conditions. Condition on which a payout was based on.'),
cond_valid_from_dt OPTIONS(description='Start date of the condition validity.'), payout_invoice_type_cd
OPTIONS(description='Billing type that is used to separate the contents of the billing amounts (Abrechnungsart).'),
payout_invoice_billing_type_cd OPTIONS(description='Payment mode for the billing amounts (Abrechnungstyp).'),
book_cy_month OPTIONS(description='Month for which this payout amount applies '), item_delivery_cy_month
OPTIONS(description='Delivery month of goods.'), sup_sid OPTIONS(description='Surrogate Key SUPPLIER_2'), item_sid
OPTIONS(description='Surrogate Key ITEM_2 (unique across all countries / clients).'), sub_item_grp_sid
OPTIONS(description='Surrogate Key SUBITEMGROUP'), item_fam_grp_sid
OPTIONS(description='''Surrogate Key ITEM_2 FAMILYGROUP;
CBX: Item.ldlArticleGroup.custText1;'''), curr_sid
OPTIONS(description='Invoice currency; FK on CURRENCY.'), curr_iso_cd
OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'), total_net_val
OPTIONS(description='An amount that was billed, netto in given currency.'), delivery_period_start_dt
OPTIONS(description='Start date of goods delivery period (relevant only for payout_invoice_billing_type_cd = \'Sonderverguetung\').'),
delivery_period_end_dt
OPTIONS(description='End date of goods delivery period (relevant only for payout_invoice_billing_type_cd = \'Sonderverguetung\').'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `Table contains the summary of rebate invoices aggregated on monthly basis per supplier_2 and agreed upon condition level. This is a summary and not individual invoices.`)
AS SELECT client_id,
 payout_invoice_summary_sid,
 cy_month,
 payout_cond_sid,
 cond_valid_from_dt,
 payout_invoice_type_cd,
 payout_invoice_billing_type_cd,
 book_cy_month,
 item_delivery_cy_month,
 sup_sid,
 item_sid,
 sub_item_grp_sid,
 item_fam_grp_sid,
 curr_sid,
 curr_iso_cd,
 total_net_val,
 delivery_period_start_dt,
 delivery_period_end_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_payout_invoice_summary_2;