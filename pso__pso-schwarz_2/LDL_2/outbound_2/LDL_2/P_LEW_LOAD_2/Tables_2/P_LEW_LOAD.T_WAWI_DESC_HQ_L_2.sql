CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_desc_hq_l_2 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
code STRING(25) COLLATE 'und:ci' NOT NULL,
description STRING(80) COLLATE 'und:ci',
buyer_link BIGNUMERIC(38),
description_id BIGNUMERIC(38) NOT NULL,
read_only BIGNUMERIC(38) NOT NULL,
desc_type STRING(25) COLLATE 'und:ci' NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38) NOT NULL
);