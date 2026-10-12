CREATE TABLE CORE_REL.T_NFPO_BRAND_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_brand_type_cd                  VARCHAR(100)     NOT NULL,
   nfpo_brand_type_name                VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_BRAND_TYPE PRIMARY KEY (nfpo_brand_type_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $ Brand_1 Type;
             Static data:
             M: Marke
             EM: Eigenmarke';
