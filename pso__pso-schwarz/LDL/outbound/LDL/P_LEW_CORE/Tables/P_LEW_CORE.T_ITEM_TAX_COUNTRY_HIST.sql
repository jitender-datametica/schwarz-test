/* --------------------------------------------------------------------------------
   DDL for table: t_item_tax_country_hist
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_tax_country_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel; FK auf ITEM; SAP-Retail: mlan.matnr; SAP-BW: t_bw_z_ds_mlan.matnr'),
country_pol_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferndes Land; FK auf COUNTRY POLITICAL; SAP-Retail: mlan.aland; SAP-BW: t_bw_z_ds_mlan.aland'),
country_pol_cd STRING(20) OPTIONS(description='Lieferndes Land; SAP-Retail: mlan.aland; SAP-BW: t_bw_z_ds_mlan.aland'),
tax_class_cd STRING(20)
OPTIONS(description='Steuerklassifikation Artikel; SAP-Retail: mlan.taxm1; SAP-BW: t_bw_z_ds_mlan.taxm1'),
tax_indicator_cd STRING(20)
OPTIONS(description='Steuerindikator Artikel (Einkauf); SAP-Retail: mlan.taxim; SAP-BW: t_bw_z_ds_mlan.taxim'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Steuerinfo fuer Artikel im Land ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen'),
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
OPTIONS(description='$Revision: 0000 $. ITXCH; Steuerklassifikation zum Artikel pro Land;              SAP-Retail: mlan;              SAP-BW: t_bw_z_ds_mlan;             ELWIS: t_s_itm_tax');