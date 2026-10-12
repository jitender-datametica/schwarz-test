/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_kfl_brand_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_kfl_brand_1 (
nfpo_kfl_brand_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key for Kaufland home brands used in CBX            CBX: CNT_ITEM.LDL_BRAND_KL            LDL: P_LEW_CORE.T_KFL_BRAND.KFL_BRAND_SID            CORE_REL: t_nfpo_kfl_brand.nfpo_kfl_brand_sid'),
nfpo_kfl_brand_name STRING(100)
OPTIONS(description='name Kaufland home brands used in CBX            CBX: CNT_ITEM.LDL_BRAND_KL            LDL: P_LEW_CORE.T_KFL_BRAND.KFL_BRAND_NAME            CORE_REL: t_nfpo_kfl_brand.nfpo_kfl_brand_name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_kfl_brand_sid) NOT ENFORCED
)
OPTIONS(description='Home brands of Kaufland as used in NFPO.             CBX: CNT_ITEM_1             LDL: P_LEW_CORE.T_KFL_BRAND_1             CORE_REL: T_NFPO_KFL_BRAND_1');