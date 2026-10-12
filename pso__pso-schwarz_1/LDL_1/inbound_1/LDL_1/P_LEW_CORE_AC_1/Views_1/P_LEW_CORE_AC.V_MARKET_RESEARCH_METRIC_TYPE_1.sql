CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_METRIC_TYPE_1 (
   market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_metric_type_cd           COMMENT 'The code which identifies the kind of metric that is supplied by a market data provider.'
  ,market_research_metric_type_descr        COMMENT 'A textual description for the kind of metric that is supplied by a market data provider'
  ,market_research_metric_categ_cd          COMMENT 'The code which identifies the group of metrics that are supplied by a market data provider.'
  ,market_research_uom_cd                   COMMENT 'The code which identifies the way, how a metric is measured.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'This minor entity defines the kinds of metrics which can be supplied by a market data provider.'
 AS 
    SELECT 
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_metric_type_cd,
        market_research_metric_type_descr,
        market_research_metric_categ_cd,
        market_research_uom_cd,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_METRIC_TYPE_1 ;