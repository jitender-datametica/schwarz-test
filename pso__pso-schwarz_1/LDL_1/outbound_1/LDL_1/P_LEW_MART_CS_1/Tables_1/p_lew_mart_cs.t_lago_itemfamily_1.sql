CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_lago_itemfamily_1 (
client_id BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(20) COLLATE 'und:ci' NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
item_familygroup_id BIGNUMERIC(38) NOT NULL,
itemfamily_cd BIGNUMERIC(38),
desc_short STRING(300) COLLATE 'und:ci',
desc_long STRING(300) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38) NOT NULL,
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);