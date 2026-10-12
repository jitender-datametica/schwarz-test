/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_COST_ELEMENT_GROUP_HIERARCHY_2
   GENERATED FROM POWERDESIGNER ON Montag, 27. Februar 2023 10:06:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_cost_element_group_hierarchy_2 (
ctrl_area_cd STRING(5) NOT NULL OPTIONS(description='Code of the Controlling Area '),
child_ce_group_nr STRING(20) NOT NULL OPTIONS(description='Identifier of the lower level Cost Element Group (child)'),
parent_ce_group_nr STRING(20) NOT NULL
OPTIONS(description='Identifier of the higher level Cost Element Group  (parent)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (ctrl_area_cd, child_ce_group_nr) NOT ENFORCED
) OPTIONS(description='This ETL table contains all hierarchical parent-child relationships for Cost Element Groups');