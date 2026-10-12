CREATE TABLE CORE_REL.T_NFPO_WARRANTY_TYPE DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_warranty_type_cd               VARCHAR(100)     NOT NULL COMMENT 'PK Guarantee Type;
            CBX: Item.ldlWarrantyArtType.code; 
            ESB: cbxItem.guaranteeType.code;',
   nfpo_warranty_type_name             VARCHAR(100)     COMMENT ' Guarantee Type description;
            CBX: Item.ldlWarrantyArtType.name; 
            ESB: cbxItem.guaranteeType.name;',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_WARRANTY_TYPE PRIMARY KEY (nfpo_warranty_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO warranty types of items
             CBX:  CNT_CODELIST, code list ''LIDL_WARRANTY_ART''';
