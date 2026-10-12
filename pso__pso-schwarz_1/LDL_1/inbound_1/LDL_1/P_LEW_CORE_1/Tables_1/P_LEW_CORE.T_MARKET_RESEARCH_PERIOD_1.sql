/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_period_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_PERIOD_1 (
   market_research_period_sid          NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.',
   market_research_data_provider_name  VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data source is known.',
   market_research_calendar_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the custom calendar_1 is known.',
   market_research_period_name         VARCHAR(100)     NOT NULL COMMENT 'The display name of the time period.',
   market_research_period_type_cd      VARCHAR(100)     NOT NULL COMMENT 'The code identifying the kind of time period.',
   cy                                  NUMBER(38,0)     COMMENT 'The calendar_1 year to which this period is assigned. (Note that periods might span two years, but they are always linked to a year.)',
   market_research_period_start_dt     DATE             COMMENT 'The calendar_1 date when the period started.',
   market_research_period_end_dt       DATE             COMMENT 'The calendar_1 date when the period ended.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_PERIOD PRIMARY KEY (market_research_period_sid) NOT ENFORCED 
)  COMMENT = 'A time period, as defined by providers of market research data. A time period is defined by its start date and its end date and by its type. It may or may not be identical to the standard periods, such as calendar_1 weeks, months, quarters or years.';
