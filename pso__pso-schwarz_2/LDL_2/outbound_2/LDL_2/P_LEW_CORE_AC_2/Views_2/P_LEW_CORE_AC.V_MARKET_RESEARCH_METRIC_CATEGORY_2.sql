CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_market_research_metric_category_2 (market_research_metric_categ_cd
OPTIONS(description='The code which identifies the group of metrics that are supplied by a market data provider.'),
market_research_metric_categ_descr
OPTIONS(description='A textual description for the group of metrics that are supplied by a market data provider.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `METRIC TYPES CAN BE GROUPED. THIS MINOR ENTITY DEFINES GROUP OF METRIC TYPES.`) AS SELECT
 market_research_metric_categ_cd,
 market_research_metric_categ_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_market_research_metric_category_2;