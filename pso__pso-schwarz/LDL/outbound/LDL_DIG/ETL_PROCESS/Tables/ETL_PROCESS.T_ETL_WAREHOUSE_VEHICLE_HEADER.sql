CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_vehicle_header (
wh_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
vehicle_internal_nr STRING(40) NOT NULL
OPTIONS(description='This number is the internal number of the trucks which carries the package.'),
wh_cd STRING(5) OPTIONS(description='A short  unique code for warehouse'),
vehicle_departure_tmsp TIMESTAMP
OPTIONS(description='The timestamp when a truck departed from the warehouse'),
vehicle_license_plate_nr STRING(30)
OPTIONS(description='The licence plate number of the trucks which carries the package'),
vehicle_loading_start_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the loading in the truck started'),
vehicle_loading_end_tmsp TIMESTAMP
OPTIONS(description='The timestamp when a truck is finished with loading'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wh_sid, vehicle_internal_nr) NOT ENFORCED
) OPTIONS(description='An ETL table intended for loading core.t_fact_customer_package_shipment');