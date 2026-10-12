CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_USER_ZEK_ZU_1(
	USER_ID,
	ZEK_ID,
	MANDANT_ID
) AS
SELECT
 TRIM (v01.user_id)
,v01.zek_id
,v01.mandant_id

FROM dbp_security.lbs_user_zek_zu_1 v01
GROUP BY 1, 2, 3;