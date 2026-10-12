CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_stock_correction_request_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_wh BIGNUMERIC(38,0) NOT NULL,
request_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0),
requested_cnt_dt DATE NOT NULL,
inv_type_id BIGNUMERIC(38,0) NOT NULL,
request_list_id BIGNUMERIC(38,0),
stock_corr_req_status_id BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);