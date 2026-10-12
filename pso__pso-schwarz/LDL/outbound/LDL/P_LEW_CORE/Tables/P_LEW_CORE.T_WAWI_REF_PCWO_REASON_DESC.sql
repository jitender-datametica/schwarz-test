CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_pcwo_reason_desc (
client_id BIGNUMERIC(38,0) NOT NULL,
pcwo_reason_id BIGNUMERIC(38,0) NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
pcwo_reason_desc STRING(50) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL
);