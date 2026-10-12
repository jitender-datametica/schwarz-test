/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_standard_property
   generated from Powerdesigner on Dienstag, 25. November 2025 15:34:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_item_standard_property (
mdm_item_standard_property_cd STRING(100) NOT NULL
OPTIONS(description='''Code of the standardized item property.
            CBX: CNT_CODELIST.CODE (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)'''),
mdm_item_standard_property_class_cd STRING(100) NOT NULL
OPTIONS(description='''Class of the standardized item properties: So far "TX" for textile item properties and "HG" for hard goods item properties
            CBX: CNT_CODELIST_BOOK.CODELISTNAME (code list "LDL_CERT_Properties_TX" and "LDL_CERT_Properties_HG"), CNT_CODELIST.CODE (code list "CERT_TX*" and "CERT_HG*")'''),
mdm_item_standard_property_txt STRING(1000)
OPTIONS(description='''Text containing names, abbreviations and descriptions of the standardized item property.
            CBX: CNT_CODELIST.NAME (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)'''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_standard_property_class_cd, mdm_item_standard_property_cd) NOT ENFORCED
)
OPTIONS(description='''Item standard properties, grouped by class.
             CBX: CNT_CODELIST_BOOK (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)''');