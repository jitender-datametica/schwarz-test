/* --------------------------------------------------------------------------------
   DDL for table: t_market_research_period_relation_1
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_market_research_period_relation_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CLIENT. Set to the international client.'),
market_research_period_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.'),
rel_market_research_period_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related time period. This period is considered equivalent to the first one in another calendar.'),
market_research_period_rel_type_cd STRING(100) NOT NULL
OPTIONS(description='The code identifying the way how two periods (as defined by a provider of market research data) are related to each other.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'),
PRIMARY KEY (market_research_period_sid, rel_market_research_period_sid, market_research_period_rel_type_cd,
 dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='Two different calenders may difine similar time periods. A time period of one calender may have an equivalent time period in another calendar. This table relates equivalent time periods.');