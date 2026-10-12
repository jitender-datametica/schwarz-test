CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_l_mo_bemessung_art (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
bemessung_art_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bemessungsart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='IMMO - Lookup Tabelle für die Bemessungsart (Mietobjekt) - SAP REFX - TIVBDMEAST');