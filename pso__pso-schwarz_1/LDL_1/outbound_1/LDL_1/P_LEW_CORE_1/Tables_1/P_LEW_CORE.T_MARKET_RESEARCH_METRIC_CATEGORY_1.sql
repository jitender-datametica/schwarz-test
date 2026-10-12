/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_metric_category_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_metric_category_1 (
market_research_metric_categ_cd STRING(100) NOT NULL
OPTIONS(description='The code which identifies the group of metrics that are supplied by a market data provider.'),
market_research_metric_categ_descr STRING(250)
OPTIONS(description='A textual description for the group of metrics that are supplied by a market data provider.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_metric_categ_cd) NOT ENFORCED
) OPTIONS(description='Metric types can be grouped. This minor entity defines group of metric types.');