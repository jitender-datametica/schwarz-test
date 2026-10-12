CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_desc_hq_t_2 (
client_id BIGNUMERIC(38) NOT NULL,
description_id BIGNUMERIC(38) NOT NULL,
code STRING(50) COLLATE 'und:ci' NOT NULL,
description STRING(150) COLLATE 'und:ci' NOT NULL,
buyer_link BIGNUMERIC(38),
read_only BIGNUMERIC(38) NOT NULL,
desc_type STRING(35) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38) NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38) NOT NULL
);