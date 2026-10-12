/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_EMAIL_COUPON
   GENERATED FROM POWERDESIGNER ON Dienstag, 14. Juni 2022 11:34:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_email_coupon (
job_id BIGNUMERIC NOT NULL OPTIONS(description='The jobid number of the respective engagement event job '),
coupon_cd STRING(50) NOT NULL OPTIONS(description='The business key that uniquely identifies a coupon'),
subscr_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the subscriber'),
claim_dt DATE OPTIONS(description='The date when the coupon was claimed'),
coupon_promo_name STRING(100) OPTIONS(description='The type of coupon code'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (job_id, coupon_cd, subscr_sid) NOT ENFORCED
)
OPTIONS(description='The ETL lookup table based on the source files coupons_couponsallocation_last5days to get coupon_cd');