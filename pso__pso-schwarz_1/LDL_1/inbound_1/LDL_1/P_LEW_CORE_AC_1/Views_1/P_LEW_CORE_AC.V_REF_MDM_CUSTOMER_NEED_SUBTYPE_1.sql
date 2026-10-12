CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_CUSTOMER_NEED_SUBTYPE_1 (
   mdm_cust_need_subtype_cd                 COMMENT 'Code to classify the assortment by detailed customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")'
  ,mdm_cust_need_type_cd                    COMMENT 'Current code to classify the detailed customer need by general customer needs.
CBX: CMT_CODELIST_BOOK.cust_codelist1 (code list "LIDL_CATEGORY_NEEDS")'
  ,mdm_cust_need_subtype_name               COMMENT 'Name of the detailed customer need.
CBX: CNT_CODELIST.NAME (code list "LIDL_CATEGORY_NEEDS")'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Classification of the assortment by detailed customer needs. The detailed customer needs are grouped into general customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")'
AS SELECT
   mdm_cust_need_subtype_cd
  ,mdm_cust_need_type_cd
  ,mdm_cust_need_subtype_name
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE_1
;