DROP TABLE IF EXISTS kfl_production_dbp_msi_data.kl_listung_kmo_20200414_171500;
--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.kl_listung_kmo_20200414_171500 (
mandant_id INTEGER NOT NULL,
listung_art STRING(400) COLLATE 'und:ci' NOT NULL,
art_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
sm_id_selected INTEGER,
ksm_id_selected STRING(16) COLLATE 'und:ci',
sm_id INTEGER,
ksm_id STRING(16) COLLATE 'und:ci',
umsatz_hr NUMERIC(29,4) NOT NULL,
absatz_hr NUMERIC(29,4) NOT NULL,
rohertrag_hr NUMERIC(29,4) NOT NULL,
erweiterung_fg INTEGER DEFAULT 0,
reduktion_fg INTEGER DEFAULT 0,
kjwo_update INTEGER,
list_kz STRING(8) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
) CLUSTER BY kjwo_update, art_id;