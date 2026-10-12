CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.wup_denorm_k_stufe_1 (
mandant_id INTEGER,
wup_id INTEGER,
haeufigste_ultra_frische_listungsstufe_kz STRING(50),
haeufigste_mopro_listungsstufe_kz STRING(50),
haeufigste_tiko_listungsstufe_kz STRING(50),
haeufigste_trocken_listungsstufe_kz STRING(50),
haeufigste_nonfood_listungsstufe_kz STRING(50),
td_insert TIMESTAMP,
td_update TIMESTAMP
);