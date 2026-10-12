CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_description (
client_id BIGNUMERIC(38,0) NOT NULL,
description_id BIGNUMERIC(38,0) NOT NULL,
code STRING(50) COLLATE 'und:ci' NOT NULL,
description STRING(150) COLLATE 'und:ci' NOT NULL,
buyer_link BIGNUMERIC(38,0),
read_only BIGNUMERIC(38,0) NOT NULL,
desc_type STRING(35) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38,0) NOT NULL
);