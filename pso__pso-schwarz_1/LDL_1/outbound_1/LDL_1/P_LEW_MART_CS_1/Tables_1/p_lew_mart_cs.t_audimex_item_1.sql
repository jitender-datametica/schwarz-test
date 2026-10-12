CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_audimex_item_1 (
client_id BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(20) COLLATE 'und:ci' NOT NULL,
orig_item_nr INTEGER NOT NULL,
item_descr STRING(200) COLLATE 'und:ci',
plu_nr BIGNUMERIC(38),
subitemgroup_id BIGNUMERIC(38),
descr_short STRING(200) COLLATE 'und:ci',
ag_reserve STRING(4) COLLATE 'und:ci',
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);