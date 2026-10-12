CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_map_intgr_migr (
ec_cd BIGNUMERIC(38,0) NOT NULL,
itm_sid BIGNUMERIC(38,0) NOT NULL,
itm_id STRING(20),
client_id BIGNUMERIC(38,0),
item_mis_id BIGNUMERIC(38,0),
orig_item_nr INTEGER,
case_size BIGNUMERIC(38,0),
itm_dat_valid_from DATE,
itm_origin_cd BIGNUMERIC(38,0),
match_dat DATE,
new_itm_sid BIGNUMERIC(38,0),
log_var_id STRING(20),
intgr_fg BIGNUMERIC(38,0),
core_load_id BIGNUMERIC(38,0) NOT NULL
) CLUSTER BY ec_cd;