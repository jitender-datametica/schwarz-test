CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_time_type_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
time_type_sid BIGNUMERIC(38,0) NOT NULL,
src_wh_id BIGNUMERIC(38,0),
src_time_type_id BIGNUMERIC(38,0),
src_time_type_cd STRING(20) COLLATE 'und:ci',
time_type_short_descr STRING(20) COLLATE 'und:ci',
time_type_descr STRING(100) COLLATE 'und:ci',
presence_fg BIGNUMERIC(38,0),
performance_relevant_fg BIGNUMERIC(38,0),
source_system STRING(20) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, time_type_sid) NOT ENFORCED
) CLUSTER BY client_id;