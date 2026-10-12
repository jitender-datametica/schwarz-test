CREATE OR REPLACE TABLE szd_production_core.t_dim_supplier_2 (
party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the supplier_2'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
supplier_name STRING(100) NOT NULL OPTIONS(description='Natural Key/Business Key - The name of the supplier_2'),
source_supplier_name_address_city_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive Attribute - the name of the supplier_2 directly from source. Source: VMT'),
email_txt STRING(1000) OPTIONS(description='Descriptive Attribute - Email of the company'),
status_cd STRING(50) NOT NULL OPTIONS(description='The status_2 code for the company'),
supplier_nr STRING(50) OPTIONS(description='Supplier_2 identifier from buying department system'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
sort_txt STRING(1000) OPTIONS(description='Descriptive attribute - A simple short text used for sorting'),
PRIMARY KEY (party_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - A company which delivers products to Lidl. The supplier_2 is not necessarily identical with the manufacturer. It could also be a wholesaler who also sources the products from somewhere. Lidl dictates to the supplier_2 which items he needs ( for example bUTTERFLY / OWIM, Lidl Asia / OWIM). - Source - VMT');