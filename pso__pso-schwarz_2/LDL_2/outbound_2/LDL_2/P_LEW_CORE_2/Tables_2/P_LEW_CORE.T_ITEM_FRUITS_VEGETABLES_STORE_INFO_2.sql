CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_fruits_vegetables_store_info_2 (
client_id BIGNUMERIC(38,0),
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
last_delivery_dt DATE NOT NULL,
min_case_size_dec NUMERIC(18,5),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id;