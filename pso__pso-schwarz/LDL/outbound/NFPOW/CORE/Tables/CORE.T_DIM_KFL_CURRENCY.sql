/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_currency
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_currency (
curr_cd STRING(3) NOT NULL
OPTIONS(description='currency code in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wrg.WRG_ID            CORE_REL: t_kfl_currency.curr_cd'),
kfl_curr_name STRING(160)
OPTIONS(description='name of the currency in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.wrg.WRG_BEZ            CORE_REL: t_kfl_currency.kfl_curr_name'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (curr_cd) NOT ENFORCED
)
OPTIONS(description='Kaufland currency             KFL: KFL_PRODUCTION.DBP_DATA.WRG             CORE_REL: T_KFL_CURRENCY');