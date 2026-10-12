CREATE TABLE CORE_REL.T_NFPO_LDL_BRAND DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_ldl_brand_sid                  NUMBER(38,0)     NOT NULL,
   nfpo_ldl_brand_nr                   VARCHAR(100),
   nfpo_ldl_brand_name                 VARCHAR(100),
   nfpo_brand_type_cd                  VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_LDL_BRAND PRIMARY KEY (nfpo_ldl_brand_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. BRND; Marken; ';
