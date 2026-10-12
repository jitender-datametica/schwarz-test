CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_KL_WG_NIELSEN_GFK_HHP_WG_ZU_1

(
mandant_id,
kl_wg_id,
gfk_wg_id
)
AS

   SELECT
   mandant_id,
   kl_wg_id,
   gfk_wg_id

   FROM dbp_view.v_kl_wg_nielsen_gfk_hhp_wg_zu_1;