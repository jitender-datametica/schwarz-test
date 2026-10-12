CREATE TABLE CORE_REL.T_NFPO_GTIN_OWNERSHIP_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_gtin_ownership_cd              VARCHAR(100)     NOT NULL COMMENT 'PK EAN_2 Ownership;
            CBX: Vendor.custCodeList1.code;
            ESB: cbxItem.supplier.eanOwnership.code;',
   nfpo_gtin_ownership_descr           VARCHAR(250)     COMMENT 'EAN_2 Ownership;
            CBX: Vendor.custCodeList1.name;
            ESB: cbxItem.supplier.eanOwnership.name;',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_GTIN_OWNERSHIP PRIMARY KEY (nfpo_gtin_ownership_cd) NOT ENFORCED 
)  COMMENT = 'NFPO responsibilty of GTIN assignement to items
             CBX:  CNT_CODELIST_2, code list ''LIDL_GTIN_OUTPUT''';
