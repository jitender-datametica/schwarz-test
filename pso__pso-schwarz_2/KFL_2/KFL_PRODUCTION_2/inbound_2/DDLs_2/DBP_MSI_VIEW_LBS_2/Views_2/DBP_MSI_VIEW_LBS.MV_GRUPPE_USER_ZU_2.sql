CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GRUPPE_USER_ZU_2(
	GRUPPE_ID,
	USER_ID,
    DAT_GUELTIG_BIS,
    TD_UPDATE
) AS

SELECT 
 v01.lbs_gruppe_id
,v01.user_id
,v01.dat_gueltig_bis
,DATE(v01.td_update) AS TD_UPDATE

FROM dbp_security.lbs_gruppe_user_zu_2 v01;