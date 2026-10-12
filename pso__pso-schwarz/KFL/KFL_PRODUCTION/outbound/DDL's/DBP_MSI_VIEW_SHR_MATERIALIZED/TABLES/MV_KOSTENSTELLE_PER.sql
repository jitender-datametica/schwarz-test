CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_shr_materialized.mv_kostenstelle_per (
mandant_id INTEGER,
kostenstelle_id STRING(10) COLLATE 'und:ci',
kostenstellenart_id STRING(1) COLLATE 'und:ci',
krk_id STRING(4) COLLATE 'und:ci',
kostenstelle_bez STRING(40) COLLATE 'und:ci',
wup_id INTEGER,
standort STRING(160) COLLATE 'und:ci',
kjmo_von STRING(16777216),
kjmo_bis STRING(16777216)
);