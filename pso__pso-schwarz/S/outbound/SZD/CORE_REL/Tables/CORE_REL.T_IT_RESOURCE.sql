/* --------------------------------------------------------------------------------
   DDL for table: T_IT_RESOURCE
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_it_resource (
resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
it_resource_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural/Business Key - The unique code identifying the discriminators for task configuration item groups (CI group) in IT4You.'),
owner_country_business_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location for SCHWARZ business country of the it resource owner. Key generation based on META table for party key space.'),
owner_division_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party. It defines the division of it resource owner. Key generation based on META table for party key space.'),
owner_org_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party. IT defines owner org unit. Key generation based on META table for party key space.'),
non_sit_owner_lvl2_org_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party. IT defines the Org Level 2 org unit for NON SIT owner -Temporary solution for non SIT.Key generation based on META table for party key space.            It is a mandatory manually maintained  field and  denormalized column in the source.Once there is a regular solution then it can be migrated to owner_org_unit_party_sid. '),
non_sit_owner_lvl3_org_unit_party_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the party. IT defines the Org Level 3 org unit for NON SIT owner - Temporary solution for non SIT.Key generation based on META table for party key space.            It is a non mandatory manually maintained field and denormalized column in the source.Once there is a regular solution then it can be migrated to owner_org_unit_party_sid. '),
solution_business_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a business unit. It defines the business unit of the solution.'),
localization_id BIGNUMERIC(38,0)
OPTIONS(description='Natural Key/Business Key - code identifying the discriminators for localization'),
it_resource_nr STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key -  number of CI group (z.B. ITS0012345, BS0012345, APP0001234)'),
it_resource_psp_nr STRING(250) NOT NULL OPTIONS(description='Natural/Business Key - PSP Element number'),
it_resource_name STRING(500) NOT NULL
OPTIONS(description='Descriptive Attribute - name of CI group. CI as configuration item is source system term for e.g. applications, databases, solutions & other objects '),
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
PRIMARY KEY (resource_item_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - This subtype holds information on all IT resources like network, software, hardware and other resources. Source - IT4You Service Now for Solution ITPM');