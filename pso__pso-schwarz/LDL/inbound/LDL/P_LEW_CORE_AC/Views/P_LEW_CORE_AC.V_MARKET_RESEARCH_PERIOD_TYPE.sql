CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_PERIOD_TYPE (
   market_research_period_type_cd           COMMENT 'The code identifying the kind of time period.'
  ,market_research_period_type_display_name COMMENT 'The name for the kind of time period, as defined by business.'
  ,market_research_period_type_descr        COMMENT 'A textual description for the kind of time period.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'This minor entitiy defines the kind of time period which has been defined by a provider of market research data. E.g. a week or a rolling period of 52 weeks.'
 AS 
    SELECT 
        market_research_period_type_cd,
        market_research_period_type_display_name,
        market_research_period_type_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_PERIOD_TYPE ;