CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_order_area_1 (
order_area_nr STRING(20) NOT NULL OPTIONS(description='The number which identifies the order area.'),
int_org_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
order_area_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the order area.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (order_area_nr, int_org_sid, lang_cd) NOT ENFORCED
)
OPTIONS(description='The order area groups items that are typically stored in the same storage zone in the warehouse. In different  warehouses, the assignment may be different. An order area is identified by its number and the warehouse. (I.e. the number is local to the warhouse.)');