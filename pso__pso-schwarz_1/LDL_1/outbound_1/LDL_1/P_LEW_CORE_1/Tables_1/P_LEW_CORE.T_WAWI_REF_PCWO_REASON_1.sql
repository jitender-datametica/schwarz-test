CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_pcwo_reason_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
pcwo_reason_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
pcwo_reason_id_int BIGNUMERIC(38,0) NOT NULL,
pcwo_group_id BIGNUMERIC(38,0),
pcwo_group_desc STRING(50) COLLATE 'und:ci',
pcwo_active_fg BIGNUMERIC(38,0) NOT NULL,
pcwo_new_group_cd BIGNUMERIC(38,0),
load_id BIGNUMERIC(38,0) NOT NULL
);