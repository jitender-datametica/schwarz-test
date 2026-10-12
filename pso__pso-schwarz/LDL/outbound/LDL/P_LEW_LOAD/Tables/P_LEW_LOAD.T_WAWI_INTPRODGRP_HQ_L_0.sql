CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_intprodgrp_hq_l_0 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
mainitemgroup_id BIGNUMERIC(38) NOT NULL,
mainitemgroup_short_desc_ctry STRING(15) COLLATE 'und:ci',
mainitemgroup_desc_country STRING(35) COLLATE 'und:ci',
sorting_term INTEGER,
dat_dayend DATE,
load_id BIGNUMERIC(38),
dc_server_id BIGNUMERIC(38) NOT NULL,
bic_zmlila STRING(20),
extraction_ts DATETIME,
record_id INTEGER,
source_system STRING(20) COLLATE 'und:ci'
);