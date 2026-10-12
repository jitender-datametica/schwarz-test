CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_l_grund_1 AS SELECT geku_grund_uid,
 geku_grund_id,
 geku_bereich_uid
FROM kfl_production_dbp_view.v_l_geku_grund_1 AS V01;