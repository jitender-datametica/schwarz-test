CREATE TABLE CORE_REL.T_NFPO_SUPPLIER_LDL_SUPPLIER_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_sup_sid                        NUMBER(38,0)     NOT NULL,
   ldl_sup_sid                         NUMBER(38,0)     NOT NULL,
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_SUPPLIER_LDL_SUPPLIER PRIMARY KEY (ldl_sup_sid, nfpo_sup_sid) NOT ENFORCED 
)  COMMENT = '';
