/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_calendar_date_2
   generated from Powerdesigner on Dienstag, 12. Dezember 2023 14:02:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_calendar_date_2 (
cal_dt DATE NOT NULL OPTIONS(description='Calendar_2 day.'),
cal_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Calendar_2 week.'),
nfpo_cal_week_name STRING(100) NOT NULL OPTIONS(description='Name of the calendar_2 week'),
cal_week_begin_dt DATE NOT NULL OPTIONS(description='Datum des Montags der Kalenderwoche'),
cal_month BIGNUMERIC(38,0) NOT NULL,
cal_year BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr'),
bus_year BIGNUMERIC(38,0) NOT NULL,
day_of_week BIGNUMERIC(38,0) NOT NULL,
day_of_month BIGNUMERIC(38,0) NOT NULL,
day_of_cal_year BIGNUMERIC(38,0) NOT NULL,
ldl_cal_dt_offset BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_dt) NOT ENFORCED
) OPTIONS(description='Comment 2Do');