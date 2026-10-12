CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_audimex_ean_1 (
client_id BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(20) COLLATE 'und:ci' NOT NULL,
orig_item_nr INTEGER NOT NULL,
case_size BIGNUMERIC(38),
ean_code STRING(20) COLLATE 'und:ci',
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);