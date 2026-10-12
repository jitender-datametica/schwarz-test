CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GRUPPE_HIER_1_1(
	GRUPPE_HIER_1_ID,
	GRUPPE_HIER_1_BEZ
) AS
SELECT 
 v01.lbs_gruppe_id AS gruppe_hier_1_id
,v01.lbs_gruppe_bez AS gruppe_hier_1_bez

FROM dbp_security.lbs_gruppe_1 v01
WHERE v01.lbs_gruppe_id <> 0;