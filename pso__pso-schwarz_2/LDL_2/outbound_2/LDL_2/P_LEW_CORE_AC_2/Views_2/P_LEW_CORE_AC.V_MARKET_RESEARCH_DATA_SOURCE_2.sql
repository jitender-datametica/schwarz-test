CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_data_source_2 (market_research_data_provider_name
OPTIONS(description='The name by which the market data provider is known.'), market_research_data_src_name
OPTIONS(description='The name by which the market data source is known.'), market_research_data_src_descr
OPTIONS(description='A textual description for the market data source.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `A SET OF MEASURES AND RELATED DIMENSIONS PROVIDED BY A MARKET DATA PROVIDER. E.G. NIELSEN RETAIL PANEL`)
AS SELECT market_research_data_provider_name,
 market_research_data_src_name,
 market_research_data_src_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_data_source_2;