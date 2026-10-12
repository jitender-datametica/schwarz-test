CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_oug_id_2 AS SELECT oug_id
FROM kfl_production_dbp_view.v_l_oug_id_2
WHERE mandant_id = 1
UNION ALL
SELECT 0 AS oug_id
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1;