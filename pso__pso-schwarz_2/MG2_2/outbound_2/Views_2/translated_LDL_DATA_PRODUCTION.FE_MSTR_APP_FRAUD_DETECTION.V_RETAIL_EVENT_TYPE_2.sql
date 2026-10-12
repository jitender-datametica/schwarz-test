CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_retail_event_type_2 (retail_event_type_cd
OPTIONS(description='The code identifying the subtype discriminator for retail events.'), lang_cd
OPTIONS(description='The code identifying the language.'), retail_event_type_descr
OPTIONS(description='A textual description for the subtype discriminator for retail events.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE SUBTYE DISCRIMINATORS FOR RETAIL EVENTS. IT DISTINGUISHES BETWEEN SALES_2 EVENTS AND RETURNS.`)
AS SELECT retail_event_type_cd,
 lang_cd,
 retail_event_type_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_rel.t_retail_event_type_2 AS main
WHERE lang_cd = 'DE';