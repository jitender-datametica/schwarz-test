CREATE TABLE CORE_REL.T_NFPO_WARRANTY_DURATION_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_warranty_dur_cd                VARCHAR(100)     NOT NULL COMMENT 'PK Guarantee type;
            CBX: Item.ldlGuarantee.code;
            ESB: cbxItem.displayType.code;',
   nfpo_warranty_dur_name              VARCHAR(100)     COMMENT 'Guarantee description;
            CBX: Item.ldlGuarantee.name;
            ESB: cbxItem.guarantee.name;',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_WARRANTY_DURATION PRIMARY KEY (nfpo_warranty_dur_cd) NOT ENFORCED 
)  COMMENT = 'NFPO warranty length types of items
             CBX:  CNT_CODELIST_1, code list ''LIDL_WARRANTY''';
