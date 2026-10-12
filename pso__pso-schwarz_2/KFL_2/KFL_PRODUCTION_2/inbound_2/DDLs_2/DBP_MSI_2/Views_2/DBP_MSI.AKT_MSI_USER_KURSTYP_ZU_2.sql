CREATE OR REPLACE VIEW DBP_MSI.AKT_MSI_USER_KURSTYP_ZU_2

(

user_id

, kurstyp_id

)

AS

   SELECT

   v02.user_id, v02.kurstyp_id

   FROM dbp_msi_data.akt_msi_user_2 v01

   JOIN dbp_msi_v_view.v_user_kurstyp_zu_2 v02

   ON v01.user_id = v02.user_id

   AND v01.session_id = current_session()
   GROUP BY 1,2;