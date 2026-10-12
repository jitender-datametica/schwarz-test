create or replace view DBP_MSI_VIEW_IMS_MATERIALIZED.USER_WRG_TYP_ZU(
	USER_ID,
	WRG_TYP_ID
) as
   SELECT
   v01.user_id,
   v01.wrg_typ_id
  FROM dbp_msi_v_view.v_user_wrg_typ_zu v01;