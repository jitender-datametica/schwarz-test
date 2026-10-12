/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_home_brand_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_home_brand_1 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.MANDANT_ID            CORE_REL: t_kfl_home_brand.kfl_client_id'),
kfl_home_brand_cd STRING(100) NOT NULL
OPTIONS(description='identifier of the home brand_1 of Kaufland in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.EIGENMARKE_ID            CORE_REL: t_kfl_home_brand.kfl_home_brand_cd'),
kfl_home_brand_name STRING(160)
OPTIONS(description='German name of the home brand_1 of Kaufland in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.EIGENMARKE_BEZ            CORE_REL: t_kfl_home_brand.kfl_home_brand_name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_home_brand_cd) NOT ENFORCED
)
OPTIONS(description='Kaufland home brand_1 (German names only)             KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_EIGENMARKE_1             CORE_REL: T_KFL_HOME_BRAND_1');