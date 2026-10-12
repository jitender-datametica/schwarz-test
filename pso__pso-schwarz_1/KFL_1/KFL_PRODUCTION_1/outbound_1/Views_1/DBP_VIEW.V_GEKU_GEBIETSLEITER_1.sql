CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_gebietsleiter_1 AS SELECT gebietsleiter_uid,
 vertriebsbuero_uid,
 gebietsleiter_bez,
 berichts_empfaenger_ldap,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_gebietsleiter_1;