CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_location_item_price_tmp (
client_id BIGNUMERIC(38) NOT NULL,
loc_sid BIGNUMERIC(38) NOT NULL,
item_sid BIGNUMERIC(38) NOT NULL,
dwh_cal_dt DATE NOT NULL
);