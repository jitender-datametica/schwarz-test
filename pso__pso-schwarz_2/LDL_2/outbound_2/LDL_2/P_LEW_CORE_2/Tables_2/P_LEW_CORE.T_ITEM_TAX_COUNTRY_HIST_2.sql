/* --------------------------------------------------------------------------------
   DDL for table: t_item_tax_country_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_tax_country_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2; FK auf ITEM_2; SAP-Retail: mlan.matnr; SAP-BW: t_bw_z_ds_mlan.matnr'),
country_pol_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferndes Land_2; FK auf COUNTRY_2 POLITICAL; SAP-Retail: mlan.aland; SAP-BW: t_bw_z_ds_mlan.aland'),
country_pol_cd STRING(20) OPTIONS(description='Lieferndes Land_2; SAP-Retail: mlan.aland; SAP-BW: t_bw_z_ds_mlan.aland'),
tax_class_cd STRING(20)
OPTIONS(description='Steuerklassifikation Artikel_2; SAP-Retail: mlan.taxm1; SAP-BW: t_bw_z_ds_mlan.taxm1'),
tax_indicator_cd STRING(20)
OPTIONS(description='Steuerindikator Artikel_2 (Einkauf); SAP-Retail: mlan.taxim; SAP-BW: t_bw_z_ds_mlan.taxim'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Steuerinfo fuer Artikel_2 im Land_2 ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, country_pol_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. ITXCH; Steuerklassifikation zum Artikel_2 pro Land_2;              SAP-Retail: mlan_2;              SAP-BW: t_bw_z_ds_mlan;             ELWIS: t_s_itm_tax');