CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_zustaendigkeit_1 (kundenfaktor_id, geku_dwh_artikel_id,
kmr_quelle_id, zustaendigkeit) AS SELECT kundenfaktor_id,
 geku_dwh_artikel_id,
 3 AS kmr_quelle_id,
 zustaendigkeit
FROM kfl_production_dbp_view.v_geku_zustaendigkeit_1;