CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_USER_1(
	USER_ID
) AS

SELECT
v01.user_id

FROM dbp_security.lbs_gruppe_user_zu_1 v01
GROUP BY v01.user_id;