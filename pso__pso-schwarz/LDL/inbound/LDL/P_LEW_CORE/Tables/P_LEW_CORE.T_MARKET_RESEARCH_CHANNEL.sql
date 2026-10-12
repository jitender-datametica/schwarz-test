/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_channel
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_CHANNEL (
   market_research_channel_sid         NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a sales channel that is defined by a provider of market research data.',
   market_research_channel_name        VARCHAR(100)     NOT NULL COMMENT 'The name of the sales channel, as it has been defined by a provider of market research data.',
   channel_involvement_type_cd         VARCHAR(100)     NOT NULL COMMENT 'The code identifying the way, how the own organization is involved in the market research channel. Lidl can be included in the channel, Lidl may not be part of the channel, the channel may represent Lidl only or the channel is not applicable for Lidl.',
   market_research_data_provider_name  VARCHAR(100)     COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     COMMENT 'The name by which the market data source is known.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_CHANNEL PRIMARY KEY (market_research_channel_sid) NOT ENFORCED 
)  COMMENT = 'The sales channel, as defined by providers of market research data. E.g. large supermarkets, hypermarkets, discounters, etc.';
