/* --------------------------------------------------------------------------------
   DDL for table: t_item_sort_box_hist
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_sort_box_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
item_sid_sort_box BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sortierkarton; FK auf ITEM; SAP-Retail: zmmx_os_rel.matnr; SAP-BW: t_bw_z_ds_zmmx_os_rel.matnr'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bestellartikel; FK auf ITEM; SAP-Retail: zmmx_os_rel.matnr_hl; SAP-BW: t_bw_z_ds_zmmx_os_rel.matnr_hl'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel-Sortierbox-Bez. ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid_sort_box, item_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. ISBXH; Zuordnung Bestellartikel - Sortierkarton;             SAP-Retail: zmmx_os_rel;             SAP-BW: t_bw_z_ds_zmmx_os_rel;             ELWIS: t_s_itm_sort_box');