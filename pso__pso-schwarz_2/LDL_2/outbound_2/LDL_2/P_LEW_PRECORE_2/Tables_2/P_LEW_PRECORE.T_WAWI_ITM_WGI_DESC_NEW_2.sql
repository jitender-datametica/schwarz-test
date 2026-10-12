CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_wawi_itm_wgi_desc_new_2 (
country_iso_cd STRING(3) COLLATE 'und:ci',
client_id BIGNUMERIC(38,0) NOT NULL,
itemgroup_int_id BIGNUMERIC(38),
itemgroup_int_id_new BIGNUMERIC(38) NOT NULL,
itemgroup_int_desc_country STRING(50) COLLATE 'und:ci',
itemgroup_int_desc_conutry_new STRING(50) COLLATE 'und:ci',
itemgroup_int_desc_german STRING(50) COLLATE 'und:ci',
itemgroup_int_desc_german_new STRING(50) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0) NOT NULL
);