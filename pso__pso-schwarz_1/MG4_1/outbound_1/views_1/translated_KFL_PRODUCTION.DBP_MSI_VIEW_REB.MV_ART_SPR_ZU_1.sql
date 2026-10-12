CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_art_spr_zu_1 (spr_id, art_id, mandant_id, art_bez, art_id_bez)
AS SELECT spr_id,
 art_id,
 mandant_id,
  CASE
  WHEN SUBSTR(art_bez, 1, 11) = 'Wertartikel' AND art_id < 0
  THEN 'Sachkonto WG ' || TRIM(SUBSTR(CAST(art_id / - 1000 AS STRING), 1, 11))
  ELSE art_bez
  END AS art_bez,
 SUBSTR(CAST(SUBSTR(CAST(art_id AS STRING), 1, 10) || '   ' || art_bez AS STRING), 1, 50) AS art_id_bez
FROM kfl_production_dbp_view.v_art_spr_zu_1
WHERE spr_id = 22
 AND mandant_id = 1;