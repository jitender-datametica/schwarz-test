/* --------------------------------------------------------------------------------
   DDL for table: t_promotion_item_hist_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_promotion_item_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
prom_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Aktion_1; FK auf PROMOTION; SAP-Retail: wakp.aktnr; SAP-BW: t_bw_0rt_mat_prm_attr.aktnr / t_bw_z_ds_zlax_pitm_prcond.promotion / t_bw_z_ds_zlax_pitm_pcwh.promotion'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1; FK auf ITEM_1; SAP-Retail: wakp.artnr; SAP-BW: t_bw_0rt_mat_prm_attr.artnr / t_bw_z_ds_zlax_pitm_prcond.item_nr / t_bw_z_ds_zlax_pitm_pcwh.item_nr'),
uom_sid_sales BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Verkaufsmengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-Retail: wakp.mebme; SAP-BW: t_bw_0rt_mat_prm_attr.mebme / t_bw_z_ds_zlax_pitm_prcond.sales_me / t_bw_z_ds_zlax_pitm_pcwh.sales_me; ELWIS: -'),
loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Lokation; FK auf LOCATION_1; SAP-Retail: ?; SAP-BW: t_bw_z_ds_zlax_pitm_pcwh.cust_nr; ELWIS: t_s_itm_prom_qty.loc_sid '),
uom_sid_plan BIGNUMERIC(38,0)
OPTIONS(description='Planmengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-Retail: ?; SAP-BW: t_bw_z_ds_zlax_pitm_pcwh.plan_qty_me; ELWIS: prom_qty_uom_sid'),
uom_cd_sales STRING(20)
OPTIONS(description='Verkaufsmengeneinheit - Code; SAP-Retail: wakp.mebme; SAP-BW: t_bw_0rt_mat_prm_attr.mebme / t_bw_z_ds_zlax_pitm_prcond.sales_me / t_bw_z_ds_zlax_pitm_pcwh.sales_me; ELWIS: -'),
sales_from_dt DATE
OPTIONS(description='Verkauf ab; SAP-Retail: wakp.zz_buying_from; SAP-BW: t_bw_0rt_mat_prm_attr.zz_buying_from; ELWIS: t_s_itm_prom_attr.prom_start_dat'),
sales_to_dt DATE
OPTIONS(description='Verkauf bis; SAP-Retail: wakp.zz_buying_un; SAP-BW: t_bw_0rt_mat_prm_attr.zz_buying_un; ELWIS: t_s_itm_prom_attr.prom_end_dat'),
prom_week BIGNUMERIC(38,0)
OPTIONS(description='Werbewoche (YYYYWW); SAP-Retail: wakp.zz_adv_week; SAP-BW: t_bw_0rt_mat_prm_attr.zz_adv_week; ELWIS: t_s_itm_prom_attr.prom_week'),
prom_listing_type_mark STRING(20)
OPTIONS(description='Listungsart - Code; ; SAP-Retail: wakp.zz_list_type; SAP-BW: t_bw_0rt_mat_prm_attr.zz_list_type; ELWIS: t_s_itm_prom_attr.list_type_cd'),
prom_listing_type_label STRING(100) COLLATE 'und:ci'
OPTIONS(description='Listungsart - Bezeichnung; 1=In/Out; 2=Sortiment; 3=NonFood'),
product_cond_mark STRING(20)
OPTIONS(description='Warenzustand - Code(?); SAP-Retail: ?; SAP-BW: t_bw_z_ds_zlax_pitm_prcond.prod_cond; ELWIS: t_s_itm_prom_prcond.prod_prcond'),
product_cond_label STRING(100) COLLATE 'und:ci' OPTIONS(description='Warenzustand - Bezeichnung; X=;E=;T=;W=;U=;O=;'),
uom_cd_plan STRING(20)
OPTIONS(description='Planmengeneinheit - Code; SAP-Retail: ?; SAP-BW: t_bw_z_ds_zlax_pitm_pcwh.plan_qty_me; ELWIS: t_s_itm_prom_qty.prom_qty_uom_sid'),
plan_qty NUMERIC(18,5)
OPTIONS(description='Planmenge; SAP-Retail: ?; SAP-BW: t_bw_z_ds_zlax_pitm_pcwh.plan_qty; ELWIS: t_s_itm_prom_qty.prom_qty'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1/Promotion-Bez. ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (prom_sid, item_sid, uom_sid_sales, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. PROR; Aktionsdaten pro Artikel_1;             SAP-Retail: wakp_1;             SAP-BW: t_bw_0rt_mat_prm_attr, t_bw_z_ds_zlax_pitm_prcond, t_bw_z_ds_zlax_pitm_pcwh;             ELWIS: t_s_itm_prom_attr, t_s_itm_prom_qty, t_s_itm_prom_prcond');