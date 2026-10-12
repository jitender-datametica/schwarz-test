CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artkz_display (mandant_id, art_id, display_art_id, display_bez
) AS SELECT V01.mandant_id,
 V01.art_id,
 V02.art_id AS art_id_display,
  CASE
  WHEN V02.art_id IS NULL
  THEN 'kein Displayartikel'
  ELSE 'Displayartikel'
  END AS display_bez
FROM kfl_production_dbp_data.art AS V01
 LEFT JOIN kfl_production_dbp_data.stueckliste AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id = V02.art_id;