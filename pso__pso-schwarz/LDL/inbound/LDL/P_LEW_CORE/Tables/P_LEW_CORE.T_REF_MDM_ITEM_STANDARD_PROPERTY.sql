/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_standard_property
   generated from Powerdesigner on Dienstag, 25. November 2025 15:34:15
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY (
   mdm_item_standard_property_cd       VARCHAR(100)     NOT NULL COMMENT 'Code of the standardized item property.
            CBX: CNT_CODELIST.CODE (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)',
   mdm_item_standard_property_class_cd VARCHAR(100)     NOT NULL COMMENT 'Class of the standardized item properties: So far "TX" for textile item properties and "HG" for hard goods item properties
            CBX: CNT_CODELIST_BOOK.CODELISTNAME (code list "LDL_CERT_Properties_TX" and "LDL_CERT_Properties_HG"), CNT_CODELIST.CODE (code list "CERT_TX*" and "CERT_HG*")',
   mdm_item_standard_property_txt      VARCHAR(1000)    COMMENT 'Text containing names, abbreviations and descriptions of the standardized item property.
            CBX: CNT_CODELIST.NAME (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_ITEM_STANDARD_PROPERTY PRIMARY KEY (mdm_item_standard_property_class_cd, mdm_item_standard_property_cd) NOT ENFORCED 
)  COMMENT = 'Item standard properties, grouped by class.
             CBX: CNT_CODELIST_BOOK (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)';
