/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUBSCRIBER_DELETION_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 6. Oktober 2022 17:05:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_subscriber_deletion_2 (
subscr_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the subscriber'),
deletion_tmsp TIMESTAMP OPTIONS(description='Timestamp when the deletion request intiated'),
deletion_type STRING(100) OPTIONS(description='Deletion sent using standard or manual process'),
deletion_country_cd STRING(5)
OPTIONS(description='Countries affected by deletion - value\'All\' affects all countries'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (subscr_sid) NOT ENFORCED
) OPTIONS(description='ETL table to support the GDPR deletions');