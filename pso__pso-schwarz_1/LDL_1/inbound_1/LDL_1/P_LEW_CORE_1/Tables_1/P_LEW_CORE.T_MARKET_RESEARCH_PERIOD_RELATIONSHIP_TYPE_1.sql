/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_period_relationship_type_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_PERIOD_RELATIONSHIP_TYPE_1 (
   market_research_period_rel_type_cd  VARCHAR(100)     NOT NULL COMMENT 'The code identifying the way how two periods (as defined by a provider of market research data) are related to each other.',
   market_research_period_rel_type_descr VARCHAR(250)     COMMENT 'A textual description for the way how two periods (as defined by a provider of market research data) are related to each other.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_PERIOD_RELATIONSHIP_TYPE PRIMARY KEY (market_research_period_rel_type_cd) NOT ENFORCED 
)  COMMENT = 'This minor entitiy defines the way how two periods (as defined by a provider of market research data) are related to each other. E.g. local periods are linked to the global calender, or a period is related to its equivalent period in the previous year.';
