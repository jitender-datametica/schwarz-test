CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_TIERGATTUNG_SPR_ZU_2
AS

   SELECT
   mandant_id, tiergattung_id, tiergattung_bez


   FROM dbp_view.v_flw_tiergattung_spr_zu_2   v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;