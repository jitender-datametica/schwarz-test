/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_currency
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_KFL_CURRENCY DATA_RETENTION_TIME_IN_DAYS = 2 (
   curr_cd                             VARCHAR(3)       NOT NULL COMMENT 'currency code in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wrg.WRG_ID
            CORE_REL: t_kfl_currency.curr_cd',
   kfl_curr_name                       VARCHAR(160)     COMMENT 'name of the currency in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wrg.WRG_BEZ
            CORE_REL: t_kfl_currency.kfl_curr_name',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_KFL_CURRENCY PRIMARY KEY (curr_cd) NOT ENFORCED 
)  COMMENT = 'Kaufland currency
             KFL: KFL_PRODUCTION.DBP_DATA.WRG
             CORE_REL: T_KFL_CURRENCY';

