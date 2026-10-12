CREATE TABLE CORE_REL.T_LDL_LISTING_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_list_type_id                    NUMBER(38,0)     NOT NULL,
   ldl_list_type_name                  VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_LISTING_TYPE PRIMARY KEY (ldl_list_type_id) NOT ENFORCED 
)  COMMENT = '';
