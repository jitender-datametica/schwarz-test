/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUST_AGE_SEGMENT_TYPE
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. Juli 2022 12:02:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cust_age_segment_type (
cust_age_segm_type_cd STRING(20) NOT NULL
OPTIONS(description='A code for a type to distinquish customer age clustering for different departments'),
cust_age_segm_type_descr STRING(250) OPTIONS(description='The textual description for the customer age type'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_age_segm_type_cd) NOT ENFORCED
) OPTIONS(description='This dimension defines a type to distinquish customer age clustering for different departments');