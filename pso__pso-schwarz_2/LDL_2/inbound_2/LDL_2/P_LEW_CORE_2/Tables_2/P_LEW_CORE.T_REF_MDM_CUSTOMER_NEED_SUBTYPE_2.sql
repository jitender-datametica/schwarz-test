/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_customer_need_subtype_2
   generated from Powerdesigner on Mittwoch, 5. März 2025 10:18:20
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_CUSTOMER_NEED_SUBTYPE_2 (
   mdm_cust_need_subtype_cd            VARCHAR(100)     NOT NULL COMMENT 'Code to classify the assortment by detailed customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")',
   mdm_cust_need_type_cd               VARCHAR(100)     COMMENT 'Current code to classify the detailed customer need by general customer needs.
            CBX: CMT_CODELIST_BOOK.cust_codelist1 (code list "LIDL_CATEGORY_NEEDS")',
   mdm_cust_need_subtype_name          VARCHAR(100)     COMMENT 'Name of the detailed customer need.
            CBX: CNT_CODELIST.NAME (code list "LIDL_CATEGORY_NEEDS")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_CUSTOMER_NEED_SUBTYPE PRIMARY KEY (mdm_cust_need_subtype_cd) NOT ENFORCED 
)  COMMENT = 'Classification of the assortment by detailed customer needs. The detailed customer needs are grouped into general customer needs.
             CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")';
