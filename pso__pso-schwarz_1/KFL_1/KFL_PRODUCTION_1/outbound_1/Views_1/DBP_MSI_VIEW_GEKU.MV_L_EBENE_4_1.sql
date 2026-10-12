CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_ebene_4_1 (geku_artikel_id, geku_dwh_artikel_id) AS SELECT
 geku_artikel_id,
 geku_dwh_artikel_id
FROM kfl_production_dbp_view.v_l_geku_artikel_1
GROUP BY geku_artikel_id,
 geku_dwh_artikel_id;