CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_gruppe_1 AS SELECT art_gruppe_id,
 art_gruppe_bez,
 art_gruppe_bereich,
 art_gruppe_bemerkung,
 art_gruppe_kategorie,
 dat_anlage,
 dat_aenderung
FROM kfl_production_dbp_data.art_gruppe_1;