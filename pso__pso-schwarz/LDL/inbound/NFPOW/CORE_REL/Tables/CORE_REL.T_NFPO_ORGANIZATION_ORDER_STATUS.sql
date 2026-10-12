CREATE TABLE CORE_REL.T_NFPO_ORGANIZATION_ORDER_STATUS DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_org_order_status_cd            VARCHAR(100)     NOT NULL COMMENT 'PK Buying status;
            CBX: Item.ldlCountryOrderStatus.code;
            ESB: cbxItem.countryOrderStatus.code;',
   nfpo_org_order_status_descr_de      VARCHAR(250)     NOT NULL COMMENT 'Buying status;
            CBX: Item.ldlCountryOrderStatus.name;
            ESB: cbxItem.countryOrderStatus.name;',
   nfpo_org_order_status_descr_en      VARCHAR(250)     NOT NULL COMMENT 'Buying status description;
            CBX: Item.ldlCountryOrderStatus.custText1;
            ESB: cbxItem.countryOrderStatus.description;',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ORGANIZATION_ORDER_STATUS PRIMARY KEY (nfpo_org_order_status_cd) NOT ENFORCED 
)  COMMENT = 'NFPO status codes related to the order quantity definition process for the local NFPO''s of items
             CBX:  CNT_CODELIST, code list ''LIDL_CO_STATUS''';
