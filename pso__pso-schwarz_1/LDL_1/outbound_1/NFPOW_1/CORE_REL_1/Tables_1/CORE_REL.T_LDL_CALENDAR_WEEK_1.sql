/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_calendar_week_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:42:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_calendar_week_1 (
cal_week BIGNUMERIC(38,0) NOT NULL,
ldl_prev_1y_cal_week BIGNUMERIC(38,0),
ldl_cal_week_offset BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_week) NOT ENFORCED
) OPTIONS(description='Comment 2Do             LDL: P_LEW_CORE.T_CAL_WEEK_1');