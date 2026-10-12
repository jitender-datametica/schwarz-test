CREATE TABLE CORE.T_FACT_LDL_STORE_DAY DATA_RETENTION_TIME_IN_DAYS = 2 (
   lob_cd                              VARCHAR(100)     NOT NULL,
   ldl_store_sid                       NUMBER(38,0)     NOT NULL,
   cal_dt                              DATE             NOT NULL,
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   curr_cd                             VARCHAR(3)       NOT NULL,
   ldl_total_adjust_sales_net_val      NUMBER(38,5),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_FACT_LDL_STORE_DAY PRIMARY KEY (lob_cd, ldl_store_sid, cal_dt, curr_cd) NOT ENFORCED 
)  COMMENT = '';