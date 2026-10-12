CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_buchungskreis (system_id, mandant_id, buchungskreis_id,
gj_variante_id, land_id, wrg_id, kontenplan_id, buchungskreis_glob_id, td_update, td_insert) AS SELECT system_id,
 mandant_id,
 buchungskreis_id,
 gj_variante_id,
 land_id,
 wrg_id,
 kontenplan_id,
 buchungskreis_glob_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_buchungskreis;