CREATE OR REPLACE TABLE ldl_p_lew_precore.t_item_map_key_oin_cs_hist_1 (
client_id INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
src_orig_item_nr INTEGER NOT NULL,
src_case_size INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
PRIMARY KEY (client_id, src_orig_item_nr, src_case_size, dwh_valid_from) NOT ENFORCED
);