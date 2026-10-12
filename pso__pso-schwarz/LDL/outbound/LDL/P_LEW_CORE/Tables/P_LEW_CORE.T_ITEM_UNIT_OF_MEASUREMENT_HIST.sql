/* --------------------------------------------------------------------------------
   DDL for table: t_item_unit_of_measurement_hist
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_unit_of_measurement_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel; FK auf ITEM; SAP-Retail: marm.matnr; SAP-BW: t_bw_z_ds_marm.matnr'),
uom_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mengeneinheit; FK auf UNIT OF MEASUREMENT; SAP-Retail: marm.meinh; SAP-BW: t_bw_z_ds_marm.meinh'),
uom_sid_sub BIGNUMERIC(38,0)
OPTIONS(description='Untergeordnete Mengeneinheit in einer Verpackungshierarchie; FK auf UNIT OF MEASUREMENT; SAP-Retail: marm.mesub; SAP-BW: t_bw_z_ds_marm.mesub'),
uom_sid_size BIGNUMERIC(38,0)
OPTIONS(description='Einheit fur Lange/Breite/Hohe; FK auf UNIT OF MEASUREMENT; SAP-Retail: marm.meabm; SAP-BW: t_bw_z_ds_marm.meabm'),
uom_sid_volume BIGNUMERIC(38,0)
OPTIONS(description='Volumeneinheit; FK auf UNIT OF MEASUREMENT; SAP-Retail: marm.voleh; SAP-BW: t_bw_z_ds_marm.voleh'),
uom_sid_weight BIGNUMERIC(38,0)
OPTIONS(description='Gewichtseinheit; FK auf UNIT OF MEASUREMENT; SAP-Retail: marm.gewei; SAP-BW: t_bw_z_ds_marm.gewei'),
uom_cd STRING(20) OPTIONS(description='Mengeneinheit; SAP-Retail: marm.meinh; SAP-BW: t_bw_z_ds_marm.meinh'),
uom_cd_sub STRING(20)
OPTIONS(description='Untergeordnete Mengeneinheit in einer Verpackungshierarchie; SAP-Retail: marm.mesub; SAP-BW: t_bw_z_ds_marm.mesub'),
conv_to_base_numerator NUMERIC(18,5)
OPTIONS(description='Zahler fur die Umrechnung in Basismengeneinheiten; SAP-Retail: marm.umrez; SAP-BW: t_bw_z_ds_marm.umrez; ELWIS: t_s_itm_quantity_unit.num'),
conv_to_base_denominator NUMERIC(18,5)
OPTIONS(description='Nenner fur die Umrechnung in Basismengeneinheiten; SAP-Retail: marm.umren; SAP-BW: t_bw_z_ds_marm.umren; ELWIS: t_s_itm_quantity_unit.denom'),
uom_cd_size STRING(20)
OPTIONS(description='Einheit fur Lange/Breite/Hohe; SAP-Retail: marm.meabm; SAP-BW: t_bw_z_ds_marm.meabm'),
length NUMERIC(18,5) OPTIONS(description='Laenge; SAP-Retail: marm.laeng; SAP-BW: t_bw_z_ds_marm.laeng'),
width NUMERIC(18,5) OPTIONS(description='Breite; SAP-Retail: marm,breit; SAP-BW: t_bw_z_ds_marm.breit'),
height NUMERIC(18,5) OPTIONS(description='Hoehe; SAP-Retail: marm.hoehe; SAP-BW: t_bw_z_ds_marm.hoehe'),
uom_cd_volume STRING(20) OPTIONS(description='Volumeneinheit; SAP-Retail: marm.voleh; SAP-BW: t_bw_z_ds_marm.voleh'),
volume NUMERIC(18,5) OPTIONS(description='Volumen; SAP-Retail: marm.volum; SAP-BW: t_bw_z_ds_marm.volum'),
uom_cd_weight STRING(20) OPTIONS(description='Gewichtseinheit; SAP-Retail: marm.gewei; SAP-BW: t_bw_z_ds_marm.gewei'),
weight_gross NUMERIC(18,5) OPTIONS(description='Bruttogewicht; SAP-Retail: marm.brgew; SAP-BW: t_bw_z_ds_marm.brgew'),
gtin STRING(20)
OPTIONS(description='Global Trade Item Number (GTIN); SAP-Retail: marm.ean11; SAP-BW: t_bw_z_ds_marm.ean11; EDWH: t_s_itm_quantity_unit.gtin_id'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel-Messeinheit-Bez. ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, uom_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. IUOMH; Mengeneinheiten zum Artikel;              SAP-Retail: marm;              SAP-BW: t_bw_z_ds_marm;             ELWIS: t_s_itm_quantity_unit;             WAWI: ');