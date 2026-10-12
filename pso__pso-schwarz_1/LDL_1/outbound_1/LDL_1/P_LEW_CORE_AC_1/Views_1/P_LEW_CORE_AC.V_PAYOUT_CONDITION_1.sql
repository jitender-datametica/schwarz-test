CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_payout_condition_1 (client_id OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
payout_cond_sid OPTIONS(description='Surrogate key for invoice conditions.'), payout_invoice_type_cd
OPTIONS(description='Billing type that is used to separate the contents of the billing amounts (Abrechnungsart).'),
payout_invoice_billing_type_cd OPTIONS(description='Payment mode for the billing amounts (Abrechnungstyp).'), sup_sid
OPTIONS(description='Surrogate Key SUPPLIER_1'), item_sid
OPTIONS(description='Surrogate Key ITEM_1 (unique across all countries / clients).'), sub_item_grp_sid
OPTIONS(description='Surrogate Key SUBITEMGROUP'), item_fam_grp_sid
OPTIONS(description='''Surrogate Key ITEM_1 FAMILYGROUP;
CBX: Item.ldlArticleGroup.custText1;
'''), cond_valid_from_dt
OPTIONS(description='Start date of the condition validity.'), cond_valid_to_dt
OPTIONS(description='End date of the condition validity.'), curr_sid OPTIONS(description='Surrogate Key CURRENCY'),
curr_iso_cd OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'),
exchange_rate_cond_fg
OPTIONS(description='A flag indicating that exchange rate conditions  bandbreite) are applicable.'), payout_cond_net_val
OPTIONS(description='An amount that should be billed, netto in given currency.'), payout_cond_pct
OPTIONS(description='A percentage that should be billed, netto in given currency.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `A condition for a rebate that was negotiated with a supplier.`) AS SELECT client_id,
 payout_cond_sid,
 payout_invoice_type_cd,
 payout_invoice_billing_type_cd,
 sup_sid,
 item_sid,
 sub_item_grp_sid,
 item_fam_grp_sid,
 cond_valid_from_dt,
 cond_valid_to_dt,
 curr_sid,
 curr_iso_cd,
 exchange_rate_cond_fg,
 payout_cond_net_val,
 payout_cond_pct,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_payout_condition_1;