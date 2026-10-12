CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_auftrag_pps (
mandant_id INTEGER,
auftrag_id STRING(20) COLLATE 'und:ci',
in_art_id INTEGER,
dat_ende DATE,
dat_start DATE
);