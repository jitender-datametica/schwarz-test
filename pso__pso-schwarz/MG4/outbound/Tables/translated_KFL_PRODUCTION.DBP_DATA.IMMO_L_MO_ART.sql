CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_l_mo_art (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
mo_art_kz STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Kennzeichen der Flächenart (Mietobjekt)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='IMMO - Lookup Tabelle für die Flächenart (Mietobjekt) - SAP REFX - ZRE_FLAECHENARTT');