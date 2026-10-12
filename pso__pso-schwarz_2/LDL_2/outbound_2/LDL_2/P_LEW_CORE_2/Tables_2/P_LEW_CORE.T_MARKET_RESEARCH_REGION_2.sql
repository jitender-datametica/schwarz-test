/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_region_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_region_2 (
market_research_region_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a geographical region_2 that has been defined by a provider of market research data.'),
market_research_data_provider_name STRING(100)
OPTIONS(description='The name by which the market data provider is known.'),
market_research_data_src_name STRING(100) OPTIONS(description='The name by which the market data source is known.'),
market_research_country_cd STRING(2)
OPTIONS(description='The code which identifies a country_2 (as defined by a provider of market research data)'),
market_research_region_name STRING(100) NOT NULL
OPTIONS(description='The name of the geographical region_2, as it has been defined by a provider of market research data.'),
market_research_region_type_cd STRING(100)
OPTIONS(description='The code identifying the kind of geographical region_2 which has been defined by a provider of market research data.'),
loc_sid_wh BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier for the sales_2 company (VGES) which is represented by this market research region.'),
display_seq BIGNUMERIC(38,0) OPTIONS(description='The sort order in which the region_2 will be displayed in reports.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_region_sid) NOT ENFORCED
)
OPTIONS(description='A geographical region_2, as defined by providers of market research data. This may include countries, provinces of a country_2 or smaller geographical areas. These regions do not necessarily need to match the standard geographical regions. However, regions which have been customized in order to match Lidl defined regions, may also be present.');