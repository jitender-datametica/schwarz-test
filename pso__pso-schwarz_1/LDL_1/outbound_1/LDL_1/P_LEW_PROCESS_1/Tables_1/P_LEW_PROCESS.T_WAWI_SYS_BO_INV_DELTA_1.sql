CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_sys_bo_inv_delta_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
inv_id BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE,
dat_valid_from DATE,
dat_valid_until DATE,
cy_month BIGNUMERIC(38,0) NOT NULL,
busyear BIGNUMERIC(38,0) NOT NULL
);