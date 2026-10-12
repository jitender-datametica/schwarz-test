CREATE OR REPLACE TABLE szd_production_core.t_dim_it_resource_2 (
resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
it_resource_type_id INTEGER NOT NULL
OPTIONS(description='Natural/Business Key - The unique code identifying the discriminators for task configuration item_2 groups (CI group) in IT4You.'),
owner_country_business_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location. It defines the business country_2 of the ticket caller. Key generation based on META table for party key space.'),
owner_division_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party owner division. It defines the division of the ticket owner. Key generation based on META table for party key space.'),
owner_org_unit_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party owner org unit. It defines the org unit_2 of of the ticket owner.  Key generation based on META table for party key space.'),
localization_id INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - code identifying the discriminators for localization'),
solution_business_unit_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a business unit. It defines the business unit_2 of the solution.'),
it_resource_nr STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key -  number of CI group (z.B. ITS0012345, BS0012345, APP0001234)'),
it_resource_psp_nr STRING(250) NOT NULL OPTIONS(description='Natural/Business Key - PSP Element number'),
it_resource_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - name of CI group. CI as configuration item_2 is source system term for e.g. applications, databases, solutions & other objects '),
owner_country_business_cd STRING(3) NOT NULL
OPTIONS(description='Denormalized Attribute - The code identifying the country_2 according in the SCHWARZ group'),
owner_country_business_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name by which the country_2 is known,'),
owner_division_cd STRING(50) NOT NULL
OPTIONS(description='Denormalized Attribute - Natural/Business Key - The unique code for each division within the Schwarz Group, i.e.L-Lidl or K-Kaufland'),
owner_division_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name for the division within the Schwarz Group, i.e.Lidl or Kaufland'),
owner_int_org_unit_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The textual name of an organization unit_2'),
owner_lvl2_int_org_unit_party_sid INTEGER NOT NULL
OPTIONS(description='Denormalized Attribute - The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 1 Internal Org Unit.'),
owner_lvl2_int_org_unit_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name of the organizational unit_2 at level 1.'),
owner_lvl3_int_org_unit_party_sid INTEGER NOT NULL
OPTIONS(description='Denormalized Attribute - The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 2 Internal Org Unit.'),
owner_lvl3_int_org_unit_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name of the organizational unit_2 at level 2.'),
owner_lvl4_int_org_unit_party_sid INTEGER NOT NULL
OPTIONS(description='Denormalized Attribute - The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 3 Internal Org Unit.'),
owner_lvl4_int_org_unit_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name of the organizational unit_2 at level 4.'),
owner_lvl5_int_org_unit_party_sid INTEGER NOT NULL
OPTIONS(description='Denormalized Attribute - The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 4 Internal Org Unit.'),
owner_lvl5_int_org_unit_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name of the organizational unit_2 at level 4.'),
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
OPTIONS(description='Major Dimension - This subtype holds information on all IT resources like network, software, hardware, application, solution and other resources. Denormalized attributes for internal org levels (besides lowest leaf level as FK) are supportive - Source - IT4You Service Now for Solutions ITPM, SARA, for Solution Infrastructure HAK2');