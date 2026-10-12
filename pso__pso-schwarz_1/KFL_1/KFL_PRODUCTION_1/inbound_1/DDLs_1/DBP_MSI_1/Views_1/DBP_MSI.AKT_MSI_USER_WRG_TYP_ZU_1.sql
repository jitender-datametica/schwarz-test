create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI.AKT_MSI_USER_WRG_TYP_ZU_1(
	USER_ID,
	WRG_TYP_ID,
	BERICHTSKURS_TYP_ID
) as

   SELECT
   v02.user_id, v02.wrg_typ_id, berichtskurs_typ_id
   FROM dbp_msi_data.akt_msi_user_1 v01

   JOIN dbp_msi_v_view.v_user_wrg_typ_zu_1 v02

   ON v01.user_id = v02.user_id

   AND v01.session_id = current_session()
   GROUP BY 1,2,3;
