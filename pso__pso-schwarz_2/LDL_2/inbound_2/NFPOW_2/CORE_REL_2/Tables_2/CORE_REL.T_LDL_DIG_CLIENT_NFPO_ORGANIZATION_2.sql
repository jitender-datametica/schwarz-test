/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_dig_client_nfpo_organization_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:39:33
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_DIG_CLIENT_NFPO_ORGANIZATION_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_dig_client_cd                   VARCHAR(100)     NOT NULL COMMENT 'Client code in the Lidl Digital DWH.',
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key internal organization.
            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_DIG_CLIENT_NFPO_ORGANIZATION PRIMARY KEY (ldl_dig_client_cd) NOT ENFORCED 
)  COMMENT = 'Lidl Digital Web Shops to NFPO Organizations.';
