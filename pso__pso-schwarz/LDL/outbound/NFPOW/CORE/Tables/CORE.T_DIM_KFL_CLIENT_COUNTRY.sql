/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_client_country
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_client_country (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.land.MANDANT_ID            CORE_REL: t_kfl_client_country.kfl_client_id'),
kfl_country_cd STRING(100) NOT NULL
OPTIONS(description='ISO code of the country of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.land.LAND_ID            CORE_REL: t_kfl_client_country.kfl_country_cd'),
kfl_country_name STRING(100)
OPTIONS(description='name of the country of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.land.LAND_BEZ            CORE_REL: t_kfl_client_country.kfl_country_name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_country_cd) NOT ENFORCED
)
OPTIONS(description='Kaufland country list (for every single Kaufland client)             KFL: DBP_DATA.LAND             CORE_REL: T_KFL_CLIENT_COUNTRY');