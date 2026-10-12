CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_spr_zu_2 (spr_id, art_id, mandant_id, art_bez, art_id_bez)
AS SELECT spr_id,
 art_id,
 mandant_id,
 art_bez,
 SUBSTR(CAST(SUBSTR(CAST(art_id AS STRING), 1, 10) || ' ' || art_bez AS STRING), 1, 61) AS art_id_bez
FROM kfl_production_dbp_view.v_art_spr_zu_2 AS V01
WHERE spr_id = 22;