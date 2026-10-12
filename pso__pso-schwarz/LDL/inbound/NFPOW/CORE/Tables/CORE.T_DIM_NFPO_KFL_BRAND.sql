/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_kfl_brand
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_KFL_BRAND DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_kfl_brand_sid                  NUMBER(38,0)     NOT NULL COMMENT 'surrogate key for Kaufland home brands used in CBX
            CBX: CNT_ITEM.LDL_BRAND_KL
            LDL: P_LEW_CORE.T_KFL_BRAND.KFL_BRAND_SID
            CORE_REL: t_nfpo_kfl_brand.nfpo_kfl_brand_sid',
   nfpo_kfl_brand_name                 VARCHAR(100)     COMMENT 'name Kaufland home brands used in CBX
            CBX: CNT_ITEM.LDL_BRAND_KL
            LDL: P_LEW_CORE.T_KFL_BRAND.KFL_BRAND_NAME
            CORE_REL: t_nfpo_kfl_brand.nfpo_kfl_brand_name',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_KFL_BRAND PRIMARY KEY (nfpo_kfl_brand_sid) NOT ENFORCED 
)  COMMENT = 'Home brands of Kaufland as used in NFPO.
             CBX: CNT_ITEM
             LDL: P_LEW_CORE.T_KFL_BRAND
             CORE_REL: T_NFPO_KFL_BRAND';

