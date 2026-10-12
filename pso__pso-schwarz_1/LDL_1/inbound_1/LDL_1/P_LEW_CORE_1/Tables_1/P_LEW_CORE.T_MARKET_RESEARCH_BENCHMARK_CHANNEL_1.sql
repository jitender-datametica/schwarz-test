/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_benchmark_channel_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_BENCHMARK_CHANNEL_1 (
   market_research_data_provider_name  VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data source is known.',
   market_research_country_cd          VARCHAR(2)       NOT NULL COMMENT 'The code which identifies a country_1 (as defined by a provider of market research data)',
   market_research_data_src_segment_name VARCHAR(100)     NOT NULL COMMENT 'The name by which the segment of a market data report is known.',
   market_research_channel_sid         NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a sales_1 channel that is defined by a provider of market research data.',
   default_benchmark_channel_fg        NUMBER(38,0)     COMMENT 'An indicator, showing if this channel is the default benchmark channel for the given segment.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_BENCHMARK_CHANNEL PRIMARY KEY (market_research_channel_sid, market_research_data_src_segment_name, market_research_data_src_name, market_research_country_cd, market_research_data_provider_name) NOT ENFORCED 
)  COMMENT = 'A segment of a market research data source may define one or several benchmark channels. These channels are used as reference to compare against. Typically, the country_1-level channels which does not include Lidl are used as benchmark. One of these channels is marked as the default channel.';
