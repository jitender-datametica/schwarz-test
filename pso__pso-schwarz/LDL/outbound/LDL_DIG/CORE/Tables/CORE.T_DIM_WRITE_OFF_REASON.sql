/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WRITE_OFF_REASON
   GENERATED FROM POWERDESIGNER ON Montag, 18. November 2024 15:39:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_write_off_reason (
write_off_reason_cd STRING(5) NOT NULL OPTIONS(description='Code for the reason of the write-off operation.'),
write_off_reason_descr STRING(250) NOT NULL
OPTIONS(description='Description for the reason of the write-off operation.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (write_off_reason_cd) NOT ENFORCED
) OPTIONS(description='A minor dimension that contains detailed descriptions of the different write-off reasons.');