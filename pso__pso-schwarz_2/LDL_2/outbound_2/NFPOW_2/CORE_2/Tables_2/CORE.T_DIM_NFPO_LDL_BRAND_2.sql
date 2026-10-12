/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_ldl_brand_2
   generated from Powerdesigner on Donnerstag, 17. August 2023 15:49:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_ldl_brand_2 (
nfpo_ldl_brand_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key for brands used in CBX for sales_2 in the Lidl line of business            CBX: CNT_ITEM.LDL_BRAND            LDL: P_LEW_CORE.T_BRAND.BRAND_SID            CORE_REL: t_nfpo_ldl_brand.nfpo_ldl_brand_sid'),
nfpo_ldl_brand_nr STRING(100)
OPTIONS(description='Natural key in the source system for Lidl brands.            CBX: CNT_ITEM.LDL_BRAND            LDL: P_LEW_CORE.T_BRAND.SRC_BRAND_CD            NFPOW: CORE_REL.T_NFPO_LDL_BRAND.NFPO_LDL_BRAND_NR'),
nfpo_ldl_brand_name STRING(100)
OPTIONS(description='name of brands used in CBX for sales_2 in the Lidl line of business            CBX: CNT_CODELIST.NAME for CNT_CODELIST_BOOK.NAME="LIDL_BRAND"            LDL: P_LEW_CORE.T_BRAND.BRAND_SID            CORE_REL: t_nfpo_ldl_brand.nfpo_ldl_brand_name'),
nfpo_brand_type_cd STRING(100) NOT NULL
OPTIONS(description='brand_2 type code for home brands of Lidl or Kaufland and brands of certain suppliers            LDL: P_LEW_CORE.T_REF_BRAND_TYPE.BRAND_TYPE_CD            CORE_REL: t_nfpo_ldl_brand.nfpo_brand_type_cd'),
nfpo_brand_type_name STRING(100)
OPTIONS(description='brand_2 type name            LDL: P_LEW_CORE.T_REF_BRAND_TYPE.BRAND_TYPE            CORE_REL: t_nfpo_brand_type.nfpo_brand_type_name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_ldl_brand_sid) NOT ENFORCED
)
OPTIONS(description='Brands of Lidl as used in NFPO.             CBX: CNT_ITEM_2             LDL: P_LEW_CORE.T_BRAND_2             CORE_REL: T_NFPO_LDL_BRAND_2');