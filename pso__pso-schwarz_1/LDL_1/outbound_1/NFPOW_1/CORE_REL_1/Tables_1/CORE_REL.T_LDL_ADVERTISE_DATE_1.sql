CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_advertise_date_1 (
ldl_client_id BIGNUMERIC(38,0),
ldl_adv_dt DATE,
ldl_adv_dt_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.')
) OPTIONS(description='');