CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kompensation_gruppe_1 AS SELECT mandant_id,
 komp_gruppe_id,
 komp_gruppe_bez,
 freigabe_fg,
 komp_kriterium_bez,
 anz_art_komp_gruppe,
 td_update,
 td_insert
FROM kfl_production_dbp_data.kompensation_gruppe_1;