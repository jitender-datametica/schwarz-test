CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_exchange_rate_2 (src_curr_cd
OPTIONS(description='The code according to ISO-4217, identifying the currency that is to be converted.'), tgt_curr_cd
OPTIONS(description='The code according to ISO-4217, identifying the currency into which the source currency is to be converted.'),
exchange_rate_type_cd
OPTIONS(description='The code identifying the way in which one currency can be converted into another.'), active_from_dt
OPTIONS(description='The first date from when this record became valid from a business perspective, i.e. the date from when on this exchange rate was used (inclusively).'),
active_to_dt
OPTIONS(description='The last date up to when this record was valid from a business perspective, i.e. the date up to when this exchange rate was used (inclusively).'),
active_fg
OPTIONS(description='An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt.'),
bus_year
OPTIONS(description='Some exchange rates are considered valid for an entire business year. If this is the case, this is the business year.'),
exchange_rate
OPTIONS(description='The factor by which the amount in the source currency (from_curr_cd) needs to be multiplied, so that the result is in the target currency (to_curr_cd).'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `CURRENCY EXCHANGE RATES. FOR A GIVEN PAIR OF CURRENCIES THERE MIGHT BE SEVERAL EXCHANGE RATE TYPES. SOME OF THEM MIGHT BE VALID FOR AN ENTIRE BUSINESS YEAR.`)
AS SELECT src_curr_cd,
 tgt_curr_cd,
 exchange_rate_type_cd,
 active_from_dt,
 active_to_dt,
 active_fg,
 bus_year,
 exchange_rate,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_fact_exchange_rate_2 AS main;