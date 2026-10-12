create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_MANDANT(
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ,
	MANDANT_SAP_ID,
	DEFAULT_WRG,
	MANDANT_SORT_ID
) as
   SELECT
   mandant_id, mandant_bez, mandant_kbez, mandant_sap_id, default_wrg, mandant_sort_id
   FROM dbp_view.v_mandant;
