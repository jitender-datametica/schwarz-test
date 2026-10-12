CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_sb_beurteil_detail_1 (mandant_id, beurteilung_detail_id,
detail_nr) AS SELECT mandant_id,
 beurteilung_detail_id,
 detail_nr
FROM kfl_production_dbp_view.v_l_sb_beurteil_detail_1 AS V01;