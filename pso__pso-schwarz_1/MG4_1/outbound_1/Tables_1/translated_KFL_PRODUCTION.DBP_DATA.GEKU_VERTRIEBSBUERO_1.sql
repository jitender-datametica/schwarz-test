CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_vertriebsbuero_1 (
vertriebsbuero_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Vertriebsbüros aus rvl_nr'),
country_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Landes aus country_nr'),
vertriebsbuero_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Vertriebsbüros'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (vertriebsbuero_uid) NOT ENFORCED
) OPTIONS(description='GEKU - Lookup Tabelle der Vertriebsbüros aus wmd_rvl_out');