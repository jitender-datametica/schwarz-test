create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR_AC.V_LIL_GFK_CATEGORY_2(
	CLIENT_ID,
	GFK_CAT_SID,
	GFK_CAT_ID,
	GFK_CAT_NAME_EN,
	GFK_CAT_NAME_DE,
	GFK_CAT_SHORT_NAME,
	ACTIVE_FG,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
     SELECT
         client_id,
     gfk_cat_sid,
     gfk_cat_id,
     gfk_cat_name_en,
     gfk_cat_name_de,
     gfk_cat_short_name,
     active_fg,
     dwh_load_id,
     dwh_created,
     dwh_updated
 FROM p_lew_process_mstr.t_lil_gfk_category_2 ;
