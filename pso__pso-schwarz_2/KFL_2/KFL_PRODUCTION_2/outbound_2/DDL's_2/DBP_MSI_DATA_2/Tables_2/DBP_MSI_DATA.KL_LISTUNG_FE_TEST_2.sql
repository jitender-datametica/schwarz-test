DROP TABLE IF EXISTS kfl_production_dbp_msi_data.kl_listung_fe_test_2;
--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.kl_listung_fe_test_2 (
mandant_id INTEGER NOT NULL,
listung_art STRING(400) COLLATE 'und:ci' NOT NULL,
sm_id_selected INTEGER NOT NULL,
art_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
sm_id INTEGER NOT NULL,
ost_basis STRING(4) COLLATE 'und:ci' NOT NULL,
ost_gross STRING(4) COLLATE 'und:ci' NOT NULL,
sued_ost STRING(4) COLLATE 'und:ci' NOT NULL,
sued_west STRING(4) COLLATE 'und:ci' NOT NULL,
west STRING(4) COLLATE 'und:ci' NOT NULL,
nord STRING(4) COLLATE 'und:ci' NOT NULL,
umsatz_hr NUMERIC(29,4),
absatz_hr NUMERIC(29,4),
rohertrag_hr NUMERIC(29,4),
erweiterung_fg INTEGER DEFAULT 0,
reduktion_fg INTEGER DEFAULT 0,
kjwo_update INTEGER,
list_kz STRING(8) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
) CLUSTER BY kjwo_update;