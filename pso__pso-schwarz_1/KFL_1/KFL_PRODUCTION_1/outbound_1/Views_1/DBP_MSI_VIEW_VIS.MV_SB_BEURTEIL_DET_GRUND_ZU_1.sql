CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_beurteil_det_grund_zu_1 (sb_grund_id, mandant_id,
detailnote_id) AS SELECT sb_grund_id,
 mandant_id,
 detailnote_id
FROM kfl_production_dbp_view.v_sb_beurteil_det_grund_zu_1 AS V01;