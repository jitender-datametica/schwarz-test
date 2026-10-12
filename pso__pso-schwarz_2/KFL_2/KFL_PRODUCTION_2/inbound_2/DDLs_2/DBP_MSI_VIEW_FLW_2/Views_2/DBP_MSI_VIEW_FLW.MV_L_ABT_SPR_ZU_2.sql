CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_ABT_SPR_ZU_2
AS

   SELECT
   v01.mandant_id, v01.abt_id, v01.arthiertyp_id, v01.abt_bez

   FROM dbp_view.v_abt_spr_zu_2  v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   AND v01.arthiertyp_id = 2
   AND v01.mandant_id IN (1,2)
   AND v01.abt_id BETWEEN -3 AND 8;