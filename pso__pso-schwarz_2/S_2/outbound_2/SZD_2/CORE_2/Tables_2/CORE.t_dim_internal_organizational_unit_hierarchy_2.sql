/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_INTERNAL_ORGANIZATIONAL_UNIT_HIERARCHY_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_internal_organizational_unit_hierarchy_2 (
lvl0_int_org_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space. Level 0 Internal Org Unit_2 built in the data warehouse and             corresponds to the root with the value "alles".'),
lvl0_int_org_unit_name STRING(100) NOT NULL
OPTIONS(description='The name of the organizational unit_2 at level 0. It is built in the data warehouse and corresponds to the root with the value "alles".'),
lvl1_int_org_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space. Level 1 Internal Org Unit_2'),
lvl1_int_org_unit_name STRING(100) NOT NULL OPTIONS(description='The name of the organizational unit_2 at level1'),
lvl2_int_org_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 2 Internal Org Unit_2'),
lvl2_int_org_unit_name STRING(100) NOT NULL OPTIONS(description='The name of the organizational unit_2 at level2'),
lvl3_int_org_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 3 Internal Org Unit_2'),
lvl3_int_org_unit_name STRING(100) NOT NULL OPTIONS(description='The name of the organizational unit_2 at level3'),
lvl4_int_org_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 4 Internal Org Unit_2'),
lvl4_int_org_unit_name STRING(100) NOT NULL OPTIONS(description='The name of the organizational unit_2 at level4'),
lvl5_int_org_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 5 Internal Org Unit_2'),
lvl5_int_org_unit_name STRING(100) NOT NULL OPTIONS(description='The name of the organizational unit_2 at level5'),
lvl6_int_org_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 6 Internal Org Unit_2'),
lvl6_int_org_unit_name STRING(100) NOT NULL OPTIONS(description='The name of the organizational unit_2 at level6'),
lvl7_int_org_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 7 Internal Org Unit_2'),
lvl7_int_org_unit_name STRING(100) NOT NULL OPTIONS(description='The name of the organizational unit_2 at level7'),
lvl8_int_org_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 8 Internal Org Unit_2'),
lvl8_int_org_unit_name STRING(100) NOT NULL OPTIONS(description='The name of the organizational unit_2 at level8'),
lvl9_int_org_unit_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party surrogate key space. Key generation based on META table for party key space.  Level 9 Internal Org Unit_2'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
lvl9_int_org_unit_name STRING(100) NOT NULL OPTIONS(description='The name of the organizational unit_2 at level9'),
int_org_unit_hierarchy_lvl_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The hierarchial level number of the organizational unit_2'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (lvl9_int_org_unit_party_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - The flattened hierarchy_2 table. The level is fixed. Table holds the hierarchy_2 levels of organizational unit_2 - Source - IT4You Service Now');