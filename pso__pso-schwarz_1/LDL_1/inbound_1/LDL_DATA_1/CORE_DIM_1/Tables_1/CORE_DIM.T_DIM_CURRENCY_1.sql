-- =====================================
-- T_DIM_CURRENCY_1
-- =====================================
CREATE TABLE core_dim.T_DIM_CURRENCY_1 (
   curr_cd                             VARCHAR(3)      NOT NULL COMMENT 'The code identifying the currency according to ISO-4217.',
   curr_name                           VARCHAR(100)    NOT NULL COMMENT 'The name for the currency in group language, i.e. in German.',
   curr_name_de                        VARCHAR(100)    COMMENT 'The name for the currency in german.',
   curr_name_en                        VARCHAR(100)    COMMENT 'The name for the currency in english.',
   used_in_stores_fg                   BOOLEAN         NOT NULL COMMENT 'An indicator showing, if this currency is used in a country_1 where the Schwarz Group operates any stores.',
   euro_exch_rate                      NUMBER(38, 6)   COMMENT 'The current exchange rate of this currency to the group currency (Euro). (These exchange rates are fixed once per business year.)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_CURRENCY PRIMARY KEY (curr_cd) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the currency codes according to ISO-4217. (E.g. EUR, USD, GBP, ...)';
