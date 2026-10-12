CREATE TABLE CORE_REL.T_NFPO_ORGANIZATION_LDL_CLIENT_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'surrogate key internal organisation',
   nfpo_org_type_cd                    VARCHAR(100)     NOT NULL COMMENT 'type code of the internal organisation (defined by the data modeler)',
   ldl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key CLIENT',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ORGANIZATION_LDL_CLIENT PRIMARY KEY (nfpo_org_sid, ldl_client_id) NOT ENFORCED 
)  COMMENT = 'This table contains the relationship between internal organisations and erp system based clients. this relationship can be 1:n, m:1 or m:n, depending on the organisation type';
