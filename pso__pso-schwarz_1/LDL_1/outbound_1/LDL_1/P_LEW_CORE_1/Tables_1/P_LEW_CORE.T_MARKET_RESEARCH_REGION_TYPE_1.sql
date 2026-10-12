/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_region_type_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_region_type_1 (
market_research_data_provider_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data source is known.'),
market_research_region_type_cd STRING(100) NOT NULL
OPTIONS(description='The code identifying the kind of geographical region_1 which has been defined by a provider of market research data.'),
market_research_region_type_descr STRING(250)
OPTIONS(description='A textual description for the kind of geographical region.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_data_provider_name, market_research_region_type_cd, market_research_data_src_name)
NOT ENFORCED
)
OPTIONS(description='This minor entitiy defines the types of geographical areas which have been defined by a provider of market research data. It is used to distinguish between countries, provinces of countries and other types of geographical areas');