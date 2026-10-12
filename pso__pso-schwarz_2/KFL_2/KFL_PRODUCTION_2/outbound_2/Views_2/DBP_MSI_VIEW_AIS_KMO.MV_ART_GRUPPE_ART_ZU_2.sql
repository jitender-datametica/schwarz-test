CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_gruppe_art_zu_2 (art_gruppe_id, mandant_id, art_id,
umrech_faktor) AS SELECT art_gruppe_id,
 mandant_id,
 art_id,
 umrech_faktor
FROM kfl_production_dbp_view.v_art_gruppe_art_zu_2 AS V01
WHERE mandant_id > 1;