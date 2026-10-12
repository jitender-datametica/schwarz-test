CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_PERIOD (
   market_research_period_sid               COMMENT 'The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.'
  ,market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_calendar_name            COMMENT 'The name by which the custom calendar is known.'
  ,market_research_period_name              COMMENT 'The display name of the time period.'
  ,market_research_period_type_cd           COMMENT 'The code identifying the kind of time period.'
  ,cy                                       COMMENT 'The calendar year to which this period is assigned. (Note that periods might span two years, but they are always linked to a year.)'
  ,market_research_period_start_dt          COMMENT 'The calendar date when the period started.'
  ,market_research_period_end_dt            COMMENT 'The calendar date when the period ended.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'A time period, as defined by providers of market research data. A time period is defined by its start date and its end date and by its type. It may or may not be identical to the standard periods, such as calendar weeks, months, quarters or years.'
 AS 
    SELECT 
        market_research_period_sid,
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_calendar_name,
        market_research_period_name,
        market_research_period_type_cd,
        cy,
        market_research_period_start_dt,
        market_research_period_end_dt,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_PERIOD ;