/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_SUPPLIER
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_supplier (
party_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the supplier'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
supplier_name STRING(100) NOT NULL OPTIONS(description='Natural Key/Business Key - The name of the supplier'),
source_supplier_name_address_city_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive Attribute - the name of the supplier directly from source. Source: VMT'),
email_txt STRING(1000) OPTIONS(description='Descriptive Attribute - Email of the company'),
status_cd STRING(50) NOT NULL OPTIONS(description='The status code for the company'),
supplier_nr STRING(50) OPTIONS(description='Supplier identifier from buying department system'),
sort_txt STRING(1000) OPTIONS(description='Descriptive attribute - A simple short text used for sorting'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (party_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - A company which delivers products to Lidl. The supplier is not necessarily identical with the manufacturer. It could also be a wholesaler who also sources the products from somewhere. Lidl dictates to the supplier which items he needs ( for example bUTTERFLY / OWIM, Lidl Asia / OWIM). - Source - VMT');