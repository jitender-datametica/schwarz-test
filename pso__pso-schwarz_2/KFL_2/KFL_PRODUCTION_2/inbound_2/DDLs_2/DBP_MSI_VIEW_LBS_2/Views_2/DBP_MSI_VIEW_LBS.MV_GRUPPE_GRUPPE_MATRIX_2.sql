CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GRUPPE_GRUPPE_MATRIX_2(
	GRUPPE_PARENT_ID,
	GRUPPE_ID,
	PFLEGEFLAG
) AS
SELECT 
 lbs_gruppe_parent_id
,lbs_gruppe_id
,(CASE WHEN 
    (SELECT COUNT(*) FROM dbp_security.lbs_gruppe_gruppe_zu_2 x
     WHERE x.lbs_gruppe_id = cx.lbs_gruppe_id
     AND x.lbs_gruppe_parent_id = cx.lbs_gruppe_parent_id) > 0
       THEN 1 ELSE 0 END) AS PflegeFlag
   FROM (
   SELECT v01.lbs_gruppe_id, v02.lbs_gruppe_id AS lbs_gruppe_parent_id

   FROM dbp_security.lbs_gruppe_2 v01
   CROSS JOIN dbp_security.lbs_gruppe_2 v02

   --Ausschluss der DUMMY_2-ID 0
   WHERE v01.lbs_gruppe_id <> 0
   AND v02.lbs_gruppe_id <> 0
   --Ausschluss von Zuordnungen einer Gruppe_2 zu sich selbst
   AND v01.lbs_gruppe_id <> v02.lbs_gruppe_id
   --Ausschluss von Gruppen als Elterngruppen denen bereits Mandanten / EKGs zugeordnet sind
   AND v02.lbs_gruppe_id NOT IN (SELECT v03.lbs_gruppe_id FROM dbp_security.lbs_gruppe_zek_zu_2 v03)) cx;