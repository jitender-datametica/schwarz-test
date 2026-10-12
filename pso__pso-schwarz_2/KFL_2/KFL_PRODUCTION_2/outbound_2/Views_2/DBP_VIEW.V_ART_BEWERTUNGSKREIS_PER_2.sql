CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_bewertungskreis_per_2 AS SELECT mandant_id,
 bewertungskreis_id,
 art_id,
 dat_von,
 preis_steuer_kz,
 wrg_id,
 dat_bis,
 dat_aenderung,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_aenderung AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_aenderung,
 gld,
 standard_preis,
 menge_bestand_bme,
 wert_bestand,
 vk_wert
FROM kfl_production_dbp_data.art_bewertungskreis_per_2;