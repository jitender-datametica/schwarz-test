CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_dim_currency (curr_cd
OPTIONS(description='The code identifying the currency according to ISO-4217.'), curr_name
OPTIONS(description='The name for the currency in group language, i.e. in German.'), curr_name_de
OPTIONS(description='The name for the currency in german.'), curr_name_en
OPTIONS(description='The name for the currency in english.'), used_in_stores_fg
OPTIONS(description='An indicator showing, if this currency is used in a country where the Schwarz Group operates any stores.'),
euro_exch_rate
OPTIONS(description='The current exchange rate of this currency to the group currency (Euro). (These exchange rates are fixed once per business year.)'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION DEFINES THE CURRENCY CODES ACCORDING TO ISO-4217. (E.G. EUR, USD, GBP, ...)`)
AS SELECT curr_cd,
 curr_name,
 curr_name_de,
 curr_name_en,
 used_in_stores_fg,
 euro_exch_rate,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_currency AS main
WHERE used_in_stores_fg;