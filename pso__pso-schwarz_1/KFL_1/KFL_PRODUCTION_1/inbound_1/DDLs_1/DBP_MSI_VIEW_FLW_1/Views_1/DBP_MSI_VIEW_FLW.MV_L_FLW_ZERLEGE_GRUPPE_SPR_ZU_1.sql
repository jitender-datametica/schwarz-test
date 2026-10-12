CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_ZERLEGE_GRUPPE_SPR_ZU_1
AS

   SELECT
   mandant_id, zerlege_gruppe_id, zerlege_gruppe_bez

   FROM dbp_view.v_flw_zerlege_gruppe_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;