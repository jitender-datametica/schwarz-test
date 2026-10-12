CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_vertriebsbuero_2 (vertriebsbuero_uid, country_uid,
vertriebsbuero_bez, td_update, td_insert) AS SELECT vertriebsbuero_uid,
 country_uid,
 vertriebsbuero_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_vertriebsbuero_2;