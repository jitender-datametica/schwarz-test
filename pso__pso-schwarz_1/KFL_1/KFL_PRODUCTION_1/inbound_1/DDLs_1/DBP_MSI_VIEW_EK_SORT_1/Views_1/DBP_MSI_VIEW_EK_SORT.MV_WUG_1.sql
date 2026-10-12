CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_WUG_1
AS

   SELECT

   v01.mandant_id, v01.wug_id, v01.wg_id

   FROM dbp_view.v_wug_1 v01
   JOIN dbp_view.v_wg_filter_zu_1 v02
   ON v01.mandant_id = v02.mandant_id AND v01.wg_id = v02.wg_id
   WHERE  v02.wg_filter_id = 11

   UNION

   SELECT
   mandant_id, -1 AS wug_id, -1 AS wg_id

   FROM dbp_view.v_wug_1;