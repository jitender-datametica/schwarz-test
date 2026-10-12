CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_einh (mandant_id, einh_id) AS SELECT DISTINCT mandant_id,
 einh_id
FROM kfl_production_dbp_view.v_l_einh
WHERE mandant_id = 1
UNION ALL
SELECT DISTINCT mandant_id,
 ' ' AS einh_id
FROM kfl_production_dbp_view.v_l_einh
WHERE mandant_id = 1;