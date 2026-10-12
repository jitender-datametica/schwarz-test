CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_PRODH_LVL_5_SPR_ZU_2
as
SELECT
   v01.mandant_id, v01.spr_id, prodh_lvl_5, prodh_lvl_5_bez

   FROM DBP_MSI_VIEW_FLW.tbl_MV_PRODH_LVL_5_SPR_ZU_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;