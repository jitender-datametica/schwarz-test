/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_currency
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_currency (
curr_cd STRING(3) NOT NULL
OPTIONS(description='currency code in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wrg.WRG_ID'),
kfl_curr_name STRING(160)
OPTIONS(description='name of the currency in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wrg.WRG_BEZ'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (curr_cd) NOT ENFORCED
) OPTIONS(description='Kaufland currency             KFL: KFL_PRODUCTION.DBP_DATA.WRG');