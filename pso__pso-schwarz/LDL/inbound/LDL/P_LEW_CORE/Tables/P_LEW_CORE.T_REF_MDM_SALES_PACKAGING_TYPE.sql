/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_sales_packaging_type
   generated from Powerdesigner on Dienstag, 25. November 2025 15:31:57
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE (
   mdm_sales_packaging_type_cd         VARCHAR(100)     NOT NULL COMMENT 'Code of the sales packaging types.
            CBX: CNT_CODELIST.CODE (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")',
   mdm_sales_packaging_type_name       VARCHAR(200)     COMMENT 'Name of the sales packaging types.
            CBX: CNT_CODELIST.NAME (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_MDM_SALES_PACKAGING_TYPE PRIMARY KEY (mdm_sales_packaging_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO list of sales packaging types.
             CBX: CNT_CODELIST (code list "LDL_RETAIL_PACKAGING" and "LIDL_RETAILPACK_KL")';
