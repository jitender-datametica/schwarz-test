/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_INTERNAL_COMPANY_PARTNER_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 9. August 2022 12:18:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_internal_company_partner_1 (
internal_company_partner_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal company partner'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
internal_company_partner_nr STRING(20)
OPTIONS(description='Unique number of the partner company (receiving or sending company)'),
internal_company_partner_name STRING(100)
OPTIONS(description='Name for the internal company partner (receiving or sending company)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (internal_company_partner_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='An internal company can have additional identifier (partner) which is used in internal trading operations (between companies of the group). Relationship between internal_company/company nr is many to many with internal company partner');