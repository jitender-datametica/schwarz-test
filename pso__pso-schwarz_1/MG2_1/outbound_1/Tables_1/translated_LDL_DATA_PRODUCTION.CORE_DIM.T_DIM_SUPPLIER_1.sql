CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_supplier_1 (
sup_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the supplier.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
sup_name STRING(100) NOT NULL OPTIONS(description='The name by which the supplier_1 is known.'),
legal_name STRING(100) OPTIONS(description='The official name of the supplier_1, as shown in the company register.'),
vat_nr STRING(20) OPTIONS(description='The VAT identification number of the supplier.'),
sup_status_cd STRING(20) NOT NULL OPTIONS(description='The code for the lifecycle status_1 of a supplier.'),
sup_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status_1 of a supplier. (Description in group language, i.e. in German)'),
iso_country_cd STRING(2) NOT NULL
OPTIONS(description='The code according to ISO 3166 identifying the country_1, in which the supplier_1 is located,'),
country_name STRING(100) NOT NULL
OPTIONS(description='The name of the country_1, in which the supplier_1 is located, (Name in group language, i.e. German)'),
city_name STRING(100) OPTIONS(description='The name of the city where the supplier_1 is located.'),
district_name STRING(100) OPTIONS(description='The name of the district, in which the supplier_1 is located,'),
zip STRING(15) OPTIONS(description='The postal code of the address_1 of the supplier.'),
street_name STRING(100) OPTIONS(description='The name of the street where the supplier_1 is located.'),
house_nr STRING(100) OPTIONS(description='The number of the building within the street where the supplier_1 is located.'),
lon NUMERIC(9,6) OPTIONS(description='The geographical longitude of the address_1 of the supplier.'),
lat NUMERIC(9,6) OPTIONS(description='The geographical latitude of the address_1 of the supplier.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (sup_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A supplier_1 is a company that delivers products to the Schwarz Group. Supplier_1 is one out of possibly several roles that can be played by a company.');