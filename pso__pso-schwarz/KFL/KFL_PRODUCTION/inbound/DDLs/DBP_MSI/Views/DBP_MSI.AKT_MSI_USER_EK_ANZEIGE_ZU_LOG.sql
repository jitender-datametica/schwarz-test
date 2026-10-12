CREATE OR REPLACE VIEW DBP_MSI.AKT_MSI_USER_EK_ANZEIGE_ZU_LOG(
	USER_ID,
	EK_ANZEIGE_FG
) AS 
-- 20230717 staeblern Umstellung auf Session Variabel 
SELECT DISTINCT 
v01.user_id
, v01.ek_anzeige_fg
FROM  dbp_security.user_ek_anzeige_zu_log v01
WHERE v01.user_id = getvariable('USERID')
;