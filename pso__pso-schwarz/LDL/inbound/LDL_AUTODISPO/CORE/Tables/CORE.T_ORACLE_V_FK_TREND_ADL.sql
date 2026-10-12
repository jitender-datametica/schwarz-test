--==============================================================
-- Table: t_oracle_v_fk_trend_adl
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_trend_adl
   generated from Powerdesigner on Dienstag, 22. Oktober 2024 13:11:21
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_ORACLE_V_FK_TREND_ADL (
   COUNTRY                             VARCHAR(2)      NOT NULL COMMENT 'Country; sourcefield: COUNTRY',
   WH_NR                               NUMBER(38,0)    NOT NULL COMMENT 'Number of a Warehouse; sourcefield: TR_WH_NR',
   ITEM_NR                             VARCHAR(20)     NOT NULL COMMENT 'Global item number, tr_item_nr is equal to other xx_item_nr from other tables; sourcefield: tr_item_nr.',
   ITEM_PACKAGECAPACITY                NUMBER(38,3)    NOT NULL COMMENT 'Amount of salesitems that can be placed in one case. Sourcefield: TR_ITEM_PACKAGECAPACITY',
   TREND_ID                            NUMBER(38,0)    NOT NULL COMMENT 'Trend_id to identify a given trend on item level (in ADF system ist storetrend_id). Can exist multiple times on wh and item level but just once for a trend_type. Sourcefield: TR_TREND_ID',
   TREND_TYPE                          NUMBER(38,0)    NOT NULL COMMENT 'Trend_type = 1: Percentage value ;original trend value x trend value; final value used for calculation, Trend_type = 2: Fixed value; replaces the original trend value. Sourcefiled: TR_TREND_TYPE',
   ACTIVE_FG                           NUMBER(38,0)    COMMENT 'Flag if a trend is active or not. Active=1 inactive=0; sourcefield: TR_ACTIVE',
   TREND_VALUE                         NUMBER(38,3)    COMMENT 'If Trend_type = 1 tr_value is used in frontend to calculate trend (original forecast x tr_value). If Trend_type = 2 tr_value is taken for frontend as delivered. Sourcefield: TR_VALUE',
   TREND_START_DATE                    DATE            NOT NULL COMMENT 'Start date of a trend set in ADL system; sourcefield: TR_START_DATE',
   TREND_END_DATE                      DATE            COMMENT 'End date of a trend set in ADL system; sourcefield: TR_END_DATE',
   MOD_DATE                            TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of creation of entries inside source system table. Sourcefield; mod_date',
   SOURCE_EXTRACTION_TMSP              TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.',
   SNFLK_INSERT_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake loading process.',
   SNFLK_UPDATE_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake table update process.',   
   CONSTRAINT PK_T_ORACLE_V_FK_TREND_ADL PRIMARY KEY (country, wh_nr, item_nr, item_packagecapacity, trend_id) NOT ENFORCED 
)  COMMENT = ' Table contains information about validity of ADL trends (forecast and manual change by user) on item level; ADL sourcetable V_FK_TREND_ADL';
