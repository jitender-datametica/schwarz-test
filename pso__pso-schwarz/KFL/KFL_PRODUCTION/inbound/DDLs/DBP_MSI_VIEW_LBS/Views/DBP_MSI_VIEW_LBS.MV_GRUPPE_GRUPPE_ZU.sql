CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GRUPPE_GRUPPE_ZU(
	GRUPPE_HIER_1_ID,
	GRUPPE_HIER_2_ID,
	GRUPPE_HIER_3_ID
) AS
SELECT 
 v03.lbs_gruppe_id AS gruppe_hier_1_id
,COALESCE(v04.lbs_gruppe_id, 0) AS gruppe_hier_2_id
,COALESCE(v05.lbs_gruppe_id, 0) AS gruppe_hier_3_id

FROM
   (SELECT v01.lbs_gruppe_id
    FROM dbp_security.lbs_gruppe v01
    WHERE v01.lbs_gruppe_id <> 0
    AND v01.lbs_gruppe_id NOT IN 
    
    (SELECT v02.lbs_gruppe_id
     FROM dbp_security.lbs_gruppe_gruppe_zu v02)) v03

LEFT OUTER JOIN dbp_security.lbs_gruppe_gruppe_zu v04
ON v03.lbs_gruppe_id  = v04.lbs_gruppe_parent_id
LEFT OUTER JOIN dbp_security.lbs_gruppe_gruppe_zu v05
ON v04.lbs_gruppe_id  = v05.lbs_gruppe_parent_id;