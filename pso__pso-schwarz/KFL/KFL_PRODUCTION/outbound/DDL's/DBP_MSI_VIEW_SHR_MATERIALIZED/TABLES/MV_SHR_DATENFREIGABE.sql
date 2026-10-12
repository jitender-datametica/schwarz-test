CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_shr_materialized.mv_shr_datenfreigabe (
mandant_id INTEGER,
kjmo INTEGER,
dat DATE,
user_id STRING(30) COLLATE 'und:ci',
shr_freigabe_fg INTEGER
);