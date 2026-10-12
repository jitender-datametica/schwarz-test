CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_order_area (
order_area_nr STRING(20) NOT NULL OPTIONS(description='The number which identifies the order area.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country organization.'),
country_org_cd STRING(2)
OPTIONS(description='The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)'),
order_area_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the order area. (Description in group language, i.e. in German)'),
order_area_descr_de STRING(250) OPTIONS(description='A textual description for the order area. (Description in German)'),
order_area_descr_en STRING(250)
OPTIONS(description='A textual description for the order area. (Description in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (order_area_nr, country_org_sid) NOT ENFORCED
)
OPTIONS(description='The order area groups items that are typically stored in the same storage zone in the warehouse. In different  warehouses, the assignment may be different. An order area is identified by its number and the warehouse. (I.e. the number is local to the warhouse.)');