/* --------------------------------------------------------------------------------
   DDL for table: t_item_gtin_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_gtin_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2; FK auf ITEM_2; SAP-Retail: mean.matnr;'),
uom_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mengeneinheit fuer Anzeige; FK auf UNIT_2 OF MEASUREMENT; SAP-Retail: mean.meinh'),
seq_nr STRING(20) NOT NULL OPTIONS(description='Laufende Nummer; SAP-Retail: mean.lfnum'),
uom_cd STRING(20) OPTIONS(description='Mengeneinheit fuer Anzeige; SAP-Retail: mean.MEINH'),
gtin STRING(20)
OPTIONS(description='Global Trade Item_2 Number (GTIN); SAP-Retail: mean.EAN11; SAP-BW: t_bw_z_ds_mean.EAN11'),
gtin_type_mark STRING(20)
OPTIONS(description='Nummerntyp-Code der Global Trade Item_2 Number; SAP-Retail: mean.EANTP; SAP-BW: t_bw_z_ds_mean.EANTP'),
gtin_type_label STRING(100) OPTIONS(description='Nummerntyp-Code Beschreibung'),
main_gtin_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichen Haupt-GTIN; SAP-Retail: mean.HPEAN; SAP-BW: t_bw_z_ds_mean.HPEAN'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2-GTIN-Zuordnung ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, uom_sid, seq_nr, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. IGTIH; Global Trade Item_2 Number(s) (GTIN) zum Artikel_2;              SAP-Retail: MEAN_2;             SAP-BW: t_bw_z_ds_mean;             ELWIS: t_s_itm_gtin             WAWI: t_itm_ean');