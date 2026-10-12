create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI.AKT_MSI_USER_EK_ANZEIGE_ZU(
	USER_ID,
	EK_ANZEIGE_FG
) as 
--2023-07-17 staeblern Umstellung auf Session Variable 
SELECT DISTINCT 
v01.user_id
, v01.ek_anzeige_fg
FROM dbp_security.user_ek_anzeige_zu v01
 WHERE  v01.user_id = getvariable('USERID');
