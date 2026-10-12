CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_report_infotext (
report STRING(50),
entry_no BIGNUMERIC(38,0),
info_type STRING(50),
info_text STRING(50),
info_link STRING(50),
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP
);