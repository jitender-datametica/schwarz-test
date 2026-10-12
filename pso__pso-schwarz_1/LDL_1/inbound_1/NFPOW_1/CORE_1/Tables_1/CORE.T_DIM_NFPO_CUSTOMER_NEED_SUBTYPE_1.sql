/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_customer_need_subtype_1
   generated from Powerdesigner on Mittwoch, 5. März 2025 11:56:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_CUSTOMER_NEED_SUBTYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_cust_need_subtype_cd           VARCHAR(100)     NOT NULL COMMENT 'Code to classify the assortment by detailed customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")
            LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE.MDM_CUST_NEED_SUBTYPE_CD
            CORE_REL.T_NFPO_CUSTOMER_NEED_SUBTYPE.NFPO_CUST_NEED_SUBTYPE_CD',
   nfpo_cust_need_subtype_name         VARCHAR(100)     COMMENT 'Name of the detailed customer need.
            CBX: CNT_CODELIST.NAME (code list "LIDL_CATEGORY_NEEDS")
            LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE.MDM_CUST_NEED_SUBTYPE_NAME
            CORE_REL.T_NFPO_CUSTOMER_NEED_SUBTYPE.NFPO_CUST_NEED_SUBTYPE_NAME',
   nfpo_cust_need_type_cd              VARCHAR(100)     NOT NULL COMMENT 'Current code to classify the detailed customer need by general customer needs.
            CBX: CMT_CODELIST_BOOK.cust_codelist1 (code list "LIDL_CATEGORY_NEEDS")
            LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE.MDM_CUST_NEED_TYPE_CD
            CORE_REL: T_NFPO_CUSTOMER_NEED_SUBTYPE.NFPO_CUST_NEED_TYPE_CD',
   nfpo_cust_need_type_name            VARCHAR(100)     COMMENT 'Name of the general customer need.
            CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")
            LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE.MDM_CUST_NEED_TYPE_NAME
            CORE_REL: T_NFPO_CUSTOMER_NEED_TYPE.NFPO_CUST_NEED_TYPE_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_CUSTOMER_NEED_SUBTYPE PRIMARY KEY (nfpo_cust_need_subtype_cd) NOT ENFORCED 
)  COMMENT = 'Classification of the assortment by detailed customer needs. The detailed customer needs are grouped into general customer needs.
             CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")
             LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE_1
             CORE_REL: T_NFPO_CUSTOMER_NEED_SUBTYPE_1';
