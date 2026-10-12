CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_gewichtsgrenzen_per_2 (mandant_id, in_art_id, dat,
gewicht_kg_von, gewicht_kg_bis) AS SELECT V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V02.dat,
 V01.gewicht_kg_von,
 V01.gewicht_kg_bis
FROM kfl_production_dbp_view.v_flw_gewichtsgrenzen_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V02 ON V02.dat BETWEEN V01.dat_von AND V01.dat_bis;