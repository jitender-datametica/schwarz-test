/* --------------------------------------------------------------------------------
   DDL for table: t_item_bom_pos_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_bom_pos_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_bom_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key ITEM_2 BOM'),
src_stlkn BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Knotennummer der Stuecklistenposition; SAP-Retail: stpo.stlkn; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stlkn; ELWIS: t_s_itm_bom_pos.itm_node_stlkn'),
bom_pos_nr STRING(20)
OPTIONS(description='SAP-Retail: stpo.posnr; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.posnr; ELWIS: t_s_itm_bom_pos.bom_pos_nr'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Stucklistenkomponente; FK auf ITEM_2; SAP-Retail: stpo.idnrk; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.idnrk; ELWIS: t_s_itm_bom_pos.component'),
uom_sid BIGNUMERIC(38,0)
OPTIONS(description='Komponentenmengeneinheit; FK auf UNIT_2 OF MEASUREMENT; SAP-Retail: stpo.meins; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.meins; ELWIS: t_s_itm_bom_pos.base_qty_uom_sid'),
version_counter BIGNUMERIC(38,0)
OPTIONS(description='Interner Zaehler; SAP-Retail: stpo.stpoz; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stpoz; ELWIS: '),
uom_cd STRING(20)
OPTIONS(description='Komponentenmengeneinheit; SAP-Retail: stpo.meins; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.meins'),
component_qty NUMERIC(18,5)
OPTIONS(description='Komponentenmenge; SAP-Retail: stpo.menge; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.menge; ELWIS: t_s_itm_bom_pos.comp_qty'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Item_2 BOM Position ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_bom_sid, src_stlkn, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. IBOP; Stuecklistenposition; Enthaelt die ITEMs (=Stuecklistenkomp.) eines Sammelartikels (=Stueckliste_2)             SAP-Retail: stpo_2;              SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo;             ELWIS: t_s_itm_bom_pos             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx#lzpWikiToC-topic-16');