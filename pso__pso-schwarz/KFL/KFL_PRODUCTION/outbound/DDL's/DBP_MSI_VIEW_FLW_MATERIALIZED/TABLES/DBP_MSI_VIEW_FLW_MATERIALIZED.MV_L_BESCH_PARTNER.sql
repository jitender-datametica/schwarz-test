CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_besch_partner (
faktura_beleg_id INTEGER,
mandant_id INTEGER,
in_kunde_id INTEGER,
kunde_nr STRING(21) COLLATE 'und:ci',
kunde_name STRING(40) COLLATE 'und:ci'
);