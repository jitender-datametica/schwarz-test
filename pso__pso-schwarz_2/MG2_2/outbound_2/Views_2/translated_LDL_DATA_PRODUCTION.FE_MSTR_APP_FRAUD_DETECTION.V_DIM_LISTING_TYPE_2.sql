CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_dim_listing_type_2 (list_type_cd
OPTIONS(description='The code identifying the listing type, e.g. regular assortment, seasonal products, promotional items, etc.'),
list_type_descr
OPTIONS(description='A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc. (Description in group language, i.e. in German)'),
list_type_descr_de
OPTIONS(description='A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc. (Description in German)'),
list_type_descr_en
OPTIONS(description='A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc. (Description in English)'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THE LISTING TYPES DISTINGUISHES THE REGULAR ASSORTMENT FROM SEASONAL PRODUCTS, PROMOTIONAL ITEMS, ETC.`)
AS SELECT list_type_cd,
 list_type_descr,
 list_type_descr_de,
 list_type_descr_en,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_listing_type_2 AS main;