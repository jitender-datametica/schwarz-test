/* --------------------------------------------------------------------------------
   DDL for table: t_promotion_item_hist
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PROMOTION_ITEM_HIST CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   prom_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Aktion; FK auf PROMOTION; SAP-Retail: wakp.aktnr; SAP-BW: t_bw_0rt_mat_prm_attr.aktnr / t_bw_z_ds_zlax_pitm_prcond.promotion / t_bw_z_ds_zlax_pitm_pcwh.promotion',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel; FK auf ITEM; SAP-Retail: wakp.artnr; SAP-BW: t_bw_0rt_mat_prm_attr.artnr / t_bw_z_ds_zlax_pitm_prcond.item_nr / t_bw_z_ds_zlax_pitm_pcwh.item_nr',
   uom_sid_sales                       NUMBER(38,0)     NOT NULL COMMENT 'Verkaufsmengeneinheit; FK auf UNIT OF MEASUREMENT; SAP-Retail: wakp.mebme; SAP-BW: t_bw_0rt_mat_prm_attr.mebme / t_bw_z_ds_zlax_pitm_prcond.sales_me / t_bw_z_ds_zlax_pitm_pcwh.sales_me; ELWIS: -',
   loc_sid                             NUMBER(38,0)     COMMENT 'Lokation; FK auf LOCATION; SAP-Retail: ?; SAP-BW: t_bw_z_ds_zlax_pitm_pcwh.cust_nr; ELWIS: t_s_itm_prom_qty.loc_sid ',
   uom_sid_plan                        NUMBER(38,0)     COMMENT 'Planmengeneinheit; FK auf UNIT OF MEASUREMENT; SAP-Retail: ?; SAP-BW: t_bw_z_ds_zlax_pitm_pcwh.plan_qty_me; ELWIS: prom_qty_uom_sid',
   uom_cd_sales                        VARCHAR(20)      COMMENT 'Verkaufsmengeneinheit - Code; SAP-Retail: wakp.mebme; SAP-BW: t_bw_0rt_mat_prm_attr.mebme / t_bw_z_ds_zlax_pitm_prcond.sales_me / t_bw_z_ds_zlax_pitm_pcwh.sales_me; ELWIS: -',
   sales_from_dt                       DATE             COMMENT 'Verkauf ab; SAP-Retail: wakp.zz_buying_from; SAP-BW: t_bw_0rt_mat_prm_attr.zz_buying_from; ELWIS: t_s_itm_prom_attr.prom_start_dat',
   sales_to_dt                         DATE             COMMENT 'Verkauf bis; SAP-Retail: wakp.zz_buying_un; SAP-BW: t_bw_0rt_mat_prm_attr.zz_buying_un; ELWIS: t_s_itm_prom_attr.prom_end_dat',
   prom_week                           NUMBER(38,0)     COMMENT 'Werbewoche (YYYYWW); SAP-Retail: wakp.zz_adv_week; SAP-BW: t_bw_0rt_mat_prm_attr.zz_adv_week; ELWIS: t_s_itm_prom_attr.prom_week',
   prom_listing_type_mark              VARCHAR(20)      COMMENT 'Listungsart - Code; ; SAP-Retail: wakp.zz_list_type; SAP-BW: t_bw_0rt_mat_prm_attr.zz_list_type; ELWIS: t_s_itm_prom_attr.list_type_cd',
   prom_listing_type_label             VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Listungsart - Bezeichnung; 1=In/Out; 2=Sortiment; 3=NonFood',
   product_cond_mark                   VARCHAR(20)      COMMENT 'Warenzustand - Code(?); SAP-Retail: ?; SAP-BW: t_bw_z_ds_zlax_pitm_prcond.prod_cond; ELWIS: t_s_itm_prom_prcond.prod_prcond',
   product_cond_label                  VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Warenzustand - Bezeichnung; X=;E=;T=;W=;U=;O=;',
   uom_cd_plan                         VARCHAR(20)      COMMENT 'Planmengeneinheit - Code; SAP-Retail: ?; SAP-BW: t_bw_z_ds_zlax_pitm_pcwh.plan_qty_me; ELWIS: t_s_itm_prom_qty.prom_qty_uom_sid',
   plan_qty                            NUMBER(18,5)     COMMENT 'Planmenge; SAP-Retail: ?; SAP-BW: t_bw_z_ds_zlax_pitm_pcwh.plan_qty; ELWIS: t_s_itm_prom_qty.prom_qty',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Artikel/Promotion-Bez. ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PROMOTION_ITEM_HIST PRIMARY KEY (prom_sid, item_sid, uom_sid_sales, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. PROR; Aktionsdaten pro Artikel;
             SAP-Retail: wakp;
             SAP-BW: t_bw_0rt_mat_prm_attr, t_bw_z_ds_zlax_pitm_prcond, t_bw_z_ds_zlax_pitm_pcwh;
             ELWIS: t_s_itm_prom_attr, t_s_itm_prom_qty, t_s_itm_prom_prcond';

