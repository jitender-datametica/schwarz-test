CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_country (market_research_country_cd
OPTIONS(description='The code which identifies a country (as defined by a provider of market research data)'),
market_research_country_name
OPTIONS(description='The name for the country (as defined by a provider of market research data)'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `A COUNTRY, AS DEFINED BY A PROVIDER OF MARKET RESEARCH DATA. E.G. GERMANY, BELGIUM, ETC.`) AS
SELECT market_research_country_cd,
 market_research_country_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_country;