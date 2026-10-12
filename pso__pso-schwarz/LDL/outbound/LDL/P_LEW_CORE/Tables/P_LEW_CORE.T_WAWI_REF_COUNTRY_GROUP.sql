CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_country_group (
country_group_id BIGNUMERIC(38,0) NOT NULL,
country_group_desc STRING(60) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL
);