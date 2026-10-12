/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_INTERNAL_ORGANIZATIONAL_UNIT_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_internal_organizational_unit_2 (
party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
business_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party. It defines the business unit_2 of the organizational unit. Key generation based on META table for party key space.'),
int_org_unit_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The identifier of an  organizational unit_2'),
int_org_unit_name STRING(100) NOT NULL OPTIONS(description='The textual name of an organization unit_2'),
synonym_int_org_unit_name STRING(100)
OPTIONS(description='Descriptive Attribute - The sysonym name of the organizational unit_2 specified for IT4You, could be slightly different, denpendent on business requirement'),
source_int_org_unit_hierarchy_lvl_nr BIGNUMERIC(38,0)
OPTIONS(description='The hierarchial level number of the organizational unit_2 in source system.'),
int_org_unit_hierarchy_lvl_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The hierarchial level number of the organizational unit_2 build in the data warehouse. It corresponds not directly to source system department level (conversion is dwh level - 1 = source system level)'),
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
OPTIONS(description='Major Dimension - lists the internal organizational units under Schwarz Group - Source - IT4You ServiceNow');