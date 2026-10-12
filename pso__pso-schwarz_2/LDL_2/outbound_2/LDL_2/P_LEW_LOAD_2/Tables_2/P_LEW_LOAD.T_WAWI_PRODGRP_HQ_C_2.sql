CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_prodgrp_hq_c_2 (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38),
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq INTEGER NOT NULL,
mainitemgroup_id BIGNUMERIC(38) NOT NULL,
mainitemgroup_short_desc_ger STRING(15) COLLATE 'und:ci',
mainitemgroup_desc_german STRING(35) COLLATE 'und:ci' NOT NULL,
sorting_term INTEGER NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38)
);