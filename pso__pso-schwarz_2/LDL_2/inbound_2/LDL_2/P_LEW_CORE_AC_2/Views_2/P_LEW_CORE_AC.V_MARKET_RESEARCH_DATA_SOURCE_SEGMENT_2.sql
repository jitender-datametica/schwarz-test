CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_DATA_SOURCE_SEGMENT_2 (
   market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_country_cd               COMMENT 'The code which identifies a country_2 (as defined by a provider of market research data)'
  ,market_research_data_src_segment_name    COMMENT 'The name by which the segment of a market data report is known.'
  ,market_research_data_src_segment_display_name COMMENT 'The name of the segment of a market data report, as defined by business.'
  ,market_research_data_src_segment_descr   COMMENT 'A textual description for the segment of a market data report.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'A market data research data source may consist of several reports, e.g. one for food, one for non-food, etc.'
 AS 
    SELECT 
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_country_cd,
        market_research_data_src_segment_name,
        market_research_data_src_segment_display_name,
        market_research_data_src_segment_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_DATA_SOURCE_SEGMENT_2 ;