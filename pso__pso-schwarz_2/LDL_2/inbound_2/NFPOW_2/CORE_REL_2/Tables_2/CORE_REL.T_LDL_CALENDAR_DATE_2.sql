/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_calendar_date_2
   generated from Powerdesigner on Montag, 11. Dezember 2023 14:52:00
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_CALENDAR_DATE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   cal_dt                              DATE             NOT NULL,
   cal_week                            NUMBER(38,0)     NOT NULL,
   cal_month                           NUMBER(38,0)     NOT NULL,
   cal_year                            NUMBER(38,0)     NOT NULL,
   day_of_week                         NUMBER(38,0)     NOT NULL,
   day_of_month                        NUMBER(38,0)     NOT NULL,
   day_of_cal_year                     NUMBER(38,0)     NOT NULL,
   ldl_cal_dt_offset                   NUMBER(38,0)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_CALENDAR_DATE PRIMARY KEY (cal_dt) NOT ENFORCED 
)  COMMENT = 'Comment 2Do
             LDL: P_LEW_MART_MSI_AC_MATERIALIZED.V_CAL_CALENDARDAY_2';
