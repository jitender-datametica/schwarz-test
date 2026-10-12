CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_PERIOD_RELATIONSHIP_TYPE_1 (
   market_research_period_rel_type_cd       COMMENT 'The code identifying the way how two periods (as defined by a provider of market research data) are related to each other.'
  ,market_research_period_rel_type_descr    COMMENT 'A textual description for the way how two periods (as defined by a provider of market research data) are related to each other.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'This minor entitiy defines the way how two periods (as defined by a provider of market research data) are related to each other. E.g. local periods are linked to the global calender, or a period is related to its equivalent period in the previous year.'
 AS 
    SELECT 
        market_research_period_rel_type_cd,
        market_research_period_rel_type_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_PERIOD_RELATIONSHIP_TYPE_1 ;