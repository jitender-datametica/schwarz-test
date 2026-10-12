CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.USER_WRG_TYP_ZU_1

(
user_id
, wrg_typ_id
)
AS
   SELECT
   v01.user_id,
   v01.wrg_typ_id
  FROM dbp_msi_v_view.v_user_wrg_typ_zu_1 v01;