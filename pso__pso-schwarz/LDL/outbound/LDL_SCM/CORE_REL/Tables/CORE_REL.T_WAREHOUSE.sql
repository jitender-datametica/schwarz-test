CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_warehouse (
client_id INTEGER,
country_cd STRING(160),
src_orig_wh_nr BIGNUMERIC(38,0),
src_wh_id BIGNUMERIC(38,0),
loc_name STRING(100),
loc_name2 STRING(100),
dwh_updated_tmsp DATETIME,
dwh_created_tmsp DATETIME
);