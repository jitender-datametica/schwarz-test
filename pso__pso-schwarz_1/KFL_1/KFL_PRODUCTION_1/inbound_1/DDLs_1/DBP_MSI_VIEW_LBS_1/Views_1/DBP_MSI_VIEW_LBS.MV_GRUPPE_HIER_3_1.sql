CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GRUPPE_HIER_3_1(
	GRUPPE_HIER_3_ID,
	GRUPPE_HIER_3_BEZ
) AS
SELECT 
 v01.lbs_gruppe_id AS gruppe_hier_3_id
,CASE WHEN v01.lbs_gruppe_id = 0 THEN '' ELSE v01.lbs_gruppe_bez END AS gruppe_hier_3_bez

FROM dbp_security.lbs_gruppe_1 v01;