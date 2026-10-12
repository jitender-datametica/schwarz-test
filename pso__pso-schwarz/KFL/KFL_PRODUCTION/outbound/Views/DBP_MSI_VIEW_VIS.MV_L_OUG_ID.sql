CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_oug_id (oug_id) AS SELECT oug_id
FROM (SELECT oug_id
   FROM kfl_production_dbp_view.v_l_oug_id
   WHERE oug_id > 0
   GROUP BY oug_id
   UNION ALL
   SELECT 0
   FROM UNNEST(GENERATE_ARRAY(0, 0)) AS SEQ) AS sub00;