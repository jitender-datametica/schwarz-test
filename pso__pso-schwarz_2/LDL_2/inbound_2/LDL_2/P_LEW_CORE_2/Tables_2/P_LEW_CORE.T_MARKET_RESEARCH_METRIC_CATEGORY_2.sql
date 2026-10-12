/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_metric_category_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_METRIC_CATEGORY_2 (
   market_research_metric_categ_cd     VARCHAR(100)     NOT NULL COMMENT 'The code which identifies the group of metrics that are supplied by a market data provider.',
   market_research_metric_categ_descr  VARCHAR(250)     COMMENT 'A textual description for the group of metrics that are supplied by a market data provider.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_METRIC_CATEGORY PRIMARY KEY (market_research_metric_categ_cd) NOT ENFORCED 
)  COMMENT = 'Metric types can be grouped. This minor entity defines group of metric types.';
