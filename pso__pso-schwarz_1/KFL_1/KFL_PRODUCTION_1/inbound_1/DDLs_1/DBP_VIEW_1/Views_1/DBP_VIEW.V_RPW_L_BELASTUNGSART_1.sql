create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_RPW_L_BELASTUNGSART_1(
	BELASTUNGSART_VD_ID,
	BELASTUNGSART_ID
) as
SELECT
belastungsart_vd_id
,belastungsart_id
FROM dbp_data.rpw_l_belastungsart_1;
