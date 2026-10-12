/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_data_provider
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_data_provider (
market_research_data_provider_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_provider_descr STRING(250)
OPTIONS(description='A textual description for the market data provider.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_data_provider_name) NOT ENFORCED
)
OPTIONS(description='A market data provider is an external organization that conducts market research. E.g. Nielsen, GFK, etc.');