CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_itm_list_type_2 (
language_id BIGNUMERIC(38,0) NOT NULL,
buying_list_type_id BIGNUMERIC(38,0),
buying_list_type_desc STRING(50) COLLATE 'und:ci',
listing_type_id BIGNUMERIC(38,0),
listing_type_desc STRING(50) COLLATE 'und:ci',
brand_type_id BIGNUMERIC(38,0),
brand_type_desc STRING(50) COLLATE 'und:ci',
buying_list_type_group_id BIGNUMERIC(38,0),
buying_list_type_group_desc STRING(50) COLLATE 'und:ci',
listing_type_group_id BIGNUMERIC(38,0),
listing_type_group_desc STRING(50) COLLATE 'und:ci',
brand_type_group_id BIGNUMERIC(38,0),
brand_type_group_desc STRING(50) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL
);