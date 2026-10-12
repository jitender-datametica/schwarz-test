CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_region_1 (market_research_region_sid
OPTIONS(description='The unique identifier (surrogate key) for a geographical region_1 that has been defined by a provider of market research data.'),
market_research_data_provider_name OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name OPTIONS(description='The name by which the market data source is known.'),
market_research_country_cd
OPTIONS(description='The code which identifies a country_1 (as defined by a provider of market research data)'),
market_research_region_name
OPTIONS(description='The name of the geographical region_1, as it has been defined by a provider of market research data.'),
market_research_region_type_cd
OPTIONS(description='The code identifying the kind of geographical region_1 which has been defined by a provider of market research data.'),
loc_sid_wh
OPTIONS(description='The unique identifier for the sales_1 company (VGES) which is represented by this market research region.'),
display_seq OPTIONS(description='The sort order in which the region_1 will be displayed in reports.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `A GEOGRAPHICAL REGION_1, AS DEFINED BY PROVIDERS OF MARKET RESEARCH DATA. THIS MAY INCLUDE COUNTRIES, PROVINCES OF A COUNTRY_1 OR SMALLER GEOGRAPHICAL AREAS. THESE REGIONS DO NOT NECESSARILY NEED TO MATCH THE STANDARD GEOGRAPHICAL REGIONS. HOWEVER, REGIONS WHICH HAVE BEEN CUSTOMIZED IN ORDER TO MATCH LIDL DEFINED REGIONS, MAY ALSO BE PRESENT.`)
AS SELECT market_research_region_sid,
 market_research_data_provider_name,
 market_research_data_src_name,
 market_research_country_cd,
 market_research_region_name,
 market_research_region_type_cd,
 loc_sid_wh,
 display_seq,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_region_1;