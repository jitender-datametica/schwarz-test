CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_period_relation_2 (client_id
OPTIONS(description='Surrogate Key CLIENT. Set to the international client.'), market_research_period_sid
OPTIONS(description='The unique identifier (surrogate key) for a time period that is defined by a provider of market research data.'),
rel_market_research_period_sid
OPTIONS(description='The unique identifier (surrogate key) for the related time period. This period is considered equivalent to the first one in another calendar.'),
market_research_period_rel_type_cd
OPTIONS(description='The code identifying the way how two periods (as defined by a provider of market research data) are related to each other.'),
dwh_valid_from
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
deleted_fg
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `TWO DIFFERENT CALENDERS MAY DIFINE SIMILAR TIME PERIODS. A TIME PERIOD OF ONE CALENDER MAY HAVE AN EQUIVALENT TIME PERIOD IN ANOTHER CALENDAR. THIS TABLE RELATES EQUIVALENT TIME PERIODS.`)
AS SELECT client_id,
 market_research_period_sid,
 rel_market_research_period_sid,
 market_research_period_rel_type_cd,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_period_relation_2;