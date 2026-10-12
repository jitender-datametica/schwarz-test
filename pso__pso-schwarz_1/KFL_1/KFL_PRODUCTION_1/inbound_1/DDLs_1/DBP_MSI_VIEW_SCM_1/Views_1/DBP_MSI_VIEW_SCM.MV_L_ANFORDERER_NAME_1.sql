create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_L_ANFORDERER_NAME_1(
	MANDANT_ID,
	ANFORDERER_NAME
) as
 SELECT
 mandant_id, 
 anforderer_name FROM dbp_msi_view_scm.mv_dt_l_anforderer_name_1
 ;
