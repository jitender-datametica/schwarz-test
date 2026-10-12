CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_exchange_rate_2 (
ldl_client_id BIGNUMERIC(38,0) NOT NULL,
src_curr_cd STRING(3) NOT NULL,
tgt_curr_cd STRING(3) NOT NULL,
ldl_exchange_rate BIGNUMERIC(38,5),
ldl_local_curr_fg BOOL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_client_id, src_curr_cd, tgt_curr_cd) NOT ENFORCED
) OPTIONS(description='');