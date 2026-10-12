CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_currency_descr_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
curr_sid BIGNUMERIC(38,0) NOT NULL,
lang_sid BIGNUMERIC(38,0) NOT NULL,
curr_cd STRING(20),
lang_cd STRING(20),
curr_descr_short STRING(100) COLLATE 'und:ci',
curr_descr_long STRING(300) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (curr_sid, lang_sid) NOT ENFORCED
) CLUSTER BY client_id;