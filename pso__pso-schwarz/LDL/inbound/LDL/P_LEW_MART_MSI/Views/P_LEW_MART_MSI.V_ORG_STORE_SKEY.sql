create or replace view LDL_PRODUCTION.P_LEW_MART_MSI.V_ORG_STORE_SKEY(
	CLIENT_ID,
	STORE_ID,
	WH_ID,
	ORIG_STORE_NR
) as
   SELECT	
     client_id,	
   store_id,	
   wh_id,	
   orig_store_nr	
  FROM p_lew_mart_msi.t_org_store_skey;
