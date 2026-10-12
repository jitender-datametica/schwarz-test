CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_GFK_HHP_WG_2

(
mandant_id
, gfk_wg_id
, gfk_wg_bez
)
AS

   SELECT
   mandant_id, gfk_wg_id, gfk_wg_bez

   FROM dbp_view.v_gfk_hhp_wg_2;