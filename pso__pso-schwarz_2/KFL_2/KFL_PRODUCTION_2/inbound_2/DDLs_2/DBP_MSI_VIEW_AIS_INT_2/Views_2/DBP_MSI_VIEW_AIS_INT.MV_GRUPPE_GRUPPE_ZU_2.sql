CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GRUPPE_GRUPPE_ZU_2
(
gruppe_hier_1_id
, gruppe_hier_2_id
, gruppe_hier_3_id
)
AS

   SELECT v03.gruppe_id gruppe_hier_1_id, COALESCE(v04.gruppe_id, 0) gruppe_hier_2_id, COALESCE(v05.gruppe_id, 0) gruppe_hier_3_id

   FROM

   (SELECT v01.gruppe_id

   FROM dbp_security.gruppe_2 v01

   --Ausschluss der DUMMY_2-ID 0
   WHERE v01.gruppe_id <> 0
   --Nur Gruppen ohne Elterngruppen
   AND v01.gruppe_id NOT IN (

   SELECT v02.gruppe_id

   FROM dbp_security.gruppe_gruppe_zu_2 v02)) v03
   LEFT OUTER JOIN dbp_security.gruppe_gruppe_zu_2 v04
   ON v03.gruppe_id  = v04.gruppe_parent_id
   LEFT OUTER JOIN dbp_security.gruppe_gruppe_zu_2 v05
   ON v04.gruppe_id  = v05.gruppe_parent_id;