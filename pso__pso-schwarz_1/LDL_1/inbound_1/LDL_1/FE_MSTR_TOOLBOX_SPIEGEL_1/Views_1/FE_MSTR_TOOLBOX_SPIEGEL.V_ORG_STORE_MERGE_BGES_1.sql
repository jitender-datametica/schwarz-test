create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.FE_MSTR_TOOLBOX_SPIEGEL.V_ORG_STORE_MERGE_BGES_1(
	CLIENT_ID,
	STORE_ID,
	STORE_DESC,
	ORIG_STORE_NR,
	MOVE_TO_STORE_ID,
	MOVE_STORE_DESC,
	DASHBOARD_RELEVANT_FG
) as
SELECT store.client_id
     , store.store_id
     , store.store_desc
     , store.orig_store_nr    
     , store.move_to_store_id 
     , store.move_store_desc
     , store.dashboard_relevant_fg
FROM   P_LEW_MART_MSI_AC.v_org_store_merge_1 store
WHERE  store.aspect_id = 1;
