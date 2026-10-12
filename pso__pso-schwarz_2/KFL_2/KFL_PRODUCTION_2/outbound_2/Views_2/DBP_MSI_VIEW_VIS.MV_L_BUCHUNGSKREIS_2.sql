CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_buchungskreis_2 (mandant_id, buchungskreis_id, gj_variante_id
, land_id, wrg_id, system_id, kontenplan_id, buchungskreis_glob_id) AS SELECT V01.mandant_id,
 V01.buchungskreis_id,
 V01.gj_variante_id,
 V01.land_id,
 V01.wrg_id,
 V01.system_id,
 V01.kontenplan_id,
 V01.buchungskreis_glob_id
FROM kfl_production_dbp_view.v_l_buchungskreis_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_l_system_2 AS V02 ON V01.system_id = V02.system_id
WHERE V02.system_gruppe = 'SAP RET';