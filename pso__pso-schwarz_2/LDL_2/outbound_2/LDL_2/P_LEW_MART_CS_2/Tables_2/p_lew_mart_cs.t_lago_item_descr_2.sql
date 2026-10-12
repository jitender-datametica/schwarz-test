CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_lago_item_descr_2 (
client_id BIGNUMERIC(38) NOT NULL,
item_id BIGNUMERIC(38) NOT NULL,
orig_item_nr BIGNUMERIC(38) NOT NULL,
item_descr STRING(200) COLLATE 'und:ci',
language_id BIGNUMERIC(38) NOT NULL,
valid_from DATE NOT NULL,
valid_until DATE NOT NULL,
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);