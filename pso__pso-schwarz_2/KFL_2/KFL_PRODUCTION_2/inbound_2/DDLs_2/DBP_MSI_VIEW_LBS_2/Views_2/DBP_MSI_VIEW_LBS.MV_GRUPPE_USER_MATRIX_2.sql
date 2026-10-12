CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GRUPPE_USER_MATRIX_2(
	GRUPPE_ID,
	USER_ID
) AS

SELECT 
 v01.lbs_gruppe_id
,'User anlegen' AS user_id

FROM dbp_security.lbs_gruppe_2 v01
WHERE v01.lbs_gruppe_id <> 0

UNION

SELECT 
 v02.lbs_gruppe_id
,v02.user_id

FROM dbp_security.lbs_gruppe_user_zu_2 v02
WHERE v02.lbs_gruppe_id <> 0;