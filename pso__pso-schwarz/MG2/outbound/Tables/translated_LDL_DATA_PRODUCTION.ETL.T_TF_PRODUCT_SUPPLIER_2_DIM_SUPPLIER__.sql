CREATE OR REPLACE TABLE ldl_data_production_etl.t_tf_product_supplier_2_dim_supplier__ (
sup_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the supplier.'),
sup_name STRING(100) NOT NULL OPTIONS(description='The name by which the supplier is known.'),
legal_name STRING(100) OPTIONS(description='The official name of the supplier, as shown in the company register.'),
vat_nr STRING(20) OPTIONS(description='The VAT identification number of the supplier.'),
sup_status_cd STRING(20) NOT NULL OPTIONS(description='The code for the lifecycle status of a supplier.'),
sup_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status of a supplier. (Description in group language, i.e. in German)'),
iso_country_cd STRING(2) NOT NULL
OPTIONS(description='The code according to ISO 3166 identifying the country, in which the supplier is located,'),
country_name STRING(100) NOT NULL
OPTIONS(description='The name of the country, in which the supplier is located, (Name in group language, i.e. German)'),
city_name STRING(100) OPTIONS(description='The name of the city where the supplier is located.'),
district_name STRING(100) OPTIONS(description='The name of the district, in which the supplier is located,'),
zip STRING(15) OPTIONS(description='The postal code of the address of the supplier.'),
street_name STRING(100) OPTIONS(description='The name of the street where the supplier is located.'),
house_nr STRING(100) OPTIONS(description='The number of the building within the street where the supplier is located.'),
lon NUMERIC(9,6) OPTIONS(description='The geographical longitude of the address of the supplier.'),
lat NUMERIC(9,6) OPTIONS(description='The geographical latitude of the address of the supplier.'),
dwh_load_id INTEGER,
dwh_node_cd STRING(20),
dwh_mapping_tmsp TIMESTAMP,
tf_error_fg INTEGER,
deleted_fg INTEGER,
dwh_valid_fg BOOL,
record_id INTEGER,
filename STRING(1000),
error_descr STRING(1000)
);