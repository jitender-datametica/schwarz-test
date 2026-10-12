CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_oug_id AS SELECT oug_id
FROM kfl_production_dbp_view.v_l_oug_id
WHERE mandant_id = 1
UNION ALL
SELECT 0 AS oug_id
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;