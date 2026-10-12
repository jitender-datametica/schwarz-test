CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_sb_grund_2 (sb_grund_id, mandant_id) AS SELECT sb_grund_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_sb_grund_2 AS V01;