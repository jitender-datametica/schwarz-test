CREATE TABLE CORE.t_dim_exchange_rate_1 (
dwh_valid_from_dt       DATE       NOT NULL COMMENT 'The date when this record became valid.',
dwh_valid_to_dt         DATE       NOT NULL COMMENT 'The date when this record was no longer valid.',
active_from_dt       DATE       NOT NULL COMMENT 'The first date from when this record became valid from a business perspective, i.e. the date from when on this exchange rate was used (inclusively).',
active_to_dt         DATE       NOT NULL COMMENT 'The last date up to when this record was valid from a business perspective, i.e. the date up to when this exchange rate was used (inclusively).',
curr_cd_from         VARCHAR(3)  NOT NULL COMMENT 'The code identifying the currency according to ISO-4217.',
curr_cd_to           VARCHAR(3)  NOT NULL COMMENT 'The code identifying the target currency according to ISO-4217.',
exchange_rate        NUMBER(38,5) COMMENT 'The current exchange rate of this currency to the group currency (Euro). (These exchange rates are fixed once per business year.)',
dwh_created_tmsp     TIMESTAMP_LTZ NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
dwh_updated_tmsp     TIMESTAMP_LTZ NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
CONSTRAINT PK_T_DIM_EXCHANGE_RATE PRIMARY KEY (dwh_valid_from_dt, active_from_dt, curr_cd_from, curr_cd_to) NOT ENFORCED
) COMMENT = 'Currency exchange rates. For a given pair of currencies there might be several exchange rate types. '
;
