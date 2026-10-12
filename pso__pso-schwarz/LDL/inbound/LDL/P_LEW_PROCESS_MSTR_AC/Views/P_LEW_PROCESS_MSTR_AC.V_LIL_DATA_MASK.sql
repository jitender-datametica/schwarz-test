create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR_AC.V_LIL_DATA_MASK(
	CLIENT_ID,
	REGION_SID,
	PERIOD_SID,
	SRC_ASSORT_PARENT_CAT_CD,
	INTERFACE_NAME,
	MASK_DATA_FG,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
     SELECT
         client_id,
     region_sid,
     period_sid,
     src_assort_parent_cat_cd,
     interface_name,
     mask_data_fg,
     dwh_load_id,
     dwh_created,
     dwh_updated
 FROM p_lew_process_mstr.t_lil_data_mask ;
