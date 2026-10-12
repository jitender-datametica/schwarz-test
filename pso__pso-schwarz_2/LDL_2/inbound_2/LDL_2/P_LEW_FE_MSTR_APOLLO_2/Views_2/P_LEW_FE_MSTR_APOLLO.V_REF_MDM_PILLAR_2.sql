create or replace view LDL_PRODUCTION.P_LEW_FE_MSTR_APOLLO.V_REF_MDM_PILLAR_2(
	MDM_PILLAR_SID,
	MDM_PILLAR_NAME,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT   
    mdm_pillar_sid 
   ,mdm_pillar_name
   ,dwh_load_id        
   ,dwh_created    
   ,dwh_updated 
FROM P_LEW_CORE.T_REF_MDM_PILLAR_2;
