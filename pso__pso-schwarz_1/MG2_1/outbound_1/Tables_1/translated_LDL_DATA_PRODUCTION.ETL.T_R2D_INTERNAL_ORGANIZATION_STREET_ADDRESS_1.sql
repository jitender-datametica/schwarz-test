CREATE OR REPLACE TABLE ldl_data_production_etl.t_r2d_internal_organization_street_address_1 (
int_org_sid INTEGER,
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
iso_country_cd STRING(20),
country_name STRING(100),
city_name STRING(100),
district_name STRING(100),
zip STRING(15),
street_name STRING(100),
house_nr STRING(100),
lon INTEGER,
lat INTEGER,
reporting_country_cd STRING(20),
reporting_country_name STRING(100)
);