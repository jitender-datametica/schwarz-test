/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_season_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_season_1 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.saison_spr_zu.mandant_id            CORE_REL: t_kfl_season.kfl_client_id'),
kfl_season_nr STRING(100) NOT NULL
OPTIONS(description='identifier of the season in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.saison_spr_zu.SAISON_ID            CORE_REL: t_kfl_season.kfl_season_nr'),
kfl_season_name STRING(100)
OPTIONS(description='German name of the season in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.saison_spr_zu.SAISON_BEZ            CORE_REL: t_kfl_season.kfl_season_name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_season_nr) NOT ENFORCED
)
OPTIONS(description='Kaufland season (German names only)             KFL: DBP_DATA.SAISON_SPR_ZU_1             CORE_REL: T_KFL_SEASON_1');