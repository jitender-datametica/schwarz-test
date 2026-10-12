/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_metric_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_METRIC_2 CLUSTER BY (
     MARKET_RESEARCH_DATA_PROVIDER_NAME,
     MARKET_RESEARCH_DATA_SRC_NAME,
     MARKET_RESEARCH_COUNTRY_CD 
) (
   market_research_data_provider_name  VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data source is known.',
   market_research_country_cd          VARCHAR(2)       COMMENT 'The code which identifies a country_2 (as defined by a provider of market research data)',
   market_research_data_src_segment_name VARCHAR(100)     COMMENT 'The name by which the segment of a market data report is known.',
   market_research_data_deliv_nr       VARCHAR(100)     NOT NULL COMMENT 'The number which inditifies the delivery of market research data for a given data provider, data source and country.',
   ref_dt                              DATE             NOT NULL COMMENT 'The reference date to which the data delivery is related.',
   market_research_period_sid          NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.',
   market_research_channel_sid         NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a sales_2 channel that is defined by a provider of market research data.',
   market_research_region_sid          NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a geographical region_2 that has been defined by a provider of market research data.',
   market_research_prod_sid            NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a product that is defined by a provider of market research data.',
   market_research_metric_type_cd      VARCHAR(100)     NOT NULL COMMENT 'The code which identifies the kind of metric that is supplied by a market data provider.',
   market_research_metric_val          NUMBER(38,5)     COMMENT 'The metric value expressed as an amount.',
   curr_sid                            NUMBER(38,0)     COMMENT 'Surrogate Key CURRENCY',
   curr_iso_cd                         VARCHAR(20)      COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd',
   market_research_metric_cnt          NUMBER(38,5)     COMMENT 'The metric value expressed as an (integer) count',
   market_research_metric_qty          NUMBER(38,5)     COMMENT 'The metric value expressed as a quantity',
   market_research_metric_pct          NUMBER(38,5)     COMMENT 'The metric value expressed as a percentage.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_METRIC PRIMARY KEY (market_research_period_sid, market_research_channel_sid, market_research_region_sid, market_research_prod_sid, market_research_metric_type_cd) NOT ENFORCED 
)  COMMENT = 'Various metrics get supplied by a market data provider. Some metrics may form a hierarchy_2, however by definition, they are not additive. Depending on the domain of the metric type one of the metric columns is set.';
