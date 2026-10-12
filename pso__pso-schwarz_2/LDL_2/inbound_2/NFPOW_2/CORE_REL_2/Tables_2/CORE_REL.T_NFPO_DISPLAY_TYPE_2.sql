CREATE TABLE CORE_REL.T_NFPO_DISPLAY_TYPE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_display_type_cd                VARCHAR(100)     NOT NULL COMMENT 'PK Display type;
            CBX: Item.ldlDisplayType.code;
            ESB: cbxItem.displayType.code;',
   nfpo_display_type_name              VARCHAR(100)     COMMENT 'Display type description;
            CBX: Item.ldlDisplayType.name;
            ESB: cbxItem.displayType.name;',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_DISPLAY_TYPE PRIMARY KEY (nfpo_display_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO display types of items
             CBX:  CNT_CODELIST_2, code list ''LIDL_DISPLAYTYPE''';
