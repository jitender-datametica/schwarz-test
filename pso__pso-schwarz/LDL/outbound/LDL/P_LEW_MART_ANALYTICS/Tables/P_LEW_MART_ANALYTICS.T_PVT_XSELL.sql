CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_pvt_xsell (
client_id BIGNUMERIC(38,0) NOT NULL,
week_id BIGNUMERIC(38,0) NOT NULL,
orig_item_nr_lhs BIGNUMERIC(38,0) NOT NULL,
orig_item_nr_rhs BIGNUMERIC(38,0) NOT NULL,
ref_start_dt DATE NOT NULL,
ref_end_dt DATE NOT NULL,
same_subitemgrp_fg BIGNUMERIC(38,0) NOT NULL,
item_desc_lhs STRING(100) COLLATE 'und:ci' NOT NULL,
item_desc_rhs STRING(100) COLLATE 'und:ci' NOT NULL,
rule_support NUMERIC(18,5) NOT NULL,
mdl_confidence NUMERIC(18,5) NOT NULL,
mdl_lift NUMERIC(18,5) NOT NULL,
mdl_coefficient NUMERIC(18,5) NOT NULL,
xsell_id BIGNUMERIC(38,0) NOT NULL,
partkey STRING(300) COLLATE 'und:ci' NOT NULL,
uap_filename STRING(300) COLLATE 'und:ci' NOT NULL,
mod_tmsp DATETIME NOT NULL
);