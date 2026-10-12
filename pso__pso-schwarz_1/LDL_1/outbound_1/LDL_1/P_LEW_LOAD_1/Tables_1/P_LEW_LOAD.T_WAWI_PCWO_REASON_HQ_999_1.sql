CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_pcwo_reason_hq_999_1 (
client_id BIGNUMERIC(38) NOT NULL,
pcwo_reason_id BIGNUMERIC(38) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
pcwo_reason_id_int BIGNUMERIC(38) NOT NULL,
pcwo_group_id BIGNUMERIC(38),
pcwo_group_desc STRING(50) COLLATE 'und:ci',
pcwo_active_fg BIGNUMERIC(38) NOT NULL,
pcwo_new_group_cd BIGNUMERIC(38),
load_id BIGNUMERIC(38) NOT NULL
);