CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_CUSTOMER_NEED_TYPE (
   nfpo_cust_need_type_cd                   COMMENT 'Code to classify the assortment by general customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")
LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE.MDM_CUST_NEED_TYPE_CD
CORE_REL: T_NFPO_CUSTOMER_NEED_TYPE.NFPO_CUST_NEED_TYPE_CD'
  ,nfpo_cust_need_type_name                 COMMENT 'Name of the general customer need.
CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")
LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE.MDM_CUST_NEED_TYPE_NAME
CORE_REL: T_NFPO_CUSTOMER_NEED_TYPE.NFPO_CUST_NEED_TYPE_NAME'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'Classification of the assortment by general customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")
LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE
CORE_REL: T_NFPO_CUSTOMER_NEED_TYPE'
AS SELECT
   nfpo_cust_need_type_cd
  ,nfpo_cust_need_type_name
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_CUSTOMER_NEED_TYPE
;