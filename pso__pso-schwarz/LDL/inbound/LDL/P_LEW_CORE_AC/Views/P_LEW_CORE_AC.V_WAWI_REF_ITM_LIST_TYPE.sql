create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_WAWI_REF_ITM_LIST_TYPE(
	LANGUAGE_ID,
	BUYING_LIST_TYPE_ID,
	BUYING_LIST_TYPE_DESC,
	LISTING_TYPE_ID,
	LISTING_TYPE_DESC,
	BRAND_TYPE_ID,
	BRAND_TYPE_DESC,
	BUYING_LIST_TYPE_GROUP_ID,
	BUYING_LIST_TYPE_GROUP_DESC,
	LISTING_TYPE_GROUP_ID,
	LISTING_TYPE_GROUP_DESC,
	BRAND_TYPE_GROUP_ID,
	BRAND_TYPE_GROUP_DESC,
	LOAD_ID
) as
   SELECT
   language_id,
   buying_list_type_id,
   buying_list_type_desc,
   listing_type_id,
   listing_type_desc,
   brand_type_id,
   brand_type_desc,
   buying_list_type_group_id,
   buying_list_type_group_desc,
   listing_type_group_id,
   listing_type_group_desc,
   brand_type_group_id,
   brand_type_group_desc,
   load_id
   FROM p_lew_core.t_wawi_ref_itm_list_type;
