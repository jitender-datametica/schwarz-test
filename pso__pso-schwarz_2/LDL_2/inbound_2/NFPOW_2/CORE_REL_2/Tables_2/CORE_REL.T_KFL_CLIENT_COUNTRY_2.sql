/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_client_country_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_CLIENT_COUNTRY_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.land.MANDANT_ID',
   kfl_country_cd                      VARCHAR(100)     NOT NULL COMMENT 'ISO code of the country_2 of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.land.LAND_ID',
   kfl_country_name                    VARCHAR(100)     COMMENT 'name of the country_2 of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.land.LAND_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_CLIENT_COUNTRY PRIMARY KEY (kfl_client_id, kfl_country_cd) NOT ENFORCED 
)  COMMENT = 'Kaufland country_2 list (for every single Kaufland client)
             KFL: DBP_DATA.LAND_2';

