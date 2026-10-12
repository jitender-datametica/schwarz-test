CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_beurteil_brch_grund_zu (sb_grund_id, mandant_id,
bereichsnote_id) AS SELECT sb_grund_id,
 mandant_id,
 bereichsnote_id
FROM kfl_production_dbp_view.v_sb_beurteil_brch_grund_zu AS V01;