CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_ejr_code_mappings_1 (
recordtype STRING(2) COLLATE 'und:ci' NOT NULL,
transactiontype_id STRING(3) COLLATE 'und:ci' NOT NULL,
description STRING(200) COLLATE 'und:ci' NOT NULL,
dest_script STRING(200) COLLATE 'und:ci' NOT NULL,
dest_table STRING(200) COLLATE 'und:ci' NOT NULL,
dat_lastedit DATE NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL
);