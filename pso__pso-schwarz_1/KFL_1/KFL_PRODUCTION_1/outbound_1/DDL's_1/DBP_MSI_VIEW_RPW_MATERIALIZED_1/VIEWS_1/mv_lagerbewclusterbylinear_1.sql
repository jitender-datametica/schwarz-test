DROP TABLE IF EXISTS kfl_production_dbp_msi_view_rpw_materialized.mv_lagerbew_1;
CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_rpw_materialized.mv_lagerbew_1 (
mandant_id INTEGER,
lagerbew_beleg_id INTEGER,
kj INTEGER,
vorgangsart_id STRING(2) COLLATE 'und:ci',
dat_buch DATE,
beleg_user_name STRING(20) COLLATE 'und:ci',
waren_begl_schein_id STRING(10) COLLATE 'und:ci',
dat_beleg DATE,
dat_erfasst DATE,
belegart_id STRING(2) COLLATE 'und:ci',
system_id INTEGER,
belegkopftext STRING(30) COLLATE 'und:ci',
ref_lagerbew_beleg_id STRING(20) COLLATE 'und:ci'
) CLUSTER BY mandant_id, system_id, dat_buch, lagerbew_beleg_id;