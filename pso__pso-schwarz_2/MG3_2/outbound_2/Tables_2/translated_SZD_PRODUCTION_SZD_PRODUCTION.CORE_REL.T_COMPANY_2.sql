CREATE OR REPLACE TABLE szd_production_core_rel.t_company_2 (
party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the company.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
company_status_cd STRING(250) NOT NULL OPTIONS(description='The status_2 code for the company'),
company_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the type of the company (internal or external). An internal company is contracted by the internal group of companies itself. An external company is commissioned by the supplier.'),
company_id STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key - A technical identifier from original source system'),
company_nr STRING(250)
OPTIONS(description='Natural/Business Key - A numeric or alphanumeric value which identifies the company for the business.'),
company_name STRING(100) NOT NULL
OPTIONS(description='Descriptive attribute - The name by which the company is known cut at 100 characters.'),
source_company_name_address_city_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive attribute - The name the company and maybe its address_2, city and other things as delivered directly from source. - Source: VMT'),
related_company_party_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for the related company.'),
email_txt STRING(1000) OPTIONS(description='Descriptive attribute - Email of the company'),
src_sys_name STRING(1000) OPTIONS(description='Descriptive attribute - System Identifier from SAP'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
additional_name_1_txt STRING(1000)
OPTIONS(description='Descriptive attribute - an additional name or part of the name of a company, may contains the type of legal entity of the company like "GmbH", "Limited", Co. KG or others but could also be just a part of a companies name'),
additional_name_2_txt STRING(1000)
OPTIONS(description='Descriptive attribute - an additional name or part of the name of a company, may contains the type of legal entity of the company like "GmbH", "Limited", Co. KG or others but could also be just a part of a companies name'),
international_location_1_nr INTEGER
OPTIONS(description='Natural/Business Key - First part of the international location_2 number.'),
international_location_2_nr INTEGER
OPTIONS(description='Natural/Business Key - Second part of the international location_2 number.'),
international_location_checksum_nr INTEGER
OPTIONS(description='Natural/Business Key - Checksum for the international location_2 numbers.'),
sort_txt STRING(1000) OPTIONS(description='Descriptive attribute - A simple short text used for sorting'),
vat_number STRING(250) OPTIONS(description='Descriptive attribute - The VAT identification number of the company.'),
PRIMARY KEY (party_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - This entity contains all companies that we interact with, e.g. Supplier_2 ,  Hauler,  Handling agents , etc - Source - Manual / Excel Report from CDS, Broker (per Mail), VMT, LExIS');