CREATE TABLE IF NOT EXISTS ldl_bcbi_fe_mstr_bcbi.t_dataavail_wh_expected_list_1 (
client_id BIGNUMERIC(38,0),
country_iso STRING(20),
country_name STRING(100) COLLATE 'und:ci',
wh_id BIGNUMERIC(38,0),
wh_desc STRING(50) COLLATE 'und:ci',
wh_type STRING(16777216),
wh_active_fg BOOL,
system_key BIGNUMERIC(38,0),
system_desc STRING(20) COLLATE 'und:ci',
interface_key BIGNUMERIC(38,0),
interface_desc STRING(100) COLLATE 'und:ci',
is_optional BOOL,
dat_rec_start DATE,
dat_rec_end DATE,
last_update DATE,
timestamp_load_bcbi TIMESTAMP
);