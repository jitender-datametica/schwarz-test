CREATE OR REPLACE TABLE kfl_production_dbp_data.wtag_spr_zu_2 (
wtag_id INTEGER NOT NULL OPTIONS(description='Wochentag ID, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
wtag_bez STRING(20) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Wochentags in den DWH-Sprachen'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wtag_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP1_MIS - Bezeichnung der Wochentage in den DWH-Sprachen');