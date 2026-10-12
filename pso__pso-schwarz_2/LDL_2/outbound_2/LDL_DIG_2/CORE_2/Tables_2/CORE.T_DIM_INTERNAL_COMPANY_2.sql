/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_INTERNAL_COMPANY_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 9. August 2022 12:17:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_internal_company_2 (
internal_company_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the company'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
internal_company_cd STRING(5)
OPTIONS(description='Unique identifier of the company to which we book accounting documents in the source system (SAP)'),
internal_company_name STRING(100)
OPTIONS(description='Name for the company code to which we book accounting  documents as in SAP system'),
company_nr STRING(20)
OPTIONS(description='Unique number of the company to which we book accounting documents(number different from SAP system)'),
company_name STRING(100)
OPTIONS(description='Name for the company code to which we book accounting  documents(name different from SAP system)'),
country_cd STRING(5) OPTIONS(description='Code of the country_2 where this company is registered'),
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country. If a company is not a webshop the value is NULL'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (internal_company_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A company is an entity which is legally registered in a given country_2 and for which we track financial and accountign records.  This table includes only companies from Schwarz group.');