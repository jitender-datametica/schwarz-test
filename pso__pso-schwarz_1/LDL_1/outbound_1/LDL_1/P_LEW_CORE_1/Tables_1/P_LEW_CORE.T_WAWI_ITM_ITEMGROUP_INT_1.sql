CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_itemgroup_int_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
itemgroup_int_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
dat_valid_from DATE,
dat_valid_until DATE,
itemgroup_int_nat_id BIGNUMERIC(38,0),
itemgroup_int_desc STRING(50) COLLATE 'und:ci' NOT NULL,
itemgroup_int_remark STRING(60) COLLATE 'und:ci',
version BIGNUMERIC(38,0) NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);