CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_metric_type_1 (market_research_data_provider_name
OPTIONS(description='The name by which the market data provider is known.'), market_research_data_src_name
OPTIONS(description='The name by which the market data source is known.'), market_research_metric_type_cd
OPTIONS(description='The code which identifies the kind of metric that is supplied by a market data provider.'),
market_research_metric_type_descr
OPTIONS(description='A textual description for the kind of metric that is supplied by a market data provider'),
market_research_metric_categ_cd
OPTIONS(description='The code which identifies the group of metrics that are supplied by a market data provider.'),
market_research_uom_cd OPTIONS(description='The code which identifies the way, how a metric is measured.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE KINDS OF METRICS WHICH CAN BE SUPPLIED BY A MARKET DATA PROVIDER.`)
AS SELECT market_research_data_provider_name,
 market_research_data_src_name,
 market_research_metric_type_cd,
 market_research_metric_type_descr,
 market_research_metric_categ_cd,
 market_research_uom_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_metric_type_1;