CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_l_artikel_2 AS SELECT geku_artikel_uid,
 geku_artikel_id,
 geku_grund_uid,
 land_iso,
 geku_dwh_artikel_id,
 3 AS kmr_quelle_id
FROM kfl_production_dbp_view.v_l_geku_artikel_2 AS V01;