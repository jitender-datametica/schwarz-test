CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_product_return_reason (prod_return_reason_sid
OPTIONS(description='The unique identifier (surrogate key) for the reasons why a product was returend to the store.'),
lang_cd OPTIONS(description='The code identifying the language.'), prod_return_reason_descr
OPTIONS(description='A textual description for the reasons why a product was returend to the store.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')) AS
SELECT *
FROM ldl_data_core_rel.t_product_return_reason AS MAIN
WHERE lang_cd = 'DE';