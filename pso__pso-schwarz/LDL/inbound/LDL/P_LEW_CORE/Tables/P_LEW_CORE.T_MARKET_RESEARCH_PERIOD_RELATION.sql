/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_period_relation
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MARKET_RESEARCH_PERIOD_RELATION (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key CLIENT. Set to the international client.',
   market_research_period_sid          NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.',
   rel_market_research_period_sid      NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for the related time period. This period is considered equivalent to the first one in another calendar.',
   market_research_period_rel_type_cd  VARCHAR(100)     NOT NULL COMMENT 'The code identifying the way how two periods (as defined by a provider of market research data) are related to each other.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_MARKET_RESEARCH_PERIOD_RELATION PRIMARY KEY (market_research_period_sid, rel_market_research_period_sid, market_research_period_rel_type_cd, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'Two different calenders may difine similar time periods. A time period of one calender may have an equivalent time period in another calendar. This table relates equivalent time periods.';
