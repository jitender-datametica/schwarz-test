CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GRUPPE_USER_MATRIX_LOESCH_2(
	GRUPPE_ID,
	USER_ID,
	LOESCH_FG
) AS

SELECT
 v01.lbs_gruppe_id
,v01.user_id, 0 AS  loesch_fg

FROM dbp_security.lbs_gruppe_user_zu_2 v01  
WHERE v01.lbs_gruppe_id <> 0;