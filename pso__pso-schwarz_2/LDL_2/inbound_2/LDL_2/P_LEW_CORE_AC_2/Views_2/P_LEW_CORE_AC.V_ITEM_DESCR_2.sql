create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_ITEM_DESCR_2(
	CLIENT_ID,
	ITEM_SID,
	LANG_SID,
	LANG_CD,
	ITEM_DESCR,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
   client_id,
   item_sid,
   lang_sid,
   lang_cd,
   item_descr,
   dwh_load_id,
   dwh_created,
   dwh_updated
   FROM p_lew_core.t_item_descr_2;
