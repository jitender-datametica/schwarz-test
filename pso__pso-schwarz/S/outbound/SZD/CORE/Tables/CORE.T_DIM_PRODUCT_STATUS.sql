/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_PRODUCT_STATUS
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_product_status (
product_status_cd STRING(50) NOT NULL OPTIONS(description='Natural Key/Business Key - The status code for the product'),
product_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the status code  written out in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (product_status_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - The minor dimension that contains the list of possible values for product status. - Source - VMT');