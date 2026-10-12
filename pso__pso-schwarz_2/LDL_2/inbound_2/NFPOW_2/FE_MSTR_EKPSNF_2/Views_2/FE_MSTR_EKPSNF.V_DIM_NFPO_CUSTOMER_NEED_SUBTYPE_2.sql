CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_CUSTOMER_NEED_SUBTYPE_2 (
   nfpo_cust_need_subtype_cd                COMMENT 'Code to classify the assortment by detailed customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")
LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE.MDM_CUST_NEED_SUBTYPE_CD
CORE_REL.T_NFPO_CUSTOMER_NEED_SUBTYPE.NFPO_CUST_NEED_SUBTYPE_CD'
  ,nfpo_cust_need_subtype_name              COMMENT 'Name of the detailed customer need.
CBX: CNT_CODELIST.NAME (code list "LIDL_CATEGORY_NEEDS")
LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE.MDM_CUST_NEED_SUBTYPE_NAME
CORE_REL.T_NFPO_CUSTOMER_NEED_SUBTYPE.NFPO_CUST_NEED_SUBTYPE_NAME'
  ,nfpo_cust_need_type_cd                   COMMENT 'Current code to classify the detailed customer need by general customer needs.
CBX: CMT_CODELIST_BOOK.cust_codelist1 (code list "LIDL_CATEGORY_NEEDS")
LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE.MDM_CUST_NEED_TYPE_CD
CORE_REL: T_NFPO_CUSTOMER_NEED_SUBTYPE.NFPO_CUST_NEED_TYPE_CD'
  ,nfpo_cust_need_type_name                 COMMENT 'Name of the general customer need.
CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")
LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE.MDM_CUST_NEED_TYPE_NAME
CORE_REL: T_NFPO_CUSTOMER_NEED_TYPE.NFPO_CUST_NEED_TYPE_NAME'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'Classification of the assortment by detailed customer needs. The detailed customer needs are grouped into general customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")
LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE_2
CORE_REL: T_NFPO_CUSTOMER_NEED_SUBTYPE_2'
AS SELECT
   nfpo_cust_need_subtype_cd
  ,nfpo_cust_need_subtype_name
  ,nfpo_cust_need_type_cd
  ,nfpo_cust_need_type_name
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_CUSTOMER_NEED_SUBTYPE_2
;