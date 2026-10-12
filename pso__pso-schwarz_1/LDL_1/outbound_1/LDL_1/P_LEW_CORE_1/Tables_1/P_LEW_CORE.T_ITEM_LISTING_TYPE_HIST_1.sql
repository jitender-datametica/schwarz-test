/* --------------------------------------------------------------------------------
   DDL for table: t_item_listing_type_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_listing_type_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1; FK auf ITEM_1; SAP-Retail: zmmx_marc_list.matnr; SAP-BW: t_bw_z_ds_zmmx_marc_list.matnr'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Betrieb; FK auf LOCATION_1; SAP-Retail: zmmx_marc_list.werks; SAP-BW: t_bw_z_ds_zmmx_marc_list.werks'),
active_from_dt DATE NOT NULL
OPTIONS(description='Listungsart: Gueltig ab; SAP-Retail: zmmx_marc_list.zz_list_ab; SAP-BW: t_bw_z_ds_zmmx_marc_list.zz_list_ab; ELWIS: t_s_itm_loc_list.list_type_from_dat'),
active_to_dt DATE NOT NULL
OPTIONS(description='Listungsart: Gueltig bis; SAP-Retail: zmmx_marc_list.zz_list_bis; SAP-BW: t_bw_z_ds_zmmx_marc_list.zz_list_bis; ELWIS: t_s_itm_loc_list.list_type_to_dat'),
list_type_mark STRING(20)
OPTIONS(description='Listungsart - Code; (A=Aktion_1, S=Sortiment); SAP-Retail: zmmx_marc_list.zz_key_list; SAP-BW: t_bw_z_ds_zmmx_marc_list.zz_key_list'),
list_type_label STRING(100) COLLATE 'und:ci'
OPTIONS(description='Listungsart - Beschreibung; (A=Aktion_1, S=Sortiment) if (ZZ_KEY_LIST = "A") then "Aktion_1" else if (ZZ_KEY_LIST = "S") then "Sortiment" else NULL '),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Listungsart ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, loc_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. ILIS; Listungsart (Aktion_1, Sortiment) zeitabhangig Betriebe-Ebene;              SAP-Retail: zmmx_marc_list_1;             SAP-BW: t_bw_z_ds_zmmx_marc_list;             ELWIS: t_s_itm_loc_list');