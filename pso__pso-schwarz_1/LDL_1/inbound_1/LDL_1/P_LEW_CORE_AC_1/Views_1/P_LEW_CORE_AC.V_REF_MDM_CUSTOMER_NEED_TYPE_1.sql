CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_CUSTOMER_NEED_TYPE_1 (
   mdm_cust_need_type_cd                    COMMENT 'Code to classify the assortment by general customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")'
  ,mdm_cust_need_type_name                  COMMENT 'Name of the general customer need.
CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'Classification of the assortment by general customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")'
AS SELECT
   mdm_cust_need_type_cd
  ,mdm_cust_need_type_name
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE_1
;