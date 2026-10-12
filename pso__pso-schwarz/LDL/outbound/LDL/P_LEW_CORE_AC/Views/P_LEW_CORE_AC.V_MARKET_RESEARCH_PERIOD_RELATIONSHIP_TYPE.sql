CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_period_relationship_type (market_research_period_rel_type_cd
OPTIONS(description='The code identifying the way how two periods (as defined by a provider of market research data) are related to each other.'),
market_research_period_rel_type_descr
OPTIONS(description='A textual description for the way how two periods (as defined by a provider of market research data) are related to each other.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITIY DEFINES THE WAY HOW TWO PERIODS (AS DEFINED BY A PROVIDER OF MARKET RESEARCH DATA) ARE RELATED TO EACH OTHER. E.G. LOCAL PERIODS ARE LINKED TO THE GLOBAL CALENDER, OR A PERIOD IS RELATED TO ITS EQUIVALENT PERIOD IN THE PREVIOUS YEAR.`)
AS SELECT market_research_period_rel_type_cd,
 market_research_period_rel_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_period_relationship_type;