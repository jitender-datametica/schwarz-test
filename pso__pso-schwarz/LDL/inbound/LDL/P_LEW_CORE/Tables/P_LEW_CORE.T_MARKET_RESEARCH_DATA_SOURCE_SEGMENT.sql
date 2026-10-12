/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_data_source_segment
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_DATA_SOURCE_SEGMENT (
   market_research_data_provider_name  VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data source is known.',
   market_research_country_cd          VARCHAR(2)       NOT NULL COMMENT 'The code which identifies a country (as defined by a provider of market research data)',
   market_research_data_src_segment_name VARCHAR(100)     NOT NULL COMMENT 'The name by which the segment of a market data report is known.',
   market_research_data_src_segment_display_name VARCHAR(100)     COMMENT 'The name of the segment of a market data report, as defined by business.',
   market_research_data_src_segment_descr VARCHAR(250)     COMMENT 'A textual description for the segment of a market data report.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_DATA_SOURCE_SEGMENT PRIMARY KEY (market_research_data_src_segment_name, market_research_country_cd, market_research_data_src_name, market_research_data_provider_name) NOT ENFORCED 
)  COMMENT = 'A market data research data source may consist of several reports, e.g. one for food, one for non-food, etc.';
