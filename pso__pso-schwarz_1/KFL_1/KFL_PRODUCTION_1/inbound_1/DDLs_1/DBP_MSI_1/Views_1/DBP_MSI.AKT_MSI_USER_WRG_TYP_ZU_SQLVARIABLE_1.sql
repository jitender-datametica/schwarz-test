CREATE OR REPLACE VIEW DBP_MSI.AKT_MSI_USER_WRG_TYP_ZU_SQLVARIABLE_1

(
user_id
, wrg_typ_id
)

AS
   SELECT
   v02.user_id
   , v02.wrg_typ_id
   FROM dbp_msi_v_view.v_user_wrg_typ_zu_1 v02
   WHERE v02.user_id =  $userid
   GROUP BY 1,2;

