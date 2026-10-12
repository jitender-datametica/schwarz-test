/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_currency
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_CURRENCY DATA_RETENTION_TIME_IN_DAYS = 2 (
   curr_cd                             VARCHAR(3)       NOT NULL COMMENT 'currency code in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wrg.WRG_ID',
   kfl_curr_name                       VARCHAR(160)     COMMENT 'name of the currency in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wrg.WRG_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_CURRENCY PRIMARY KEY (curr_cd) NOT ENFORCED 
)  COMMENT = 'Kaufland currency
             KFL: KFL_PRODUCTION.DBP_DATA.WRG';

