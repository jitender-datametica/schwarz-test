CREATE TABLE CORE_REL.T_LDL_METRIC_STORE_DAY DATA_RETENTION_TIME_IN_DAYS = 2 (
   metric_type_id                      NUMBER(38,0)     NOT NULL,
   ldl_store_sid                       NUMBER(38,0)     NOT NULL,
   cal_dt                              DATE             NOT NULL,
   metric_cnt                          NUMBER(38,0),
   metric_qty                          NUMBER(38,5),
   metric_val                          NUMBER(38,5),
   curr_cd                             VARCHAR(3),
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_METRIC_STORE_DAY PRIMARY KEY (metric_type_id, ldl_store_sid, cal_dt) NOT ENFORCED 
)  COMMENT = '';
