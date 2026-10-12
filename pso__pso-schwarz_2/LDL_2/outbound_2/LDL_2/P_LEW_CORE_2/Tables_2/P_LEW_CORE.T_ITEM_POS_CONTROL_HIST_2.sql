/* --------------------------------------------------------------------------------
   DDL for table: t_item_pos_control_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_pos_control_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2; FK auf ITEM_2;  SAP-Retail: wlk2.matnr;'),
sales_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Verkaufsorganisation; FK auf SALES_2 ORGANISATION; SAP-Retail; wlk2.vkorg; SAP-BW: t_bw_z_ds_wlk2.vkorg'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Handelsbetrieb; FK auf LOCATION_2; SAP-Retail: wlk2.werks; SAP-BW: t_bw_z_ds_wlk2.werks'),
distribution_channel_cd STRING(20) NOT NULL
OPTIONS(description='Vertriebsweg in Vertriebs-Linie Retail (Code); SAP-Retail: wlk2.vtweg; SAP-BW: t_bw_z_ds_wlk2.vtweg'),
scale_area STRING(20)
OPTIONS(description='Waagenkreis; SAP-Retail: wlk2.scagr; SAP-BW: t_bw_z_ds_wlk2.scagr; ELWIS: t_s_itm_pos_control_data.scale_area_cd'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikelsteuerungsinfo ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, sales_org_sid, loc_sid, distribution_channel_cd, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. ITPC; Artikel_2-Stammdaten SAP Retail / Teil POS-Steuerungs-Daten;             SAP-Retail: wlk2_2;             SAP-BW: t_bw_z_ds_wlk2;             ELWIS: t_s_itm_pos_control_data');