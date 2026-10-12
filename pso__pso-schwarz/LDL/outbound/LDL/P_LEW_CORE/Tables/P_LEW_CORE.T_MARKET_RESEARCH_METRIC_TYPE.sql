/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_metric_type
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_metric_type (
market_research_data_provider_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data source is known.'),
market_research_metric_type_cd STRING(100) NOT NULL
OPTIONS(description='The code which identifies the kind of metric that is supplied by a market data provider.'),
market_research_metric_type_descr STRING(1000) NOT NULL
OPTIONS(description='A textual description for the kind of metric that is supplied by a market data provider'),
market_research_metric_categ_cd STRING(100)
OPTIONS(description='The code which identifies the group of metrics that are supplied by a market data provider.'),
market_research_uom_cd STRING(100) OPTIONS(description='The code which identifies the way, how a metric is measured.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_data_provider_name, market_research_data_src_name, market_research_metric_type_cd)
NOT ENFORCED
) OPTIONS(description='This minor entity defines the kinds of metrics which can be supplied by a market data provider.');