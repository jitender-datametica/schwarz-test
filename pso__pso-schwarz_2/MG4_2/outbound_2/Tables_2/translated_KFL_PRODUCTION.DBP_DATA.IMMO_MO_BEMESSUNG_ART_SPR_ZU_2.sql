CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_mo_bemessung_art_spr_zu_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
bemessung_art_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bemessungsart'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
bemessung_art_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='IMMO - Sprachabhängige Bezeichnung für die Bemessungsart (Mietobjekt) - SAP REFX - TIVBDMEAST');