/* --------------------------------------------------------------------------------
   DDL for table: t_item_bom_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_bom_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_bom_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key ITEM_2 BOM'),
bom_alternative_cd STRING(20)
OPTIONS(description='Stuecklistenalternative; siehe t_item_bom.src_stlal; nur bei Pfandgut (src_stlan / Verwendung = 7) bei Unterschieden (Alt. 1: Beschaffungsvariante; Alt. 2: Verkaufsartikel); SAP-Retail: mast.stlal; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stlal'),
version_counter BIGNUMERIC(38,0)
OPTIONS(description='Interner Zaehler; SAP-Retail: stko.stkoz; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stkoz; ELWIS: t_s_itm_bom.stko_cnt'),
active_from_dt DATE NOT NULL
OPTIONS(description='Datum gueltig ab; stko.datuv; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.datuv; ELWIS: t_s_itm_bom.bom_valid_from_dat'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Item_2-BOM ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_bom_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. IBOMH; Stucklistenkopf;              SAP-Retail: stko_2 & mast_2;              SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo;             ELWIS: t_s_itm_bom             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx#lzpWikiToC-topic-16');