CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS_DT.USER_KURSTYP_ZU_2
(
user_id
, kurstyp_id
)
AS
   SELECT
   v01.user_id,
   v01.kurstyp_id
  FROM dbp_msi_v_view.v_user_kurstyp_zu_2 v01
  ;