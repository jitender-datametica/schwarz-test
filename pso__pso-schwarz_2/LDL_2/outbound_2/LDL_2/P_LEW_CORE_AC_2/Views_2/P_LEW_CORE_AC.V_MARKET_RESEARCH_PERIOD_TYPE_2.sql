CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_period_type_2 (market_research_period_type_cd
OPTIONS(description='The code identifying the kind of time period.'), market_research_period_type_display_name
OPTIONS(description='The name for the kind of time period, as defined by business.'), market_research_period_type_descr
OPTIONS(description='A textual description for the kind of time period.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITIY DEFINES THE KIND OF TIME PERIOD WHICH HAS BEEN DEFINED BY A PROVIDER OF MARKET RESEARCH DATA. E.G. A WEEK OR A ROLLING PERIOD OF 52 WEEKS.`)
AS SELECT market_research_period_type_cd,
 market_research_period_type_display_name,
 market_research_period_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_period_type_2;