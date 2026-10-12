CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_sys_trans_cnt_2 (
system_key BIGNUMERIC(38,0) NOT NULL,
interface_key BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0),
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
dat_dayend DATE NOT NULL,
trans_row_cnt BIGNUMERIC(38,0)
);