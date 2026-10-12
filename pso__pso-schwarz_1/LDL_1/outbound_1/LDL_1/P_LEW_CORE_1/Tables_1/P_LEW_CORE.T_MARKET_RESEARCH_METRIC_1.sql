/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_metric_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_metric_1 (
market_research_data_provider_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) NOT NULL
OPTIONS(description='The name by which the market data source is known.'),
market_research_country_cd STRING(2)
OPTIONS(description='The code which identifies a country_1 (as defined by a provider of market research data)'),
market_research_data_src_segment_name STRING(100)
OPTIONS(description='The name by which the segment of a market data report is known.'),
market_research_data_deliv_nr STRING(100) NOT NULL
OPTIONS(description='The number which inditifies the delivery of market research data for a given data provider, data source and country.'),
ref_dt DATE NOT NULL OPTIONS(description='The reference date to which the data delivery is related.'),
market_research_period_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.'),
market_research_channel_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a sales_1 channel that is defined by a provider of market research data.'),
market_research_region_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a geographical region_1 that has been defined by a provider of market research data.'),
market_research_prod_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a product that is defined by a provider of market research data.'),
market_research_metric_type_cd STRING(100) NOT NULL
OPTIONS(description='The code which identifies the kind of metric that is supplied by a market data provider.'),
market_research_metric_val BIGNUMERIC(38,5) OPTIONS(description='The metric value expressed as an amount.'),
curr_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CURRENCY'),
curr_iso_cd STRING(20) OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'),
market_research_metric_cnt BIGNUMERIC(38,5) OPTIONS(description='The metric value expressed as an (integer) count'),
market_research_metric_qty BIGNUMERIC(38,5) OPTIONS(description='The metric value expressed as a quantity'),
market_research_metric_pct BIGNUMERIC(38,5) OPTIONS(description='The metric value expressed as a percentage.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_period_sid, market_research_channel_sid, market_research_region_sid,
 market_research_prod_sid, market_research_metric_type_cd) NOT ENFORCED
) CLUSTER BY market_research_data_provider_name, market_research_data_src_name, market_research_country_cd
OPTIONS(description='Various metrics get supplied by a market data provider. Some metrics may form a hierarchy_1, however by definition, they are not additive. Depending on the domain of the metric type one of the metric columns is set.');