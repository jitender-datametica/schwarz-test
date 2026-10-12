/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_brand_type_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_brand_type_2 (
nfpo_brand_type_cd STRING(100) NOT NULL
OPTIONS(description='brand_2 type code for home brands of Lidl or Kaufland and brands of certain suppliers            LDL: P_LEW_CORE.T_REF_BRAND_TYPE.BRAND_TYPE_CD            CORE_REL: t_nfpo_brand_type.nfpo_brand_type_cd'),
nfpo_brand_type_name STRING(100) NOT NULL
OPTIONS(description='brand_2 type name            LDL: P_LEW_CORE.T_REF_BRAND_TYPE.BRAND_TYPE            CORE_REL: t_nfpo_brand_type.nfpo_brand_type_name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_brand_type_cd) NOT ENFORCED
)
OPTIONS(description='Brand_2 type used by NFPO.             Static data: M: Marke, EM: Eigenmarke             LDL: P_LEW_CORE.T_REF_BRAND_TYPE_2             CORE_REL: T_NFPO_BRAND_TYPE_2');