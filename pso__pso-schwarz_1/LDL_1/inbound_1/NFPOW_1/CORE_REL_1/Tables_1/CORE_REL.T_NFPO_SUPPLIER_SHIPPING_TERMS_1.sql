CREATE TABLE CORE_REL.T_NFPO_SUPPLIER_SHIPPING_TERMS_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_sup_ship_terms_cd              VARCHAR(100)     NOT NULL COMMENT 'PK Supplier_1 shipping terms;
            CBX: Vendor.custCodelist2.code;
            ESB: cbxItem.supplier.shippingTerms.code;',
   nfpo_sup_ship_terms_name            VARCHAR(100)     COMMENT 'Shipping terms name;
            CBX: Vendor.custCodelist2.name;
            ESB: cbxItem.supplier.shippingTerms.name;',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_SUPPLIER_SHIPPING_TERMS PRIMARY KEY (nfpo_sup_ship_terms_cd) NOT ENFORCED 
)  COMMENT = 'NFPO supplier_1 related shipping terms
             CBX:  CNT_CODELIST_1, code list ''LDL_WBP_CAL_PROFILE''';
