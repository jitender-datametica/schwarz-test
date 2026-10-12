CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_handling_unit_1 (
mandant_id INTEGER,
handling_unit_id INTEGER,
in_kunde_id INTEGER,
handling_unit_id_ext STRING(20) COLLATE 'und:ci',
ntvol_ladung NUMERIC(29,3),
brtvol_ladung NUMERIC(29,3),
ntgew_ladung NUMERIC(29,3),
brtgew_ladung NUMERIC(29,3),
hu_voleinh_id STRING(3) COLLATE 'und:ci',
hu_geweinh_id STRING(3) COLLATE 'und:ci'
);