/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_brand_type_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_BRAND_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_brand_type_cd                  VARCHAR(100)     NOT NULL COMMENT 'brand_1 type code for home brands of Lidl or Kaufland and brands of certain suppliers
            LDL: P_LEW_CORE.T_REF_BRAND_TYPE.BRAND_TYPE_CD
            CORE_REL: t_nfpo_brand_type.nfpo_brand_type_cd',
   nfpo_brand_type_name                VARCHAR(100)     NOT NULL COMMENT 'brand_1 type name
            LDL: P_LEW_CORE.T_REF_BRAND_TYPE.BRAND_TYPE
            CORE_REL: t_nfpo_brand_type.nfpo_brand_type_name',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_BRAND_TYPE PRIMARY KEY (nfpo_brand_type_cd) NOT ENFORCED 
)  COMMENT = 'Brand_1 type used by NFPO.
             Static data: M: Marke, EM: Eigenmarke
             LDL: P_LEW_CORE.T_REF_BRAND_TYPE_1
             CORE_REL: T_NFPO_BRAND_TYPE_1';

