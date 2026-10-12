/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_calendar_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_CALENDAR_2 (
   market_research_data_provider_name  VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data source is known.',
   market_research_calendar_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the custom calendar_2 is known.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_CALENDAR PRIMARY KEY (market_research_calendar_name, market_research_data_provider_name, market_research_data_src_name) NOT ENFORCED 
)  COMMENT = 'A custom calendar_2 which is defined by a provider of market research data. A calender defines various types of periods, such as weeks, months or years.';
