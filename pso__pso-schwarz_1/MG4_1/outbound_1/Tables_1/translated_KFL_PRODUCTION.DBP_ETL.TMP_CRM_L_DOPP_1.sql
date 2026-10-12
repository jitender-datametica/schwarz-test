CREATE OR REPLACE TABLE kfl_production_dbp_etl.tmp_crm_l_dopp_1 (
kundenkarte_id STRING(1020),
mandant_id INTEGER,
crm_kundenkarte_art_id INTEGER,
crm_kundenkarte_nr STRING(144),
crm_konto_id STRING(144),
gesperrt_fg INTEGER,
zeit_von DATETIME,
zeit_bis DATETIME,
geloescht_fg INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
);