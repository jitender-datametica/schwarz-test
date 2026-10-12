CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_gebiets_bereich_2 (
gebiets_bereich_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Gebietsbereichs aus gbb_uid'),
verteilgebiet_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Verteilgebiets'),
gebiets_betreuer_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID eines Gebietsbetreuers'),
gebiets_bereich_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Gebietsbereiche aus code_name'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (gebiets_bereich_uid) NOT ENFORCED
) OPTIONS(description='GEKU - Lookup-Tabelle der Gebietsbereiche aus wmd_gbb_out');