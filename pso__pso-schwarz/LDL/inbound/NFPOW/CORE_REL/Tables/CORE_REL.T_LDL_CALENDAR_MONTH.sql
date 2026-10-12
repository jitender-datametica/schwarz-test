CREATE TABLE CORE_REL.T_LDL_CALENDAR_MONTH DATA_RETENTION_TIME_IN_DAYS = 2 (
   cal_month                           NUMBER(38,0)     NOT NULL,
   ldl_cal_month_name                  VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_CALENDAR_MONTH PRIMARY KEY (cal_month) NOT ENFORCED 
)  COMMENT = '';
