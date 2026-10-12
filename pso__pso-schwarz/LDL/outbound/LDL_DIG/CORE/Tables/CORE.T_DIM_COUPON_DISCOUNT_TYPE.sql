/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COUPON_DISCOUNT_TYPE
   GENERATED FROM POWERDESIGNER ON Montag, 28. August 2023 14:19:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_coupon_discount_type (
coupon_discount_type_cd STRING(20) NOT NULL
OPTIONS(description='Code identifying the discount type (e.g. Monetary, Percentage, etc.)'),
coupon_discount_type_descr STRING(250) OPTIONS(description='The textual description for the coupon discount type'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
PRIMARY KEY (coupon_discount_type_cd) NOT ENFORCED
)
OPTIONS(description='The minor dimension that defines the promotion coupon discount types ( monetary, percentage, X for Y, etc.)');