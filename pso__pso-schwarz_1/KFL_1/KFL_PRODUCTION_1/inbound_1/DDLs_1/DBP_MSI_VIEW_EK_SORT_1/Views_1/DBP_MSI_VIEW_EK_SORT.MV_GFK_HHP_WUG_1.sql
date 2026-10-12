CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_GFK_HHP_WUG_1
AS

   SELECT
   v01.mandant_id, v01.gfk_wg_id, v01.gfk_wug_id, v02.gfk_wg_bez, v01.gfk_wug_bez
   FROM dbp_view.v_gfk_hhp_wug_1 v01
   JOIN dbp_view.v_gfk_hhp_wg_1 v02
   ON v01.gfk_wg_id = v02.gfk_wg_id AND v01.mandant_id = v02.mandant_id;