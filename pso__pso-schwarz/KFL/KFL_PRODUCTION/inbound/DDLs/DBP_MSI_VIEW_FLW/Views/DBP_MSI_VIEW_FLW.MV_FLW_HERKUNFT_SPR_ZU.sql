CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_HERKUNFT_SPR_ZU
AS
   SELECT
   v01.mandant_id, v01.herkunft_id, v01.spr_id, v01.herkunft_bez

   FROM dbp_view.v_flw_herkunft_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;