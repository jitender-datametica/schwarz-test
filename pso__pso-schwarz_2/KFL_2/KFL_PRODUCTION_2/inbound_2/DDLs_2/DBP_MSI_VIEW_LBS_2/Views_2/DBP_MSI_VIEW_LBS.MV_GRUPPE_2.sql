CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GRUPPE_2(
	GRUPPE_ID,
	GRUPPE_BEZ
) AS
SELECT
 v01.lbs_gruppe_id
,v01.lbs_gruppe_bez
FROM dbp_security.lbs_gruppe_2 v01
WHERE v01.lbs_gruppe_id <> 0;