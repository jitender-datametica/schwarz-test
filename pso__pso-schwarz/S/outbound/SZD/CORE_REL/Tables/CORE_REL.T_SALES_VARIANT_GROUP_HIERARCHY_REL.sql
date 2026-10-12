/* --------------------------------------------------------------------------------
   DDL for table: T_SALES_VARIANT_GROUP_HIERARCHY_REL
   generated from Powerdesigner on Donnerstag, 27. März 2025 13:22:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_sales_variant_group_hierarchy_rel (
product_group_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Major Entity - The sales variant group is a special product group for sales variants. - Source - LExIS'),
parent_product_group_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Major Entity - The sales variant group is a special product group for sales variants. - Source - LExIS'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source.'),
PRIMARY KEY (product_group_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Bridge Entity - Contains the hierarchy dependencies between sales variant groups and their parent groups. - Source - SAP LExIS');