CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_shr_materialized.mv_ma_kostenstelle_zu_per (
mandant_id INTEGER,
mitarbeiter_id STRING(20),
kjmo INTEGER,
kostenstelle_id STRING(10) COLLATE 'und:ci',
kostenstelle_id_alt STRING(10) COLLATE 'und:ci',
haupt_kst_fg INTEGER,
stunden_lohnart_2704 NUMERIC(29,2),
kst_wechsel INTEGER,
austritt_intern INTEGER
);