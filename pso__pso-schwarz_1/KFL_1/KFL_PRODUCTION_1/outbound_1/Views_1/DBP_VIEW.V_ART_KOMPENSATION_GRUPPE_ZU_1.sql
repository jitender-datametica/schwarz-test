CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_kompensation_gruppe_zu_1 AS SELECT art_id,
 mandant_id,
 komp_gruppe_id,
 komp_kriterium_fg,
 komp_faktor,
 td_update,
 td_insert
FROM kfl_production_dbp_data.art_kompensation_gruppe_zu_1;