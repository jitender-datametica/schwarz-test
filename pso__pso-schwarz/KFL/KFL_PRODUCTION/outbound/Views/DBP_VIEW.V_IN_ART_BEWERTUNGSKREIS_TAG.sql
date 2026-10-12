CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_art_bewertungskreis_tag AS SELECT mandant_id,
 in_art_id,
 bewertungskreis_id,
 dat,
 wrg_id,
 menge_bestand_bme,
 betrag_preis_bestand,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_art_bewertungskreis_tag;