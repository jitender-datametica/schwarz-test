/* --------------------------------------------------------------------------------
   DDL for table: t_local_market_research_period_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_LOCAL_MARKET_RESEARCH_PERIOD_2 (
   market_research_data_provider_name  VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data source is known.',
   market_research_country_cd          VARCHAR(2)       NOT NULL COMMENT 'The code which identifies a country_2 (as defined by a provider of market research data)',
   market_research_data_src_segment_name VARCHAR(100)     NOT NULL COMMENT 'The name by which the segment of a market data report is known.',
   src_period_nr                       VARCHAR(100)     NOT NULL COMMENT 'The number by which the time period is identified by the data provider.',
   market_research_period_sid          NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.',
   market_research_period_local_name   VARCHAR(100)     NOT NULL COMMENT 'The name of the time period, as defined in the local market data source segment.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_LOCAL_MARKET_RESEARCH_PERIOD PRIMARY KEY (src_period_nr, market_research_data_src_segment_name, market_research_country_cd, market_research_data_src_name, market_research_data_provider_name) NOT ENFORCED 
)  COMMENT = 'Time periods which are defined by providers of market research data, may be identified by multiple numbers, depending on the country_2 and the data source. This table associates these numbers to the (global) time perid.';
