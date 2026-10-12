--==============================================================
-- Table: t_oracle_v_fk_trend_adl_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_trend_adl_1
   generated from Powerdesigner on Dienstag, 22. Oktober 2024 13:11:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_trend_adl_1 (
country_1 STRING(2) NOT NULL OPTIONS(description='Country_1; sourcefield: COUNTRY_1'),
wh_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of a Warehouse; sourcefield: TR_WH_NR'),
item_nr STRING(20) NOT NULL
OPTIONS(description='Global item_1 number, tr_item_nr is equal to other xx_item_nr from other tables; sourcefield: tr_item_nr.'),
item_packagecapacity BIGNUMERIC(38,3) NOT NULL
OPTIONS(description='Amount of salesitems that can be placed in one case. Sourcefield: TR_ITEM_PACKAGECAPACITY'),
trend_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Trend_id to identify a given trend on item_1 level (in ADF system ist storetrend_id). Can exist multiple times on wh and item_1 level but just once for a trend_type. Sourcefield: TR_TREND_ID'),
trend_type BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Trend_type = 1: Percentage value ;original trend value x trend value; final value used for calculation, Trend_type = 2: Fixed value; replaces the original trend value. Sourcefiled: TR_TREND_TYPE'),
active_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag if a trend is active or not. Active=1 inactive=0; sourcefield: TR_ACTIVE'),
trend_value BIGNUMERIC(38,3)
OPTIONS(description='If Trend_type = 1 tr_value is used in frontend to calculate trend (original forecast x tr_value). If Trend_type = 2 tr_value is taken for frontend as delivered. Sourcefield: TR_VALUE'),
trend_start_date DATE NOT NULL
OPTIONS(description='Start date of a trend set in ADL system; sourcefield: TR_START_DATE'),
trend_end_date DATE OPTIONS(description='End date of a trend set in ADL system; sourcefield: TR_END_DATE'),
mod_date TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of creation of entries inside source system table. Sourcefield; mod_date'),
source_extraction_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.'),
snflk_insert_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake loading process.'),
snflk_update_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake table update process.'),
PRIMARY KEY (country_1, wh_nr, item_nr, item_packagecapacity, trend_id) NOT ENFORCED
)
OPTIONS(description=' Table contains information about validity_1 of ADL trends (forecast and manual change by user) on item_1 level; ADL sourcetable V_FK_TREND_ADL');