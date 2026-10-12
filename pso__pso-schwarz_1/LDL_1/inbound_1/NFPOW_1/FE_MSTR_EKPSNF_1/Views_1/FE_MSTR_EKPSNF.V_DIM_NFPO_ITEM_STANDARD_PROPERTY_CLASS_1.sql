CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_ITEM_STANDARD_PROPERTY_CLASS_1 (
   nfpo_item_standard_property_class_cd     COMMENT 'Class of the standardized item_1 properties: So far "TX" for textile item_1 properties and "HG" for hard goods item_1 properties.
LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS.MDM_ITEM_STANDARD_PROPERTY_CLASS_CD
CORE_REL: T_NFPO_ITEM_STANDARD_PROPERTY_CLASS.NFPO_ITEM_STANDARD_PROPERTY_CLASS_CD'
  ,nfpo_item_standard_property_class_descr  COMMENT 'Description of the class of standardized item_1 properties.
LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS.MDM_ITEM_STANDARD_PROPERTY_CLASS_DESCR
CORE_REL: T_NFPO_ITEM_STANDARD_PROPERTY_CLASS.NFPO_ITEM_STANDARD_PROPERTY_CLASS_DESCR'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'Classes of item_1 standard properties. So far "TX" for textile item_1 properties and "HG" for hard goods item_1 properties.
Manually filled values derived from:
CBX: LDL_ITEM_CERTIFICATION column names LDL_CERTIFICATION_PROPERTY_TX and LDL_CERTIFICATION_PROPERTY_HG
or from the CNT_CODELIST_BOOK.CODELISTNAME entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX"
LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS_1
CORE_REL: T_NFPO_ITEM_STANDARD_PROPERTY_CLASS_1'
AS SELECT
   nfpo_item_standard_property_class_cd
  ,nfpo_item_standard_property_class_descr
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_ITEM_STANDARD_PROPERTY_CLASS_1
;