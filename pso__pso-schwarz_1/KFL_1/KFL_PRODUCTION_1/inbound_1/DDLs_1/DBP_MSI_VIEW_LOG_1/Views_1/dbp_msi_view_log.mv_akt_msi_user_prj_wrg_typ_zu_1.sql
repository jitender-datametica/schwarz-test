create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1(
	USER_ID,
	WRG_TYP_ID
) as
--20230717 staeblern Umstellung auf Sessionvairable 
   SELECT
   v01.user_id, v01.wrg_typ_id
   FROM  dbp_msi_view_log.USER_PRJ_WRG_TYP_ZU_1 v01 -- dbp_msi_v_view.v_user_wrg_typ_zu_1 
   WHERE  v01.user_id = getvariable('USERID');
