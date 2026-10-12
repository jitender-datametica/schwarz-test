CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_subitemgroup_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
subitemgroup_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
mainitemgroup_id BIGNUMERIC(38,0) NOT NULL,
itemgroup_int_id BIGNUMERIC(38,0) NOT NULL,
statisticgroup_id BIGNUMERIC(38,0),
person_id BIGNUMERIC(38,0) NOT NULL,
person_name STRING(50) COLLATE 'und:ci',
cnt_rcv NUMERIC(18,4),
diff_rcv NUMERIC(18,4),
rcv_days NUMERIC(18,4),
load_id BIGNUMERIC(38,0) NOT NULL
);