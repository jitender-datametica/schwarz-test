CREATE TABLE CORE_REL.T_LDL_STORE DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_store_sid                       NUMBER(38,0)     NOT NULL,
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   ldl_store_nr                        VARCHAR(100),
   ldl_store_name                      VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_STORE PRIMARY KEY (ldl_store_sid) NOT ENFORCED 
)  COMMENT = '';
