CREATE TABLE CORE_REL.T_LDL_CALENDAR_DATE_RELATED_DATE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   cal_dt                              DATE             NOT NULL,
   ldl_prev_1y_cal_dt                  DATE             NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_CALENDAR_DATE_RELATED_DATE PRIMARY KEY (cal_dt, ldl_prev_1y_cal_dt) NOT ENFORCED 
)  COMMENT = '';
