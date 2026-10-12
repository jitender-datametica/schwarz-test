/* --------------------------------------------------------------------------------
   DDL for table: t_item_bom_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_bom_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_bom_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key ITEM_2 BOM'),
src_matnr STRING(20)
OPTIONS(description='Artikelnummer; SAP-Retail: mast.matnr; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.matnr'),
src_werks STRING(20)
OPTIONS(description='Betrieb; SAP-Retail: mast.werks; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.werks - bei LIDL-Stucklisten nicht verwendet'),
src_stlnr STRING(20)
OPTIONS(description='Stueckliste_2; SAP-Retail: mast.stlnr; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stlnr'),
src_stlan STRING(20)
OPTIONS(description='Stuecklistenverwendung; SAP-Retail: mast.stlan; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stlan'),
src_stlal STRING(20)
OPTIONS(description='Stuecklistenalternative; SAP-Retail: mast.stlal; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stlal; ELWIS: t_s_itm_bom.alt_bom'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Sammelartikel; FK auf ITEM_2; SAP-Retail: mast.matnr; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.matnr; ELWIS: t_s_itm_bom.itm_sid'),
bom_alternative_cd_act STRING(20)
OPTIONS(description='Stuecklistenalternative (akt. Auspraegung in t_item_bom_hist_2); nur bei Pfandgut (src_stlan / Verwendung = 7) bei Unterschieden (Alt. 1: Beschaffungsvariante; Alt. 2: Verkaufsartikel); SAP-Retail: mast.stlal; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stlal'),
version_counter_act BIGNUMERIC(38,0)
OPTIONS(description='Interner Zaehler; SAP-Retail: stko.stkoz; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stkoz; ELWIS: t_s_itm_bom.stko_cnt'),
active_from_dt_act DATE NOT NULL
OPTIONS(description='Datum gueltig ab; SAP-Retail: stko.datuv; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.datuv; ELWIS: t_s_itm_bom.bom_valid_from_dat'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Item_2 BOM ist im Falle deleted_fg = 1 als nicht mehr im Quellsystem bekannt interpretiert; SAP-Retail: stko.lkenz; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.lkenz'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (item_bom_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. IBOM; Stucklistenkopf;              SAP-Retail: stko_2 & mast_2;              SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo;             ELWIS: t_s_itm_bom             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx#lzpWikiToC-topic-16');