/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_data_provider
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_DATA_PROVIDER (
   market_research_data_provider_name  VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data provider is known.',
   market_research_data_provider_descr VARCHAR(250)     COMMENT 'A textual description for the market data provider.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_DATA_PROVIDER PRIMARY KEY (market_research_data_provider_name) NOT ENFORCED 
)  COMMENT = 'A market data provider is an external organization that conducts market research. E.g. Nielsen, GFK, etc.';
