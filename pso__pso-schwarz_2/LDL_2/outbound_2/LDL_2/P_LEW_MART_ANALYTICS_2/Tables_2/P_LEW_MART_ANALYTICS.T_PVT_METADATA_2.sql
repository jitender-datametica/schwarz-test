CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_pvt_metadata_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
orig_item_nr BIGNUMERIC(38,0) NOT NULL,
item_desc STRING(100),
normal_fg BIGNUMERIC(38,0),
brand_fg BIGNUMERIC(38,0),
dur_shelflife_day_cust BIGNUMERIC(38,0),
itemgrp_int_cd BIGNUMERIC(38,0),
item_grp_int_name STRING(300),
subitemgrp_cd BIGNUMERIC(38,0),
sub_item_grp_name STRING(300),
familygrp_cd BIGNUMERIC(38,0),
item_fam_grp_name STRING(150) COLLATE 'und:ci',
vat_pct_val NUMERIC(18,5),
price_buying NUMERIC(18,5)
);