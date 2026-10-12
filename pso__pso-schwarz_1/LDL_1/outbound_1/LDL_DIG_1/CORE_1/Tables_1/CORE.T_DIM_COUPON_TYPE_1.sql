/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COUPON_TYPE_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 26. April 2022 16:33:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_coupon_type_1 (
coupon_type_cd STRING(20) NOT NULL
OPTIONS(description='Code identifying the coupon type (ex\'GENERIC\',\'PROMOTION\')'),
coupon_type_descr STRING(250) OPTIONS(description='The textual descriottion for the coupon type'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
PRIMARY KEY (coupon_type_cd) NOT ENFORCED
) OPTIONS(description='The minor dimension that defines the promotion coupon types ( individual, generic, promotion)');