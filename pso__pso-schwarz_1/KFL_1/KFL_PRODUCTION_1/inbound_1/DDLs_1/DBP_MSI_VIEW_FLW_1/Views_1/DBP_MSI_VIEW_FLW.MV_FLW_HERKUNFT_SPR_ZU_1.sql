CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_HERKUNFT_SPR_ZU_1
AS
   SELECT
   v01.mandant_id, v01.herkunft_id, v01.spr_id, v01.herkunft_bez

   FROM dbp_view.v_flw_herkunft_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;