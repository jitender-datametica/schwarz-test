CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_DISPOMERKMAL_SPR_ZU

(
mandant_id
,dispomerkmal
,spr_id
,dispomerkmal_bez

)
AS
   SELECT

  v01.mandant_id, v01.dispomerkmal, v01.spr_id, v01.dispomerkmal_bez

   FROM dbp_view.v_dispomerkmal_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;