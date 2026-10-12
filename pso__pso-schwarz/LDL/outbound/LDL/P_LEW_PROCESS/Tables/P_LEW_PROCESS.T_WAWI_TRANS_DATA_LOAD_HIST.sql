CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_trans_data_load_hist (
interface STRING(100) COLLATE 'und:ci' NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
numrows BIGNUMERIC(38,0) NOT NULL,
dat_dayend DATE NOT NULL
);