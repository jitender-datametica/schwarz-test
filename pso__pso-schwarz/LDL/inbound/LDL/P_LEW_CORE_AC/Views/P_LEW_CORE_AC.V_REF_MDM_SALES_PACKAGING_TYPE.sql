CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_SALES_PACKAGING_TYPE (
   mdm_sales_packaging_type_cd              COMMENT 'Code of the sales packaging types.
CBX: CNT_CODELIST.CODE (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")'
  ,mdm_sales_packaging_type_name            COMMENT 'Name of the sales packaging types.
CBX: CNT_CODELIST.NAME (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'NFPO list of sales packaging types.
CBX: CNT_CODELIST (code list "LDL_RETAIL_PACKAGING" and "LIDL_RETAILPACK_KL")'
AS SELECT
   mdm_sales_packaging_type_cd
  ,mdm_sales_packaging_type_name
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE
;