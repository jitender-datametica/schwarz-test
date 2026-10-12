CREATE OR REPLACE TABLE kfl_production_dbp_etl.in_einkaeufer_grp_spr_zu_temp_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH. In der Regel länderbezogen'),
einkaeufer_grp_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Einkäufergruppe aus ekgr'),
spr_id INTEGER NOT NULL OPTIONS(description='Sprache im DWH'),
einkaeufer_grp_bez STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Einkäufergruppe aus eknam'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
);