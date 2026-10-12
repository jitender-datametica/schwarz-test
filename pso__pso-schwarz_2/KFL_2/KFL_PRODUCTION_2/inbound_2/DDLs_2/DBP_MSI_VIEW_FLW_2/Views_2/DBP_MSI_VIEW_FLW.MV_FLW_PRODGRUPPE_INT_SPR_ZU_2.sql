CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_PRODGRUPPE_INT_SPR_ZU_2
AS

   SELECT      v01.produktgruppe_id AS produktgruppe_int_id, v01.produktgruppe_bez
   FROM dbp_view.v_flw_produktgruppe_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id
   WHERE
   v01.mandant_id = 2;