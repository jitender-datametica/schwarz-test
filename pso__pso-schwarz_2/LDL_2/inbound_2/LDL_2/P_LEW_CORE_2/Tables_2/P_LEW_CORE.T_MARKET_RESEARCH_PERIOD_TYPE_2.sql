/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_period_type_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_PERIOD_TYPE_2 (
   market_research_period_type_cd      VARCHAR(100)     NOT NULL COMMENT 'The code identifying the kind of time period.',
   market_research_period_type_display_name VARCHAR(100)     COMMENT 'The name for the kind of time period, as defined by business.',
   market_research_period_type_descr   VARCHAR(250)     COMMENT 'A textual description for the kind of time period.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_PERIOD_TYPE PRIMARY KEY (market_research_period_type_cd) NOT ENFORCED 
)  COMMENT = 'This minor entitiy defines the kind of time period which has been defined by a provider of market research data. E.g. a week or a rolling period of 52 weeks.';
