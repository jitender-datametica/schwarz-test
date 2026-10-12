CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_lago_supplier_2 (
client_id BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(20) COLLATE 'und:ci' NOT NULL,
orig_supplier_nr BIGNUMERIC(38) NOT NULL,
supplier_id BIGNUMERIC(38) NOT NULL,
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);