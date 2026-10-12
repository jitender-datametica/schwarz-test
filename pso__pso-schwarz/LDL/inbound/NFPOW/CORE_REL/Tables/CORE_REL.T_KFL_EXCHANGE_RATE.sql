/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_exchange_rate
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_EXCHANGE_RATE DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_exchange_rate_type_id           NUMBER(38,0)     NOT NULL COMMENT 'identifier of the exchange rate type in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.kurs.KURSTYP_ID',
   src_curr_cd                         VARCHAR(3)       NOT NULL COMMENT 'currency code of the source currency in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.kurs.VON_WRG_ID',
   tgt_curr_cd                         VARCHAR(3)       NOT NULL COMMENT 'currency code of the target currency in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.kurs.NACH_WRG_ID',
   kfl_exchange_rate                   NUMBER(38,5)     NOT NULL COMMENT 'exchange rate in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.kurs.UMRECHNUNGSKURS',
   active_from_dt                      DATE             NOT NULL COMMENT 'begin date of the validity period of the exchange rate
            KFL: KFL_PRODUCTION.DBP_DATA.kurs.DAT_VON',
   active_to_dt                        DATE             NOT NULL COMMENT 'end date of the validity period of the exchange rate
            KFL: KFL_PRODUCTION.DBP_DATA.kurs.DAT_BIS',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_EXCHANGE_RATE PRIMARY KEY (kfl_exchange_rate_type_id, src_curr_cd, active_from_dt) NOT ENFORCED 
)  COMMENT = 'Kaufland exchange rate
             KFL: KFL_PRODUCTION.DBP_DATA.KURS';

