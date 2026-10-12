CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_art_bwrtngskrs_periode_1 AS SELECT mandant_id,
 gjmo,
 bewertungskreis_id,
 in_art_id,
 wrg_id,
 dat_aenderung,
 gjmo_bis,
 mbew_fg,
 menge_bestand_bme,
 wert_bestand
FROM kfl_production_dbp_data.in_art_bwrtngskrs_periode_1;