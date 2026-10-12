/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_calendar_date
   generated from Powerdesigner on Montag, 11. Dezember 2023 14:52:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_calendar_date (
cal_dt DATE NOT NULL,
cal_week BIGNUMERIC(38,0) NOT NULL,
cal_month BIGNUMERIC(38,0) NOT NULL,
cal_year BIGNUMERIC(38,0) NOT NULL,
day_of_week BIGNUMERIC(38,0) NOT NULL,
day_of_month BIGNUMERIC(38,0) NOT NULL,
day_of_cal_year BIGNUMERIC(38,0) NOT NULL,
ldl_cal_dt_offset BIGNUMERIC(38,0) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_dt) NOT ENFORCED
) OPTIONS(description='Comment 2Do             LDL: P_LEW_MART_MSI_AC_MATERIALIZED.V_CAL_CALENDARDAY');