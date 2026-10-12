CREATE TABLE CORE.T_DIM_CALENDAR_MONTH DATA_RETENTION_TIME_IN_DAYS = 2 (
   cal_month                           NUMBER(38,0)     NOT NULL,
   ldl_cal_month_name                  VARCHAR(100),
   cal_year                            NUMBER(38,0)     NOT NULL,
   month_of_cal_year                   NUMBER(38,0)     COMMENT 'The month of the calendar year as a number using the convention January = 1 ... December = 12.',
   prev_1y_cal_month                   NUMBER(38,0),
   cal_month_offset                    NUMBER(38,0)     COMMENT 'The difference in months between this calendar month and the current month. So if current calendar month is 201901, then the offset is 0 for 201901, -1 for 201812 and +1 for 201902.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_CALENDAR_MONTH PRIMARY KEY (cal_month) NOT ENFORCED 
)  COMMENT = '';