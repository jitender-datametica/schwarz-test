CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_PREISTYP
AS
   SELECT

   v01.preistyp_id, v01.mandant_id, v01.preistyp_bez

   FROM dbp_view.v_l_preistyp v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;