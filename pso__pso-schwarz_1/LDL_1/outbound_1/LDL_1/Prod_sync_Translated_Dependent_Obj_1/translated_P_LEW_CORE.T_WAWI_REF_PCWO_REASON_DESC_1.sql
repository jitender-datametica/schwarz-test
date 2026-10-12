CREATE OR REPLACE TABLE ldl_p_lew_core.t_wawi_ref_pcwo_reason_desc_1 (
client_id INTEGER NOT NULL,
pcwo_reason_id INTEGER NOT NULL,
language_id INTEGER NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
pcwo_reason_desc STRING(50) COLLATE 'und:ci',
load_id INTEGER NOT NULL
);