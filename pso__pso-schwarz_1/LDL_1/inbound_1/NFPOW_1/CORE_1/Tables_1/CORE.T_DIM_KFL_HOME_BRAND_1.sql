/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_home_brand_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_KFL_HOME_BRAND_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.MANDANT_ID
            CORE_REL: t_kfl_home_brand.kfl_client_id',
   kfl_home_brand_cd                   VARCHAR(100)     NOT NULL COMMENT 'identifier of the home brand_1 of Kaufland in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.EIGENMARKE_ID
            CORE_REL: t_kfl_home_brand.kfl_home_brand_cd',
   kfl_home_brand_name                 VARCHAR(160)     COMMENT 'German name of the home brand_1 of Kaufland in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.EIGENMARKE_BEZ
            CORE_REL: t_kfl_home_brand.kfl_home_brand_name',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_KFL_HOME_BRAND PRIMARY KEY (kfl_client_id, kfl_home_brand_cd) NOT ENFORCED 
)  COMMENT = 'Kaufland home brand_1 (German names only)
             KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_EIGENMARKE_1
             CORE_REL: T_KFL_HOME_BRAND_1';

