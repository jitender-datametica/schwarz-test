create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_MDM_AD_THEME_ITEM_HIST(
	CLIENT_ID,
	MDM_AD_THEME_SID,
	MDM_ITEM_SID,
	DELETED_FG,
	DWH_VALID_FROM,
	DWH_VALID_TO,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   mdm_ad_theme_sid,
   mdm_item_sid,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_mdm_ad_theme_item_hist
;
