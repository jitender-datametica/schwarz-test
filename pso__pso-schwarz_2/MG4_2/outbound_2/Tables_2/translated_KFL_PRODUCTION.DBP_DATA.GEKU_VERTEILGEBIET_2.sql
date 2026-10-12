CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_verteilgebiet_2 (
verteilgebiet_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Verteilgebiets'),
gebietsleiter_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Gebietsleiters aus pc_nr'),
verteilgebiet_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Verteilgebiets'),
mandant_id INTEGER OPTIONS(description='Mandant_2 im DWH. Gehört zum NILS Verteilgebiet'),
nils_verteilgebiet_id INTEGER
OPTIONS(description='Verteilgebiet ID aus dem System NILS. Wird per Transaction Service oder GEKU-SST gepflegt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (verteilgebiet_uid) NOT ENFORCED
) OPTIONS(description='GEKU - Lookup-Tabelle der Verteilgebiete aus wmd_vg_out');