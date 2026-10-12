CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_COUNTRY_2 (
   market_research_country_cd               COMMENT 'The code which identifies a country_2 (as defined by a provider of market research data)'
  ,market_research_country_name             COMMENT 'The name for the country_2 (as defined by a provider of market research data)'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'A country_2, as defined by a provider of market research data. E.g. Germany, Belgium, etc.'
 AS 
    SELECT 
        market_research_country_cd,
        market_research_country_name,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_COUNTRY_2 ;