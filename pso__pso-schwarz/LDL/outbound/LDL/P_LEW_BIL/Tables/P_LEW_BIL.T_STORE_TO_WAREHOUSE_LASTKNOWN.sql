CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_store_to_warehouse_lastknown (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
loc_sid_wh BIGNUMERIC(38,0) NOT NULL,
src_wh_id BIGNUMERIC(38,0),
src_orig_store_nr BIGNUMERIC(38,0),
dwh_valid_from DATE,
dwh_valid_to DATE,
dwh_actual_fg BIGNUMERIC(38,0),
active_fg BIGNUMERIC(38,0),
future_active_fg BIGNUMERIC(38,0)
);