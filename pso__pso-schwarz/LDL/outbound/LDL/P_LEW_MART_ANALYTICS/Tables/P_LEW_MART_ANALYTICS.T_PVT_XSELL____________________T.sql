CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_pvt_xsell____________________t (
client_id BIGNUMERIC(38,0),
week_id BIGNUMERIC(38,0),
orig_item_nr_lhs BIGNUMERIC(38,0),
orig_item_nr_rhs BIGNUMERIC(38,0),
ref_start_dt DATE,
ref_end_dt DATE,
same_subitemgrp_fg BIGNUMERIC(38,0),
item_desc_lhs STRING(100) COLLATE 'und:ci',
item_desc_rhs STRING(100) COLLATE 'und:ci',
rule_support NUMERIC(18,5),
mdl_confidence NUMERIC(18,5),
mdl_lift NUMERIC(18,5),
mdl_coefficient NUMERIC(18,5),
xsell_id BIGNUMERIC(38,0),
partkey STRING(300) COLLATE 'und:ci',
uap_filename STRING(300) COLLATE 'und:ci',
mod_tmsp DATETIME
);