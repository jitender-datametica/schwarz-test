/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_client_country
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_KFL_CLIENT_COUNTRY DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.land.MANDANT_ID
            CORE_REL: t_kfl_client_country.kfl_client_id',
   kfl_country_cd                      VARCHAR(100)     NOT NULL COMMENT 'ISO code of the country of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.land.LAND_ID
            CORE_REL: t_kfl_client_country.kfl_country_cd',
   kfl_country_name                    VARCHAR(100)     COMMENT 'name of the country of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.land.LAND_BEZ
            CORE_REL: t_kfl_client_country.kfl_country_name',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_KFL_CLIENT_COUNTRY PRIMARY KEY (kfl_client_id, kfl_country_cd) NOT ENFORCED 
)  COMMENT = 'Kaufland country list (for every single Kaufland client)
             KFL: DBP_DATA.LAND
             CORE_REL: T_KFL_CLIENT_COUNTRY';

