/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_ldl_brand_1
   generated from Powerdesigner on Donnerstag, 17. August 2023 15:49:18
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_LDL_BRAND_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_ldl_brand_sid                  NUMBER(38,0)     NOT NULL COMMENT 'surrogate key for brands used in CBX for sales_1 in the Lidl line of business
            CBX: CNT_ITEM.LDL_BRAND
            LDL: P_LEW_CORE.T_BRAND.BRAND_SID
            CORE_REL: t_nfpo_ldl_brand.nfpo_ldl_brand_sid',
   nfpo_ldl_brand_nr                   VARCHAR(100)     COMMENT 'Natural key in the source system for Lidl brands.
            CBX: CNT_ITEM.LDL_BRAND
            LDL: P_LEW_CORE.T_BRAND.SRC_BRAND_CD
            NFPOW: CORE_REL.T_NFPO_LDL_BRAND.NFPO_LDL_BRAND_NR',
   nfpo_ldl_brand_name                 VARCHAR(100)     COMMENT 'name of brands used in CBX for sales_1 in the Lidl line of business
            CBX: CNT_CODELIST.NAME for CNT_CODELIST_BOOK.NAME="LIDL_BRAND"
            LDL: P_LEW_CORE.T_BRAND.BRAND_SID
            CORE_REL: t_nfpo_ldl_brand.nfpo_ldl_brand_name',
   nfpo_brand_type_cd                  VARCHAR(100)     NOT NULL COMMENT 'brand_1 type code for home brands of Lidl or Kaufland and brands of certain suppliers
            LDL: P_LEW_CORE.T_REF_BRAND_TYPE.BRAND_TYPE_CD
            CORE_REL: t_nfpo_ldl_brand.nfpo_brand_type_cd',
   nfpo_brand_type_name                VARCHAR(100)     COMMENT 'brand_1 type name
            LDL: P_LEW_CORE.T_REF_BRAND_TYPE.BRAND_TYPE
            CORE_REL: t_nfpo_brand_type.nfpo_brand_type_name',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_LDL_BRAND PRIMARY KEY (nfpo_ldl_brand_sid) NOT ENFORCED 
)  COMMENT = 'Brands of Lidl as used in NFPO.
             CBX: CNT_ITEM_1
             LDL: P_LEW_CORE.T_BRAND_1
             CORE_REL: T_NFPO_LDL_BRAND_1';
