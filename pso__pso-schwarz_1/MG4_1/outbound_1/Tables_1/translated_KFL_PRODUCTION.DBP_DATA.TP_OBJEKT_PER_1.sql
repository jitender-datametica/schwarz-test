CREATE OR REPLACE TABLE kfl_production_dbp_data.tp_objekt_per_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
tp_objekt_id INTEGER NOT NULL OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
techn_platz_id STRING(30) NOT NULL
OPTIONS(description='Der technische Platz ist eine_1 von Kaufland Facility Management verwaltete Einheit'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
tp_objekt_typ STRING(1) OPTIONS(description='Equipmenttyp'),
hersteller_name STRING(30) OPTIONS(description='Hersteller der Anlage_1'),
hersteller_land_id STRING(2) OPTIONS(description='Herstellerland'),
hersteller_typ_bez STRING(20) OPTIONS(description='Typenbezeichnung des Herstellers'),
hersteller_serial_id STRING(30) OPTIONS(description='Serialnummer gemäß Hersteller'),
bau_kj INTEGER OPTIONS(description='Baujahr'),
bau_kjmo INTEGER OPTIONS(description='Baumonat'),
dat_gewaehrleistung_start DATE OPTIONS(description='Gewährleistungsdatum'),
dat_gewaehrleistung_ende DATE OPTIONS(description='Datum, an dem die Gewährleistung endet'),
tp_objekt_nr STRING(30) OPTIONS(description='Objektnummer'),
PRIMARY KEY (mandant_id, tp_objekt_id, dat_von) NOT ENFORCED
) OPTIONS(description='IOS - Historisierte mandantenbezogene Stammtabelle für Objekte eines technischen Platzes.');