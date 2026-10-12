CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_art_spr_zu AS SELECT spr_id,
 art_id,
 mandant_id,
 art_bez,
   SUBSTR(CAST(art_id AS STRING), 1, 10) || ' ' || art_bez AS art_id_bez
FROM kfl_production_dbp_view.v_art_spr_zu AS V01;