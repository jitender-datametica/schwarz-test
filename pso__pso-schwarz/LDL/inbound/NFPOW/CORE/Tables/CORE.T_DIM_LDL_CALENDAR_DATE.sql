/* --------------------------------------------------------------------------------
   DDL for table: t_dim_ldl_calendar_date
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 11:17:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_LDL_CALENDAR_DATE DATA_RETENTION_TIME_IN_DAYS = 2 (
   cal_dt                              DATE             NOT NULL,
   cal_month                           NUMBER(38,0)     NOT NULL,
   cal_year                            NUMBER(38,0)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_LDL_CALENDAR_DATE PRIMARY KEY (cal_dt) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';
