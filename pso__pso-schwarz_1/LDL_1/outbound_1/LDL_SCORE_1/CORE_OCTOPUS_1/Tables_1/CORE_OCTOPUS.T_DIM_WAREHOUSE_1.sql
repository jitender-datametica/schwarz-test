CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_warehouse_1 (
wh_sid BIGNUMERIC NOT NULL OPTIONS(description='Unique identifier for the warehouse'),
regional_org_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the regional organization.'),
country_cd STRING(2) OPTIONS(description='The code for the country_1 in which the site (cross docks) resides in.'),
country_descr STRING(100)
OPTIONS(description='A textual description for country_cd written out in group language (German).'),
wh_nr STRING(20) OPTIONS(description='The number which identifies the warehouse in '),
wh_abbr_name STRING(100) OPTIONS(description='The abbreviated name of the warehouse.'),
wh_name STRING(100) OPTIONS(description='The name of the warehouse.'),
external_wh_fg BOOL
OPTIONS(description='An indicator showing whether the warehouse is an external one to add capacity to a central warehouse.'),
longitude NUMERIC(9,6) OPTIONS(description='Object.address_1-data.coordinates x'),
latitude NUMERIC(9,6) OPTIONS(description='Object.address_1-data.coordinates y'),
city_name STRING(100) OPTIONS(description='Name of the city'),
zip STRING(15) OPTIONS(description='Zip code / PLZ'),
street_name STRING(100) OPTIONS(description='Name of the street'),
gln_nr STRING(13) OPTIONS(description='The Global Location_1 Number where the supplier_1 is located.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_sid) NOT ENFORCED
)
OPTIONS(description='Warehouses where the products are stored. A flag indicates whether it\'s an external warehouse (not run by Lidl) or internal warehouse (run by Lidl). ');