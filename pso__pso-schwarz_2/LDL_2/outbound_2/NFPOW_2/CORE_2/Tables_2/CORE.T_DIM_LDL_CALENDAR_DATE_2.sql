/* --------------------------------------------------------------------------------
   DDL for table: t_dim_ldl_calendar_date_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 11:17:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_ldl_calendar_date_2 (
cal_dt DATE NOT NULL,
cal_month BIGNUMERIC(38,0) NOT NULL,
cal_year BIGNUMERIC(38,0) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_dt) NOT ENFORCED
) OPTIONS(description='Comment 2Do');