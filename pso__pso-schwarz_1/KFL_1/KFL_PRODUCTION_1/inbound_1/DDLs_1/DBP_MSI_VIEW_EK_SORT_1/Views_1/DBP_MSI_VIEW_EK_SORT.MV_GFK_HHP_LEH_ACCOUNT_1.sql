CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_GFK_HHP_LEH_ACCOUNT_1

(
mandant_id
, gfk_account_id
, gfk_account_bez
)
AS

   SELECT
   mandant_id, gfk_account_id, gfk_account_bez

   FROM dbp_view.v_gfk_hhp_leh_account_1;