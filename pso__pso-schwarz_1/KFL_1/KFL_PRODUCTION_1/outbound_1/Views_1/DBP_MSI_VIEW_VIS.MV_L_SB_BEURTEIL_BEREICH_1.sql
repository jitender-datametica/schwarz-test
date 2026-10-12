CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_sb_beurteil_bereich_1 (mandant_id, beurteilung_bereich_id,
bereich_nr) AS SELECT mandant_id,
 beurteilung_bereich_id,
 bereich_nr
FROM kfl_production_dbp_view.v_l_sb_beurteil_bereich_1 AS V01;