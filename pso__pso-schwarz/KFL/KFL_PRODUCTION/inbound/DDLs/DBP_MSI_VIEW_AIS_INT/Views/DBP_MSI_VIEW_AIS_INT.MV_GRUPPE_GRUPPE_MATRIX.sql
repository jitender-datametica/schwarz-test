CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GRUPPE_GRUPPE_MATRIX
(
gruppe_parent_id
, gruppe_id
, PflegeFlag
)
AS
   SELECT gruppe_parent_id, gruppe_id, (case when (select count(*) from dbp_security.gruppe_gruppe_zu x
   where x.gruppe_id = cx.gruppe_id and x.gruppe_parent_id = cx.gruppe_parent_id) > 0
   then 1 else 0 END) as PflegeFlag
   FROM (
   SELECT v01.gruppe_id, v02.gruppe_id gruppe_parent_id

   FROM dbp_security.gruppe v01
   CROSS JOIN dbp_security.gruppe v02

   --Ausschluss der DUMMY-ID 0
   WHERE v01.gruppe_id <> 0
   AND v02.gruppe_id <> 0
   --Ausschluss von Zuordnungen einer Gruppe zu sich selbst
   AND v01.gruppe_id <> v02.gruppe_id
   --Ausschluss von Gruppen als Elterngruppen denen bereits Mandanten / EKGs zugeordnet sind
   AND v02.gruppe_id NOT IN (SELECT v03.gruppe_id FROM dbp_security.gruppe_zek_zu v03)) cx;