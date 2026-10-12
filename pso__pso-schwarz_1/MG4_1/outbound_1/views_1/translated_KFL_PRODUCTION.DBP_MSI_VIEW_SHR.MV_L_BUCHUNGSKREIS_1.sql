CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_buchungskreis_1 (mandant_id, buchungskreis_id, gj_variante_id
, land_id, wrg_id, system_id, kontenplan_id, buchungskreis_glob_id) AS SELECT mandant_id,
 buchungskreis_id,
 gj_variante_id,
 land_id,
 wrg_id,
 system_id,
 kontenplan_id,
 buchungskreis_glob_id
FROM kfl_production_dbp_view.v_l_buchungskreis_1 AS v01;