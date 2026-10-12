CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GRUPPE_HIER_2_2
(
gruppe_hier_2_id
, gruppe_hier_2_bez
)
AS

   SELECT v01.gruppe_id gruppe_hier_2_id, CASE
   WHEN v01.gruppe_id = 0 THEN ''
   ELSE v01.gruppe_bez END AS gruppe_hier_2_bez

   FROM dbp_security.gruppe_2 v01;