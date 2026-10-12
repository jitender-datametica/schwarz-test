CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS_2 (
   mdm_item_standard_property_class_cd      COMMENT 'Class of the standardized item_2 properties: So far "TX" for textile item_2 properties and "HG" for hard goods item_2 properties.'
  ,mdm_item_standard_property_class_descr   COMMENT 'Description of the class of standardized item_2 properties.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Classes of item_2 standard properties. So far "TX" for textile item_2 properties and "HG" for hard goods item_2 properties.
Manually filled values derived from:
CBX: LDL_ITEM_CERTIFICATION column names LDL_CERTIFICATION_PROPERTY_TX and LDL_CERTIFICATION_PROPERTY_HG
or from the CNT_CODELIST_BOOK.CODELISTNAME entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX"'
AS SELECT
   mdm_item_standard_property_class_cd
  ,mdm_item_standard_property_class_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS_2
;