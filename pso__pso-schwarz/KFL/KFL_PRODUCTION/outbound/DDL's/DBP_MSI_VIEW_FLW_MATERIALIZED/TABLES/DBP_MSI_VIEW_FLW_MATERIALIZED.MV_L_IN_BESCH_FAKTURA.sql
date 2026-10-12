CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_besch_faktura (
faktura_beleg_id INTEGER,
mandant_id INTEGER,
in_vw_id INTEGER,
dat_faktura DATE,
dat_erstellung DATE,
fakturaart_id STRING(4) COLLATE 'und:ci',
in_kunde_id INTEGER,
faktura_status_kz STRING(1) COLLATE 'und:ci'
);