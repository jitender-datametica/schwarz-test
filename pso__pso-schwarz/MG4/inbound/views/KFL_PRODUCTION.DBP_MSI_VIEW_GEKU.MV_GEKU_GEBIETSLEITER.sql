create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_GEBIETSLEITER(
	GEBIETSLEITER_UID,
	VERTRIEBSBUERO_UID,
	GEBIETSLEITER_BEZ,
	GEBIETSLEITER_LDAP
) as
-- 16.01.2014 twie: neue Spalte gebietsleiter_ldap für Emailversand der Berichte

   SELECT
   gebietsleiter_uid
   , vertriebsbuero_uid
   , gebietsleiter_bez
   , berichts_empfaenger_ldap AS gebietsleiter_ldap
   FROM dbp_view.v_geku_gebietsleiter;