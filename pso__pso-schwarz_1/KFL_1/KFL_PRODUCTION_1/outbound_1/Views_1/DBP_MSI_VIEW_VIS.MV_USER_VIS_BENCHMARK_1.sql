CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_user_vis_benchmark_1 (mandant_id, user_id, hierarchie_ebene_id,
hierarchie_element_id) AS SELECT mandant_id,
 LOWER(user_id) AS user_id,
 hierarchie_ebene_id,
 hierarchie_element_id
FROM kfl_production_dbp_msi_v_view.v_user_vis_benchmark_zu_1 AS T01;