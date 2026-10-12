CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_booking_reference_2 (
cust_booking_ref_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for customer booking reference link'),
cust_booking_ref_link STRING(1000) NOT NULL
OPTIONS(description='The reference link containing EKID & URL identifying the customer touch points incase of offline and online booking'),
cust_touchpoint_lvl3_id BIGNUMERIC NOT NULL
OPTIONS(description='The identifier for customer touchpoint at hierarchy_2 level 3'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_booking_ref_sid) NOT ENFORCED
)
OPTIONS(description='This dimension defines the different customer booking reference id. Contains EKID & URL identifying customer touchpoint incase of online and offline booking');