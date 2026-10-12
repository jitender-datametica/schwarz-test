CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_GEBIETSLEITER_2
(
gebietsleiter_uid
,vertriebsbuero_uid
,gebietsleiter_bez
,gebietsleiter_ldap
)
AS
-- 16.01.2014 twie: neue Spalte gebietsleiter_ldap für Emailversand der Berichte

   SELECT
   gebietsleiter_uid
   , vertriebsbuero_uid
   , gebietsleiter_bez
   , berichts_empfaenger_ldap AS gebietsleiter_ldap
   FROM dbp_view.v_geku_gebietsleiter_2;