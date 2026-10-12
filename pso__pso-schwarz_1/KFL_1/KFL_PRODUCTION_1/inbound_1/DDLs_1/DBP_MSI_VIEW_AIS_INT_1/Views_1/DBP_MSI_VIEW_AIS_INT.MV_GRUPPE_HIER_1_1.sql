CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GRUPPE_HIER_1_1
(
gruppe_hier_1_id
, gruppe_hier_1_bez
)
AS

   SELECT v01.gruppe_id gruppe_hier_1_id, v01.gruppe_bez gruppe_hier_1_bez

   FROM dbp_security.gruppe_1 v01

   --Ausschluss der DUMMY_1-ID 0
   WHERE v01.gruppe_id <> 0;