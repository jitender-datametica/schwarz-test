CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_lagerbew_1 (
mandant_id INTEGER,
lagerbew_beleg_id INTEGER,
kj INTEGER,
vorgangsart_id STRING(2) COLLATE 'und:ci',
dat_beleg DATE,
dat_buch DATE,
dat_erfasst DATE,
ref_lagerbew_beleg_id STRING(20) COLLATE 'und:ci',
belegkopftext STRING(30) COLLATE 'und:ci'
);