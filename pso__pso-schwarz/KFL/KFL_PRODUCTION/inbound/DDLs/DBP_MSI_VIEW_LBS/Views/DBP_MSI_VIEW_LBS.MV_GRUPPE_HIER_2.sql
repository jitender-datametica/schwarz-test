CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GRUPPE_HIER_2(
	GRUPPE_HIER_2_ID,
	GRUPPE_HIER_2_BEZ
) AS
SELECT 
 v01.lbs_gruppe_id AS gruppe_hier_2_id
,CASE WHEN v01.lbs_gruppe_id = 0 THEN '' ELSE v01.lbs_gruppe_bez END AS gruppe_hier_2_bez

FROM dbp_security.lbs_gruppe v01;