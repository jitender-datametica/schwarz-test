/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_standard_property
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_standard_property (
nfpo_item_standard_property_cd STRING(100) NOT NULL
OPTIONS(description='Code of the standardized item property.            CBX: CNT_CODELIST.CODE (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)            LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY.MDM_ITEM_STANDARD_PROPERTY_CD'),
nfpo_item_standard_property_class_cd STRING(100) NOT NULL
OPTIONS(description='Class of the standardized item properties: So far "TX" for textile item properties and "HG" for hard goods item properties            CBX: CNT_CODELIST_BOOK.CODELISTNAME (code list "LDL_CERT_Properties_TX" and "LDL_CERT_Properties_HG"), CNT_CODELIST.CODE (code list "CERT_TX*" and "CERT_HG*")            LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY.MDM_ITEM_STANDARD_PROPERTY_CLASS_CD'),
nfpo_item_standard_property_txt STRING(1000)
OPTIONS(description='Text containing names, abbreviations and descriptions of the standardized item property.            CBX: CNT_CODELIST.NAME (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)            LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY.MDM_ITEM_STANDARD_PROPERTY_TXT'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_standard_property_class_cd, nfpo_item_standard_property_cd) NOT ENFORCED
)
OPTIONS(description='Item standard properties, grouped by class.             CBX: CNT_CODELIST_BOOK (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)             LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY');