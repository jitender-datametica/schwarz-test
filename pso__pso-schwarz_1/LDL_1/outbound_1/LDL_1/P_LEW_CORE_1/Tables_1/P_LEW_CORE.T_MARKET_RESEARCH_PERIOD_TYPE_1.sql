/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_period_type_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_period_type_1 (
market_research_period_type_cd STRING(100) NOT NULL OPTIONS(description='The code identifying the kind of time period.'),
market_research_period_type_display_name STRING(100)
OPTIONS(description='The name for the kind of time period, as defined by business.'),
market_research_period_type_descr STRING(250) OPTIONS(description='A textual description for the kind of time period.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_period_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor entitiy defines the kind of time period which has been defined by a provider of market research data. E.g. a week or a rolling period of 52 weeks.');