/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_AGE_SEGMENT_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. Juli 2022 12:00:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_age_segment_2 (
cust_age_segm_cd STRING(20) NOT NULL OPTIONS(description='The code for a customer age cluster'),
cust_age_segm_type_cd STRING(20) NOT NULL
OPTIONS(description='A type to distinquish customer age clustering for different departments'),
cust_age_segm_descr STRING(250) OPTIONS(description='The description for a customer age cluster'),
cust_age_segm_start_year BIGNUMERIC OPTIONS(description='A start year for a particular age segment'),
cust_age_segm_end_year BIGNUMERIC OPTIONS(description='An end year for a particular age segment'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_age_segm_cd, cust_age_segm_type_cd) NOT ENFORCED
) OPTIONS(description='This dimension defines clustering for a customer age');