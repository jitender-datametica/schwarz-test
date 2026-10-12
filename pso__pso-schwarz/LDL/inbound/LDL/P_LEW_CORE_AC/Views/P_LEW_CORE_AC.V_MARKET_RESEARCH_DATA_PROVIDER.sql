CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_DATA_PROVIDER (
   market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_provider_descr      COMMENT 'A textual description for the market data provider.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'A market data provider is an external organization that conducts market research. E.g. Nielsen, GFK, etc.'
 AS 
    SELECT 
        market_research_data_provider_name,
        market_research_data_provider_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_DATA_PROVIDER ;