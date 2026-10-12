CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_werk_1 (
werk_id INTEGER,
mandant_id INTEGER,
werk_nr STRING(4) COLLATE 'und:ci',
werk_name STRING(30) COLLATE 'und:ci',
laengengrad BIGNUMERIC(38,16),
breitengrad BIGNUMERIC(38,16)
);