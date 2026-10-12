/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_customer_need_type_1
   generated from Powerdesigner on Donnerstag, 12. September 2024 19:33:51
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_CUSTOMER_NEED_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_cust_need_type_cd              VARCHAR(100)     NOT NULL COMMENT 'Code to classify the assortment by general customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")
            LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE.MDM_CUST_NEED_TYPE_CD',
   nfpo_cust_need_type_name            VARCHAR(100)     COMMENT 'Name of the general customer need.
            CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")
            LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE.MDM_CUST_NEED_TYPE_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',  
   CONSTRAINT PK_T_NFPO_CUSTOMER_NEED_TYPE PRIMARY KEY (nfpo_cust_need_type_cd) NOT ENFORCED 
)  COMMENT = 'Classification of the assortment by general customer needs.
             CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")
             LDL: P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE_1';
