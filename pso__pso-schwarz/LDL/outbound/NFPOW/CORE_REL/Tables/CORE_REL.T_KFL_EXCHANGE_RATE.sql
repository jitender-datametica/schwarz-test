/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_exchange_rate
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_exchange_rate (
kfl_exchange_rate_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the exchange rate type in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.kurs.KURSTYP_ID'),
src_curr_cd STRING(3) NOT NULL
OPTIONS(description='currency code of the source currency in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.kurs.VON_WRG_ID'),
tgt_curr_cd STRING(3) NOT NULL
OPTIONS(description='currency code of the target currency in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.kurs.NACH_WRG_ID'),
kfl_exchange_rate BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='exchange rate in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.kurs.UMRECHNUNGSKURS'),
active_from_dt DATE NOT NULL
OPTIONS(description='begin date of the validity period of the exchange rate            KFL: KFL_PRODUCTION.DBP_DATA.kurs.DAT_VON'),
active_to_dt DATE NOT NULL
OPTIONS(description='end date of the validity period of the exchange rate            KFL: KFL_PRODUCTION.DBP_DATA.kurs.DAT_BIS'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_exchange_rate_type_id, src_curr_cd, active_from_dt) NOT ENFORCED
) OPTIONS(description='Kaufland exchange rate             KFL: KFL_PRODUCTION.DBP_DATA.KURS');