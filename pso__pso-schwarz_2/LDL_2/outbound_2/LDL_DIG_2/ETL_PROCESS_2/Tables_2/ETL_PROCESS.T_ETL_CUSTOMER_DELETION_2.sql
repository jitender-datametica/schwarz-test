CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_customer_deletion_2 (
cust_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the customer'),
deletion_tmsp TIMESTAMP OPTIONS(description='Timestamp when the deletion request intiated'),
deletion_type STRING(100) OPTIONS(description='Deletion sent using standard or manual process'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_sid) NOT ENFORCED
)
OPTIONS(description='ETL table to support the customer deletions to process GDPR requests coming for TR customers in Bosys customerprofile');