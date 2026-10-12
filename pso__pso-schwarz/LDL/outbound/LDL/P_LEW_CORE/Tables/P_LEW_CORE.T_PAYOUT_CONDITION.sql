CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_payout_condition (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
payout_cond_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key for invoice conditions.'),
payout_invoice_type_cd STRING(100)
OPTIONS(description='Billing type that is used to separate the contents of the billing amounts (Abrechnungsart).'),
payout_invoice_billing_type_cd STRING(100) OPTIONS(description='Payment mode for the billing amounts (Abrechnungstyp).'),
sup_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SUPPLIER'),
item_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key ITEM (unique across all countries / clients).'),
sub_item_grp_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key SUBITEMGROUP'),
item_fam_grp_sid BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key ITEM FAMILYGROUP;            CBX: Item.ldlArticleGroup.custText1;            '),
cond_valid_from_dt DATE NOT NULL OPTIONS(description='Start date of the condition validity.'),
cond_valid_to_dt DATE OPTIONS(description='End date of the condition validity.'),
curr_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CURRENCY'),
curr_iso_cd STRING(3) OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'),
exchange_rate_cond_fg BIGNUMERIC(38,0)
OPTIONS(description='A flag indicating that exchange rate conditions  bandbreite) are applicable.'),
payout_cond_net_val BIGNUMERIC(38,5) OPTIONS(description='An amount that should be billed, netto in given currency.'),
payout_cond_pct BIGNUMERIC(38,5) OPTIONS(description='A percentage that should be billed, netto in given currency.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (payout_cond_sid, cond_valid_from_dt) NOT ENFORCED
) OPTIONS(description='A condition for a rebate that was negotiated with a supplier.');