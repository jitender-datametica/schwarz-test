CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_geku_artikel_1 (geku_artikel_uid, geku_artikel_id,
geku_grund_uid, land_iso, geku_dwh_artikel_id, kmr_quelle_id, aktiv_fg) AS SELECT geku_artikel_uid,
 geku_artikel_id,
 geku_grund_uid,
 land_iso,
 geku_dwh_artikel_id,
 3 AS kmr_quelle_id,
 aktiv_fg
FROM kfl_production_dbp_view.v_l_geku_artikel_1;