/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_period_relationship_type_2
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_period_relationship_type_2 (
market_research_period_rel_type_cd STRING(100) NOT NULL
OPTIONS(description='The code identifying the way how two periods (as defined by a provider of market research data) are related to each other.'),
market_research_period_rel_type_descr STRING(250)
OPTIONS(description='A textual description for the way how two periods (as defined by a provider of market research data) are related to each other.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_period_rel_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor entitiy defines the way how two periods (as defined by a provider of market research data) are related to each other. E.g. local periods are linked to the global calender, or a period is related to its equivalent period in the previous year.');