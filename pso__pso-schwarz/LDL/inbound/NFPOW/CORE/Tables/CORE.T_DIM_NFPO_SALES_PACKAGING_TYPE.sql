/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_sales_packaging_type
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:02
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_SALES_PACKAGING_TYPE DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_sales_packaging_type_cd        VARCHAR(100)     NOT NULL COMMENT 'Code of the sales packaging types.
            CBX: CNT_CODELIST.CODE (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")
            LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE.MDM_SALES_PACKAGING_TYPE_CD
            CORE_REL: T_NFPO_SALES_PACKAGING_TYPE.NFPO_SALES_PACKAGING_TYPE_CD',
   nfpo_sales_packaging_type_name      VARCHAR(200)     COMMENT 'Name of the sales packaging types.
            CBX: CNT_CODELIST.NAME (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")
            LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE.MDM_SALES_PACKAGING_TYPE_NAME
            CORE_REL: T_NFPO_SALES_PACKAGING_TYPE.NFPO_SALES_PACKAGING_TYPE_NAME',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_SALES_PACKAGING_TYPE PRIMARY KEY (nfpo_sales_packaging_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO list of sales packaging types.
             CBX: CNT_CODELIST (code list "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")
             LDL: P_LEW_CORE.T_REF_MDM_SALES_PACKAGING_TYPE
             CORE_REL: T_NFPO_SALES_PACKAGING_TYPE';

