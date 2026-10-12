/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_GHOST_PACKAGE_CONFIGURATION_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 20. Februar 2024 12:41:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_ghost_package_configuration_2 (
hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for hauler.'),
dist_channel_cd STRING(5) NOT NULL
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
first_scan_days_cnt BIGNUMERIC
OPTIONS(description='Number of days without scan since the goods are issued, to consider the package_2  to be a "ghost".'),
delivery_days_cnt BIGNUMERIC
OPTIONS(description='Number of days without delivery since the goods are issued, to consider the package_2  to be a "ghost".'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (hauler_sid, dist_channel_cd, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='ETL table used for configuration purposes for evaluating Ghost Packages (missing packages).');