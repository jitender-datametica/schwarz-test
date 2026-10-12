CREATE OR REPLACE VIEW DBP_MSI.AKT_MSI_USER_SPR_ZU

(

user_id

, spr_id

)

AS

   SELECT

   v02.user_id, v02.spr_id

   FROM dbp_msi_data.akt_msi_user v01

   JOIN dbp_msi_v_view.v_user_spr_zu v02

   ON v01.user_id = v02.user_id

   AND v01.session_id = current_session()
   GROUP BY 1,2;