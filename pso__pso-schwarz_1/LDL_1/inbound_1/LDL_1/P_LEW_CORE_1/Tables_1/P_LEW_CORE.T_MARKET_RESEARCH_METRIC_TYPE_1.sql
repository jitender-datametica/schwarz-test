/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_metric_type_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_METRIC_TYPE_1 (
   market_research_data_provider_name  VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data provider is known.',
   market_research_data_src_name       VARCHAR(100)     NOT NULL COMMENT 'The name by which the market data source is known.',
   market_research_metric_type_cd      VARCHAR(100)     NOT NULL COMMENT 'The code which identifies the kind of metric that is supplied by a market data provider.',
   market_research_metric_type_descr   VARCHAR(1000)    NOT NULL COMMENT 'A textual description for the kind of metric that is supplied by a market data provider',
   market_research_metric_categ_cd     VARCHAR(100)     COMMENT 'The code which identifies the group of metrics that are supplied by a market data provider.',
   market_research_uom_cd              VARCHAR(100)     COMMENT 'The code which identifies the way, how a metric is measured.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_METRIC_TYPE PRIMARY KEY (market_research_data_provider_name, market_research_data_src_name, market_research_metric_type_cd) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the kinds of metrics which can be supplied by a market data provider.';
