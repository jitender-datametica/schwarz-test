/* --------------------------------------------------------------------------------
   DDL for table: T_BUSINESS_UNIT_1
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_business_unit_1 (
party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
business_unit_nr STRING(250) NOT NULL OPTIONS(description='The identifier of a business unit.'),
business_unit_name STRING(100) NOT NULL OPTIONS(description='The textual name of a business unit.'),
synonym_business_unit_name STRING(100)
OPTIONS(description='Descriptive Attribute - The synonym name of the business unit_1 specified for IT4You, could be slightly different, denpendent on business requirement'),
source_sys_nr STRING(100) NOT NULL
OPTIONS(description='Source system payload attribute - Technical Surrogate Key (surves as Natural Key) - additional technical system id for identification of tickets.'),
source_updated_on_tmsp TIMESTAMP
OPTIONS(description='Source system payload attribute - The point in time when this record was last modified in the source system. (In case the record has not been modified since its creation, source_updated_on is identical to creation timestamp)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (party_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - lists the business units under Schwarz Group (e.g. Verwaltung, IT (S), IT(K), IT (L) etc.) - Source - IT4You ServiceNow');