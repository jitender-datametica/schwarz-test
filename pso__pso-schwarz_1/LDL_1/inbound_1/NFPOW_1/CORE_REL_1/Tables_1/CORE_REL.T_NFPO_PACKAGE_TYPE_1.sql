CREATE TABLE CORE_REL.T_NFPO_PACKAGE_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_pack_type_cd                   VARCHAR(100)     NOT NULL COMMENT 'NFPO outer package_1 type codes for items
            CBX:  CNT_CODELIST.CODE, code list ''LIDL_PACKAGETYPE''',
   nfpo_pack_type_name                 VARCHAR(100)     COMMENT 'NFPO outer package_1 type names for items (NETZ/TOPF/BOX usw.)
            CBX:  CNT_CODELIST.NAME, code list ''LIDL_PACKAGETYPE''',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_PACKAGE_TYPE PRIMARY KEY (nfpo_pack_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO outer package_1 type for items (NETZ/TOPF/BOX usw.)
             CBX:  CNT_CODELIST_1, code list ''LIDL_PACKAGETYPE''';
