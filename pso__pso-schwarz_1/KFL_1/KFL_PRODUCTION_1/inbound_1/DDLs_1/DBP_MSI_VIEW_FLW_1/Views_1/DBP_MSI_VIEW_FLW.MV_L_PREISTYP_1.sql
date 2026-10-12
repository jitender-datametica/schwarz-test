CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_PREISTYP_1
AS
   SELECT

   v01.preistyp_id, v01.mandant_id, v01.preistyp_bez

   FROM dbp_view.v_l_preistyp_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;