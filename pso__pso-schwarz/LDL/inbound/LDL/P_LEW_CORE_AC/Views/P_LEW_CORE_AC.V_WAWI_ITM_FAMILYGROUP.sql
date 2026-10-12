create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_WAWI_ITM_FAMILYGROUP(
	CLIENT_ID,
	ITEM_FAMILYGROUP_ID,
	DAT_REC_START,
	DAT_REC_END,
	SUBITEMGROUP_ID,
	FAMILY_CD,
	ITEM_FAMILY_DESC,
	ITEM_FAMILY_SHORT_DESC,
	LANGUAGE_ID,
	LOAD_ID
) as
   SELECT
   client_id,
   item_familygroup_id,
   dat_rec_start,
   dat_rec_end,
   subitemgroup_id,
   family_cd,
   item_family_desc,
   item_family_short_desc,
   language_id,
   load_id
   FROM p_lew_core.t_wawi_itm_familygroup;
