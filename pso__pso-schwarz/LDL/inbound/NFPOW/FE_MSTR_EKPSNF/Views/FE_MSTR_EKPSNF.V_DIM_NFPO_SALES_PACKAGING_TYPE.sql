CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_SALES_PACKAGING_TYPE (
   nfpo_sales_packaging_type_cd             COMMENT 'Code of the sales packaging types.
CBX: CNT_CODELIST.CODE (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")
LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE.MDM_SALES_PACKAGING_TYPE_CD
CORE_REL: T_NFPO_SALES_PACKAGING_TYPE.NFPO_SALES_PACKAGING_TYPE_CD'
  ,nfpo_sales_packaging_type_name           COMMENT 'Name of the sales packaging types.
CBX: CNT_CODELIST.NAME (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")
LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE.MDM_SALES_PACKAGING_TYPE_NAME
CORE_REL: T_NFPO_SALES_PACKAGING_TYPE.NFPO_SALES_PACKAGING_TYPE_NAME'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'NFPO list of sales packaging types.
CBX: CNT_CODELIST (code list "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")
LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE
CORE_REL: T_NFPO_SALES_PACKAGING_TYPE'
AS SELECT
   nfpo_sales_packaging_type_cd
  ,nfpo_sales_packaging_type_name
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_SALES_PACKAGING_TYPE
;