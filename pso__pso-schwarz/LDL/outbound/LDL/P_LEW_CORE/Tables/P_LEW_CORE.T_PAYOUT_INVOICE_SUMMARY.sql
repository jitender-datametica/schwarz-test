CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_payout_invoice_summary (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
payout_invoice_summary_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key for invoice summary.'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Month when the payout summary came in.'),
payout_cond_sid BIGNUMERIC(38,0)
OPTIONS(description='Surrogate key for invoice conditions. Condition on which a payout was based on.'),
cond_valid_from_dt DATE OPTIONS(description='Start date of the condition validity.'),
payout_invoice_type_cd STRING(100)
OPTIONS(description='Billing type that is used to separate the contents of the billing amounts (Abrechnungsart).'),
payout_invoice_billing_type_cd STRING(100) OPTIONS(description='Payment mode for the billing amounts (Abrechnungstyp).'),
book_cy_month BIGNUMERIC(38,0) OPTIONS(description='Month for which this payout amount applies '),
item_delivery_cy_month BIGNUMERIC(38,0) OPTIONS(description='Delivery month of goods.'),
sup_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SUPPLIER'),
item_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key ITEM (unique across all countries / clients).'),
sub_item_grp_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key SUBITEMGROUP'),
item_fam_grp_sid BIGNUMERIC(38,0)
OPTIONS(description='''Surrogate Key ITEM FAMILYGROUP;
            CBX: Item.ldlArticleGroup.custText1;'''),
curr_sid BIGNUMERIC(38,0) OPTIONS(description='Invoice currency; FK on CURRENCY.'),
curr_iso_cd STRING(20) OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'),
total_net_val BIGNUMERIC(38,5) OPTIONS(description='An amount that was billed, netto in given currency.'),
delivery_period_start_dt DATE
OPTIONS(description='Start date of goods delivery period (relevant only for payout_invoice_billing_type_cd = \'Sonderverguetung\').'),
delivery_period_end_dt DATE
OPTIONS(description='End date of goods delivery period (relevant only for payout_invoice_billing_type_cd = \'Sonderverguetung\').'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (payout_invoice_summary_sid) NOT ENFORCED
)
OPTIONS(description='Table contains the summary of rebate invoices aggregated on monthly basis per supplier and agreed upon condition level. This is a summary and not individual invoices.');