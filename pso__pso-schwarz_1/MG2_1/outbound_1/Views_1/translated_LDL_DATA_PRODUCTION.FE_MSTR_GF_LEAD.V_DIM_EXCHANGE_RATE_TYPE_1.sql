CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_dim_exchange_rate_type_1 (exchange_rate_type_cd
OPTIONS(description='The code identifying the way in which one currency can be converted into another.'),
exchange_rate_type_descr
OPTIONS(description='A textual description for the way in which one currency can be converted into another expressed in group language, i.e. in German.'),
exchange_rate_type_descr_de
OPTIONS(description='A textual description for the way in which one currency can be converted into another expressed in German.'),
exchange_rate_type_descr_en
OPTIONS(description='A textual description for the way in which one currency can be converted into another expressed in English.'),
active_for_bus_year_fg
OPTIONS(description='An indicator showing whether the related exchange rate is, in principle, active for an entire business year.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION DEFINES THE WAYS IN WHICH ONE CURRENCY CAN BE CONVERTED INTO ANOTHER. E.G. LIDLS REPORTING EXCHANGE RATE, ECB RATE, ...`)
AS SELECT exchange_rate_type_cd,
 exchange_rate_type_descr,
 exchange_rate_type_descr_de,
 exchange_rate_type_descr_en,
 active_for_bus_year_fg,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_exchange_rate_type_1 AS main;