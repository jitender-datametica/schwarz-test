/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_ITEM_FAMILY_1
   generated from Powerdesigner on Mittwoch, 2. April 2025 13:11:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_item_family_1 (
product_group_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the item_1 family.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
item_family_nr STRING(250) NOT NULL OPTIONS(description='The business identifier of the item_1 family.'),
item_family_name STRING(100) NOT NULL OPTIONS(description='The name of the item_1 family in the default language.'),
item_family_name_de STRING(100) OPTIONS(description='The german translation of the name of the item_1 family.'),
item_family_name_en STRING(100) OPTIONS(description='The english translation of the name of the item_1 family.'),
sub_item_group_nr STRING(250) NOT NULL OPTIONS(description='The business identifier of the sub item_1 group.'),
sub_item_group_name STRING(100) NOT NULL OPTIONS(description='The name of the sub item_1 group in the default language.'),
sub_item_group_name_de STRING(100) OPTIONS(description='The german translation of the name of the sub item_1 group.'),
sub_item_group_name_en STRING(100) OPTIONS(description='The english translation of the name of the sub item_1 group.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (product_group_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - This dimension contains all the item_1 families and their superior sub item_1 groups denormalized. - Source - SAP RAN 900');