CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_intprodgrp_hq_c_2 (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38),
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
mainitemgroup_id BIGNUMERIC(38) NOT NULL,
mainitemgroup_short_desc_ctry STRING(15) COLLATE 'und:ci',
mainitemgroup_desc_country STRING(35) COLLATE 'und:ci',
sorting_term INTEGER,
dat_dayend DATE,
load_id BIGNUMERIC(38)
);