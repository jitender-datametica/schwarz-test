CREATE TABLE CORE_REL.T_LDL_CLIENT DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   ldl_client_cd                       VARCHAR(100),
   ldl_client_name                     VARCHAR(100),
   ldl_reporting_fg                    BOOLEAN,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_CLIENT PRIMARY KEY (ldl_client_id) NOT ENFORCED 
)  COMMENT = '';
