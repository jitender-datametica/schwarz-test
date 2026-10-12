CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_bewertungskreis_monat_2 AS SELECT mandant_id,
 bewertungskreis_id,
 art_id,
 gjmo,
 preis_steuer_kz,
 wrg_id,
 gld,
 standard_preis,
 menge_bestand_bme,
 wert_bestand,
 vk_wert
FROM kfl_production_dbp_data.art_bewertungskreis_monat_2;