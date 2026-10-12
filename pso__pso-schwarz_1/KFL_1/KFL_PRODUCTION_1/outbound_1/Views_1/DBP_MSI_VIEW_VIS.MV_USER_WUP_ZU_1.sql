CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_user_wup_zu_1 (user_id, mandant_id, wup_id) AS SELECT LOWER(user_id
  ) AS user_id,
 mandant_id,
 wup_id
FROM kfl_production_dbp_msi_v_view.v_user_wup_zu_1 AS T01;