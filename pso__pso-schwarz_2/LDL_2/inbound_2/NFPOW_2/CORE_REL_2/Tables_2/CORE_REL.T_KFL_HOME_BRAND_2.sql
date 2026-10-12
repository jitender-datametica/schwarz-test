/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_home_brand_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_HOME_BRAND_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_2) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.MANDANT_ID',
   kfl_home_brand_cd                   VARCHAR(100)     NOT NULL COMMENT 'identifier of the home brand_2 of Kaufland in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.EIGENMARKE_ID',
   kfl_home_brand_name                 VARCHAR(160)     COMMENT 'German name of the home brand_2 of Kaufland in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.EIGENMARKE_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_HOME_BRAND PRIMARY KEY (kfl_client_id, kfl_home_brand_cd) NOT ENFORCED 
)  COMMENT = 'Kaufland home brand_2 (German names only)
             KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_EIGENMARKE_2';

