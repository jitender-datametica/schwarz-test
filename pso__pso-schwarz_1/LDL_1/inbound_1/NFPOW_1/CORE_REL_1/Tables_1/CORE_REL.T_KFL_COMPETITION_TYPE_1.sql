/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_competition_type_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_COMPETITION_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_ALDI.MANDANT_ID',
   kfl_competition_type_id             NUMBER(38,0)     NOT NULL COMMENT 'identifier of the type of the competition in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_ALDI.ALDI_ID',
   kfl_competition_type_txt            VARCHAR(1000)    COMMENT 'name of the type of the competition in the Kaufland DWH, for example ''Aldi Süd'' or ''Aldi komplett + Lidl''
            KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_ALDI.ALDI_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_COMPETITION_TYPE PRIMARY KEY (kfl_client_id, kfl_competition_type_id) NOT ENFORCED 
)  COMMENT = 'Kaufland type of competition, for example "Aldi Süd" or "Aldi komplett + Lidl"
             KFL: DBP_DATA.ARTKZ_ALDI_1';

