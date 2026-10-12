CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_energiedaten (
mandant_id INTEGER,
zaehler_id STRING(10) COLLATE 'und:ci',
dat DATE,
kjmo INTEGER,
pc_id STRING(10) COLLATE 'und:ci',
krk_id STRING(4) COLLATE 'und:ci',
menge_verbraucht NUMERIC(29,5)
);