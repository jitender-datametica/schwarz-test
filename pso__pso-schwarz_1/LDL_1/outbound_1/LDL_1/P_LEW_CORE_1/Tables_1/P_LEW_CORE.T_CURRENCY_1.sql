CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_currency_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
curr_sid BIGNUMERIC(38,0) NOT NULL,
src_waers STRING(20),
curr_name STRING(100) COLLATE 'und:ci',
curr_iso_cd STRING(20),
curr_dec BIGNUMERIC(38,0),
factor NUMERIC(18,5) DEFAULT 1,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (curr_sid) NOT ENFORCED
) CLUSTER BY client_id;