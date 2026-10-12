CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_ITEM_STANDARD_PROPERTY_2 (
   mdm_item_standard_property_cd            COMMENT 'Code of the standardized item_2 property.
CBX: CNT_CODELIST.CODE (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)'
  ,mdm_item_standard_property_class_cd      COMMENT 'Class of the standardized item_2 properties: So far "TX" for textile item_2 properties and "HG" for hard goods item_2 properties
CBX: CNT_CODELIST_BOOK.CODELISTNAME (code list "LDL_CERT_Properties_TX" and "LDL_CERT_Properties_HG"), CNT_CODELIST.CODE (code list "CERT_TX*" and "CERT_HG*")'
  ,mdm_item_standard_property_txt           COMMENT 'Text containing names, abbreviations and descriptions of the standardized item_2 property.
CBX: CNT_CODELIST.NAME (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Item_2 standard properties, grouped by class.
CBX: CNT_CODELIST_BOOK_2 (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)'
AS SELECT
   mdm_item_standard_property_cd
  ,mdm_item_standard_property_class_cd
  ,mdm_item_standard_property_txt
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY_2
;