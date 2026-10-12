CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_in_art_spr_zu_pl (mandant_id, in_art_id, art_bez) AS SELECT
 mandant_id,
 in_art_id,
 art_bez
FROM kfl_production_dbp_view.v_in_art_spr_zu AS V01
WHERE spr_id = 90;