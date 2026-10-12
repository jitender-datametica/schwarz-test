CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_dim_packing_type_1 (packing_type_cd
OPTIONS(description='The code identifying the way, how a product is packed.'), packing_type_descr
OPTIONS(description='A textual description for the way how a product is packed in group language, i.e. in German.'),
packing_type_descr_de OPTIONS(description='A textual description for the way how a product is packed in German.'),
packing_type_descr_en OPTIONS(description='A textual description for the way how a product is packed in English.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION DEFINES THE WAYS HOW A PRODUCT (ITEM_1) CAN BE PACKED. E.G. BOX, BAG, TIN, ...`)
AS SELECT packing_type_cd,
 packing_type_descr,
 packing_type_descr_de,
 packing_type_descr_en,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_packing_type_1 AS main;