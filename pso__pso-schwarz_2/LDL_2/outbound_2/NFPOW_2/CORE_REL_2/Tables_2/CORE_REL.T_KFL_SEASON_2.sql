/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_season_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_season_2 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_2) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.saison_spr_zu.mandant_id'),
kfl_season_nr STRING(100) NOT NULL
OPTIONS(description='identifier of the season in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.saison_spr_zu.SAISON_ID'),
kfl_season_name STRING(100)
OPTIONS(description='German name of the season in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.saison_spr_zu.SAISON_BEZ'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_season_nr) NOT ENFORCED
) OPTIONS(description='Kaufland season (German names only)             KFL: DBP_DATA.SAISON_SPR_ZU_2');