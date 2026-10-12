/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_customer_need_subtype
   generated from Powerdesigner on Mittwoch, 5. März 2025 11:56:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_customer_need_subtype (
nfpo_cust_need_subtype_cd STRING(100) NOT NULL
OPTIONS(description='Code to classify the assortment by detailed customer needs.            CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")            LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE.MDM_CUST_NEED_SUBTYPE_CD            CORE_REL.T_NFPO_CUSTOMER_NEED_SUBTYPE.NFPO_CUST_NEED_SUBTYPE_CD'),
nfpo_cust_need_subtype_name STRING(100)
OPTIONS(description='Name of the detailed customer need.            CBX: CNT_CODELIST.NAME (code list "LIDL_CATEGORY_NEEDS")            LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE.MDM_CUST_NEED_SUBTYPE_NAME            CORE_REL.T_NFPO_CUSTOMER_NEED_SUBTYPE.NFPO_CUST_NEED_SUBTYPE_NAME'),
nfpo_cust_need_type_cd STRING(100) NOT NULL
OPTIONS(description='Current code to classify the detailed customer need by general customer needs.            CBX: CMT_CODELIST_BOOK.cust_codelist1 (code list "LIDL_CATEGORY_NEEDS")            LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE.MDM_CUST_NEED_TYPE_CD            CORE_REL: T_NFPO_CUSTOMER_NEED_SUBTYPE.NFPO_CUST_NEED_TYPE_CD'),
nfpo_cust_need_type_name STRING(100)
OPTIONS(description='Name of the general customer need.            CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")            LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE.MDM_CUST_NEED_TYPE_NAME            CORE_REL: T_NFPO_CUSTOMER_NEED_TYPE.NFPO_CUST_NEED_TYPE_NAME'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_cust_need_subtype_cd) NOT ENFORCED
)
OPTIONS(description='Classification of the assortment by detailed customer needs. The detailed customer needs are grouped into general customer needs.             CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")             LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE             CORE_REL: T_NFPO_CUSTOMER_NEED_SUBTYPE');