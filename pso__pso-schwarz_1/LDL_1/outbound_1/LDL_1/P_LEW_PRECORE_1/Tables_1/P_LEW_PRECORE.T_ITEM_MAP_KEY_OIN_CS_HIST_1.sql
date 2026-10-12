CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_item_map_key_oin_cs_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
src_orig_item_nr NUMERIC(20,0) NOT NULL,
src_case_size BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
PRIMARY KEY (client_id, src_orig_item_nr, src_case_size, dwh_valid_from) NOT ENFORCED
);