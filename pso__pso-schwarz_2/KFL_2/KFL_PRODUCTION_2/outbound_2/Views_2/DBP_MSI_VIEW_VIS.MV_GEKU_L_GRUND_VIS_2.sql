CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_l_grund_vis_2 AS SELECT geku_grund_uid AS geku_grund_vis_id
 ,
 geku_grund_id AS geku_grund_vis_nr,
 geku_bereich_uid
FROM kfl_production_dbp_view.v_l_geku_grund_2;