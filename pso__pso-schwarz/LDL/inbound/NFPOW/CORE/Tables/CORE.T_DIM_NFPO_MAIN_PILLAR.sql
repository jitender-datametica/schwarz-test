CREATE TABLE CORE.T_DIM_NFPO_MAIN_PILLAR DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_main_pillar_cd                 VARCHAR(100)     NOT NULL COMMENT 'code of the main pillar
            CBX: CNT_CODELIST.CODE (code list ''PRODUCT_CATEGORY'')',
   nfpo_main_pillar_name               VARCHAR(100)     NOT NULL COMMENT 'name  of the main pillar
            CBX: CNT_CODELIST.NAME (code list ''PRODUCT_CATEGORY'')',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_MAIN_PILLAR PRIMARY KEY (nfpo_main_pillar_cd) NOT ENFORCED 
)  COMMENT = '';