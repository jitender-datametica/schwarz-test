CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_statisticgroup_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
statisticgroup_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
dat_valid_from DATE,
dat_valid_until DATE,
statisticgroup_desc STRING(50) COLLATE 'und:ci',
edit_fg BIGNUMERIC(38,0),
statisticgroup_position BIGNUMERIC(38,0),
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);