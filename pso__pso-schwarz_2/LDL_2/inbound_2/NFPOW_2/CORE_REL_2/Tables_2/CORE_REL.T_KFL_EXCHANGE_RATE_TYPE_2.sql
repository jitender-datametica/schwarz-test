/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_exchange_rate_type_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_EXCHANGE_RATE_TYPE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_exchange_rate_type_id           NUMBER(38,0)     NOT NULL COMMENT 'identifier of the exchange rate type in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.KURSTYP_SPR_ZU.KURSTYP_ID',
   kfl_exchange_rate_type_name         VARCHAR(100)     NOT NULL COMMENT 'German name of the exchange rate type in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.KURSTYP_SPR_ZU.KURSTYP_BEZ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_EXCHANGE_RATE_TYPE PRIMARY KEY (kfl_exchange_rate_type_id) NOT ENFORCED 
)  COMMENT = 'Kaufland exchange rate type
             KFL: KFL_PRODUCTION.DBP_DATA.KURSTYP_SPR_ZU_2';

