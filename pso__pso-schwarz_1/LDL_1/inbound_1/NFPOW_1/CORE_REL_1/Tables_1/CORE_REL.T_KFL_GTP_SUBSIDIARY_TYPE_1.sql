/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_gtp_subsidiary_type_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_GTP_SUBSIDIARY_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_gtp_subsidiary_type_id          NUMBER(38,0)     NOT NULL COMMENT 'identifier of the subsidiary type (Nebenstelle) of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.nb.NB_ID',
   kfl_gtp_subsidiary_type_name        VARCHAR(100)     COMMENT 'name of the subsidiary type (Nebenstelle) of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.nb.NB_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_GTP_SUBSIDIARY_TYPE PRIMARY KEY (kfl_gtp_subsidiary_type_id) NOT ENFORCED 
)  COMMENT = 'Kaufland subsidiary type (Nebenstellentyp)
             KFL: DBP_DATA.NB_1';

