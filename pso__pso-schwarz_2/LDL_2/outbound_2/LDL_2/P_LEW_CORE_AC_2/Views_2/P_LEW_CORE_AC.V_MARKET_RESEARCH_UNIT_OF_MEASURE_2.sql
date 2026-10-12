CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_unit_of_measure_2 (market_research_uom_cd
OPTIONS(description='The code which identifies the way, how a metric is measured.'), market_research_uom_descr
OPTIONS(description='A textual description for the way, how a metric is measured.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE WAY, HOW A METRIC IS MEASURED, I.E. AS AN AMOUNT IN A GIVEN CURRENCY, AS A COUNT OR AS A QUANTITY`)
AS SELECT market_research_uom_cd,
 market_research_uom_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_unit_of_measure_2;