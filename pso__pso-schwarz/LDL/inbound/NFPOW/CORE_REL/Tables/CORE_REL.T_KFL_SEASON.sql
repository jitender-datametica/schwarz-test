/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_season
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_SEASON DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.saison_spr_zu.mandant_id',
   kfl_season_nr                       VARCHAR(100)     NOT NULL COMMENT 'identifier of the season in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.saison_spr_zu.SAISON_ID',
   kfl_season_name                     VARCHAR(100)     COMMENT 'German name of the season in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.saison_spr_zu.SAISON_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_SEASON PRIMARY KEY (kfl_client_id, kfl_season_nr) NOT ENFORCED 
)  COMMENT = 'Kaufland season (German names only)
             KFL: DBP_DATA.SAISON_SPR_ZU';

