-- 16.01.2014 twie: neue Spalte gebietsleiter_ldap für Emailversand der Berichte

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_geku_gebietsleiter_1 (gebietsleiter_uid, vertriebsbuero_uid, gebietsleiter_bez
, gebietsleiter_ldap) AS SELECT gebietsleiter_uid,
 vertriebsbuero_uid,
 gebietsleiter_bez,
 berichts_empfaenger_ldap AS gebietsleiter_ldap
FROM kfl_production_dbp_view.v_geku_gebietsleiter_1;