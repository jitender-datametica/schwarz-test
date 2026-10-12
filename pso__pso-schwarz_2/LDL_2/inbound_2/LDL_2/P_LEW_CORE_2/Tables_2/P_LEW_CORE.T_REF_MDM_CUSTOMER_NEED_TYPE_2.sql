/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_customer_need_type_2
   generated from Powerdesigner on Donnerstag, 12. September 2024 19:21:42
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_TYPE_2 (
   mdm_cust_need_type_cd               VARCHAR(100)     NOT NULL COMMENT 'Code to classify the assortment by general customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")',
   mdm_cust_need_type_name             VARCHAR(100)     COMMENT 'Name of the general customer need.
            CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_CUSTOMER_NEED_TYPE PRIMARY KEY (mdm_cust_need_type_cd) NOT ENFORCED 
)  COMMENT = 'Classification of the assortment by general customer needs.
             CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")';
