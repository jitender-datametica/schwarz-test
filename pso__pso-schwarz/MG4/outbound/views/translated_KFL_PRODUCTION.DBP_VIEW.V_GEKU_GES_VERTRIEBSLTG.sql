CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_ges_vertriebsltg (country_uid, land_iso, land_bez, verteiltag_id,
td_update, td_insert) AS SELECT country_uid,
 land_iso,
 land_bez,
 verteiltag_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_ges_vertriebsltg;