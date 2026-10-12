CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_METRIC_2 (
   market_research_data_provider_name       COMMENT 'The name by which the market data provider is known.'
  ,market_research_data_src_name            COMMENT 'The name by which the market data source is known.'
  ,market_research_country_cd               COMMENT 'The code which identifies a country_2 (as defined by a provider of market research data)'
  ,market_research_data_src_segment_name    COMMENT 'The name by which the segment of a market data report is known.'
  ,market_research_data_deliv_nr            COMMENT 'The number which inditifies the delivery of market research data for a given data provider, data source and country.'
  ,ref_dt                                   COMMENT 'The reference date to which the data delivery is related.'
  ,market_research_period_sid               COMMENT 'The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.'
  ,market_research_channel_sid              COMMENT 'The unique identifier (surrogate key) for a sales_2 channel that is defined by a provider of market research data.'
  ,market_research_region_sid               COMMENT 'The unique identifier (surrogate key) for a geographical region_2 that has been defined by a provider of market research data.'
  ,market_research_prod_sid                 COMMENT 'The unique identifier (surrogate key) for a product that is defined by a provider of market research data.'
  ,market_research_metric_type_cd           COMMENT 'The code which identifies the kind of metric that is supplied by a market data provider.'
  ,market_research_metric_val               COMMENT 'The metric value expressed as an amount.'
  ,curr_sid                                 COMMENT 'Surrogate Key CURRENCY'
  ,curr_iso_cd                              COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'
  ,market_research_metric_cnt               COMMENT 'The metric value expressed as an (integer) count'
  ,market_research_metric_qty               COMMENT 'The metric value expressed as a quantity'
  ,market_research_metric_pct               COMMENT 'The metric value expressed as a percentage.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'Various metrics get supplied by a market data provider. Some metrics may form a hierarchy_2, however by definition, they are not additive. Depending on the domain of the metric type one of the metric columns is set.'
 AS 
    SELECT 
        market_research_data_provider_name,
        market_research_data_src_name,
        market_research_country_cd,
        market_research_data_src_segment_name,
        market_research_data_deliv_nr,
        ref_dt,
        market_research_period_sid,
        market_research_channel_sid,
        market_research_region_sid,
        market_research_prod_sid,
        market_research_metric_type_cd,
        market_research_metric_val,
        curr_sid,
        curr_iso_cd,
        market_research_metric_cnt,
        market_research_metric_qty,
        market_research_metric_pct,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_METRIC_2 ;