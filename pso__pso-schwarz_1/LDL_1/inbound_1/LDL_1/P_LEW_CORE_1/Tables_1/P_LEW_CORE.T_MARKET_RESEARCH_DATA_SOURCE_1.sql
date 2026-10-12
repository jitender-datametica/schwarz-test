/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_data_source_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_DATA_SOURCE_1 (
   market_research_data_provider_name  VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data source is known.',
   market_research_data_src_descr      VARCHAR(250)     COMMENT 'A textual description for the market data source.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_DATA_SOURCE PRIMARY KEY (market_research_data_src_name, market_research_data_provider_name) NOT ENFORCED 
)  COMMENT = 'A set of measures and related dimensions provided by a market data provider. E.g. Nielsen Retail Panel';
