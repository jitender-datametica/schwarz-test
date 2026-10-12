CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_calendar_date_related_date_1 (
cal_dt DATE NOT NULL,
ldl_prev_1y_cal_dt DATE NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_dt, ldl_prev_1y_cal_dt) NOT ENFORCED
) OPTIONS(description='');