CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_discount_type_desc_2 (
discount_type_id BIGNUMERIC(38,0) NOT NULL,
discount_type_desc STRING(50) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);