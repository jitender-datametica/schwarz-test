/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_exchange_rate_type_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_exchange_rate_type_1 (
kfl_exchange_rate_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the exchange rate type in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.KURSTYP_SPR_ZU.KURSTYP_ID'),
kfl_exchange_rate_type_name STRING(100) NOT NULL
OPTIONS(description='German name of the exchange rate type in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.KURSTYP_SPR_ZU.KURSTYP_BEZ'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_exchange_rate_type_id) NOT ENFORCED
) OPTIONS(description='Kaufland exchange rate type             KFL: KFL_PRODUCTION.DBP_DATA.KURSTYP_SPR_ZU_1');