/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_standard_property
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_STANDARD_PROPERTY DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_standard_property_cd      VARCHAR(100)     NOT NULL COMMENT 'Code of the standardized item property.
            CBX: CNT_CODELIST.CODE (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY.MDM_ITEM_STANDARD_PROPERTY_CD',
   nfpo_item_standard_property_class_cd VARCHAR(100)     NOT NULL COMMENT 'Class of the standardized item properties: So far "TX" for textile item properties and "HG" for hard goods item properties
            CBX: CNT_CODELIST_BOOK.CODELISTNAME (code list "LDL_CERT_Properties_TX" and "LDL_CERT_Properties_HG"), CNT_CODELIST.CODE (code list "CERT_TX*" and "CERT_HG*")
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY.MDM_ITEM_STANDARD_PROPERTY_CLASS_CD',
   nfpo_item_standard_property_txt     VARCHAR(1000)    COMMENT 'Text containing names, abbreviations and descriptions of the standardized item property.
            CBX: CNT_CODELIST.NAME (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY.MDM_ITEM_STANDARD_PROPERTY_TXT',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_STANDARD_PROPERTY PRIMARY KEY (nfpo_item_standard_property_class_cd, nfpo_item_standard_property_cd) NOT ENFORCED 
)  COMMENT = 'Item standard properties, grouped by class.
             CBX: CNT_CODELIST_BOOK (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)
             LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY';

