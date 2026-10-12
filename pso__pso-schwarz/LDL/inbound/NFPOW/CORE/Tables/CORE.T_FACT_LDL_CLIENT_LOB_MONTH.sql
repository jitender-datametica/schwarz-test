CREATE TABLE CORE.T_FACT_LDL_CLIENT_LOB_MONTH DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   lob_cd                              VARCHAR(100)     NOT NULL,
   cal_month                           NUMBER(38,0)     NOT NULL,
   cal_year                            NUMBER(38,0)     NOT NULL,
   curr_cd                             VARCHAR(3)       NOT NULL,
   ldl_total_adjust_sales_net_val      NUMBER(38,5),
   ldl_prev_1y_total_adjust_sales_net_val NUMBER(38,5),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_FACT_LDL_CLIENT_LOB_MONTH PRIMARY KEY (ldl_client_id, lob_cd, cal_month, curr_cd) NOT ENFORCED 
)  COMMENT = '';