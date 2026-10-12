CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_ldl_store_day (
lob_cd STRING(100) NOT NULL,
ldl_store_sid BIGNUMERIC(38,0) NOT NULL,
cal_dt DATE NOT NULL,
ldl_client_id BIGNUMERIC(38,0) NOT NULL,
curr_cd STRING(3) NOT NULL,
ldl_total_adjust_sales_net_val BIGNUMERIC(38,5),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd, ldl_store_sid, cal_dt, curr_cd) NOT ENFORCED
) OPTIONS(description='');