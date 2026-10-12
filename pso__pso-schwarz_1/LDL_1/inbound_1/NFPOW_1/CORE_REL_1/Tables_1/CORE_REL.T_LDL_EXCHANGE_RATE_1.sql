CREATE TABLE CORE_REL.T_LDL_EXCHANGE_RATE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   src_curr_cd                         VARCHAR(3)       NOT NULL,
   tgt_curr_cd                         VARCHAR(3)       NOT NULL,
   ldl_exchange_rate                   NUMBER(38,5),
   ldl_local_curr_fg                   BOOLEAN,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_EXCHANGE_RATE PRIMARY KEY (ldl_client_id, src_curr_cd, tgt_curr_cd) NOT ENFORCED 
)  COMMENT = '';
