CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_lieferant_2 (
in_lief_id INTEGER,
mandant_id INTEGER,
lief_name STRING(161),
in_lief_nr STRING(10) COLLATE 'und:ci',
gp_ort STRING(40) COLLATE 'und:ci',
lief_betreuer_id INTEGER,
werk_id INTEGER,
mandant_id_werk INTEGER,
in_lief_grp_id INTEGER,
in_lief_grp_mandant_id INTEGER
);