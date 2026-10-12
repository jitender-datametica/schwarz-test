CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_einh_1 (einh_id, mandant_id) AS SELECT einh_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_einh_1
WHERE mandant_id <> 1
UNION ALL
SELECT DISTINCT ' ' AS einh_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_einh_1
WHERE mandant_id <> 1;