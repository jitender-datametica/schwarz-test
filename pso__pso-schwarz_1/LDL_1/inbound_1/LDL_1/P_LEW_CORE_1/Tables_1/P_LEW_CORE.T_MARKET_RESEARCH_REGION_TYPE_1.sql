/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_region_type_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_REGION_TYPE_1 (
   market_research_data_provider_name  VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data source is known.',
   market_research_region_type_cd      VARCHAR(100)     NOT NULL COMMENT 'The code identifying the kind of geographical region_1 which has been defined by a provider of market research data.',
   market_research_region_type_descr   VARCHAR(250)     COMMENT 'A textual description for the kind of geographical region.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_REGION_TYPE PRIMARY KEY (market_research_data_provider_name, market_research_region_type_cd, market_research_data_src_name) NOT ENFORCED 
)  COMMENT = 'This minor entitiy defines the types of geographical areas which have been defined by a provider of market research data. It is used to distinguish between countries, provinces of countries and other types of geographical areas';
