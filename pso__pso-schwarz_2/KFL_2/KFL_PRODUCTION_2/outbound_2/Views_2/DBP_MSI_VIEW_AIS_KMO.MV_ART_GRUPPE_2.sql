CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_gruppe_2 (art_gruppe_id, art_gruppe_bez,
art_gruppe_bereich, art_gruppe_bemerkung, art_gruppe_kategorie, dat_anlage, dat_aenderung) AS SELECT art_gruppe_id,
 art_gruppe_bez,
 art_gruppe_bereich,
 art_gruppe_bemerkung,
 art_gruppe_kategorie,
 dat_anlage,
 dat_aenderung
FROM kfl_production_dbp_view.v_art_gruppe_2 AS V01;