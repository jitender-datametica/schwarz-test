CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_METRIC_CATEGORY (
   market_research_metric_categ_cd          COMMENT 'The code which identifies the group of metrics that are supplied by a market data provider.'
  ,market_research_metric_categ_descr       COMMENT 'A textual description for the group of metrics that are supplied by a market data provider.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'Metric types can be grouped. This minor entity defines group of metric types.'
 AS 
    SELECT 
        market_research_metric_categ_cd,
        market_research_metric_categ_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_METRIC_CATEGORY ;