CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_2 (language_id, buying_list_type_id,
buying_list_type_desc, listing_type_id, listing_type_desc, brand_type_id, brand_type_desc, buying_list_type_group_id,
buying_list_type_group_desc, listing_type_group_id, listing_type_group_desc, brand_type_group_id, brand_type_group_desc
, load_id) AS SELECT language_id,
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
FROM ldl_p_lew_core.t_wawi_ref_itm_list_type_2;