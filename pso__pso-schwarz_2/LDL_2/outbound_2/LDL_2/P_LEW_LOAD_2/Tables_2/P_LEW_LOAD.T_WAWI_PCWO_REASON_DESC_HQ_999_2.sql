CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_pcwo_reason_desc_hq_999_2 (
client_id BIGNUMERIC(38) NOT NULL,
pcwo_reason_id BIGNUMERIC(38) NOT NULL,
language_id BIGNUMERIC(38) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
pcwo_reason_desc STRING(50) COLLATE 'und:ci',
load_id BIGNUMERIC(38) NOT NULL
);