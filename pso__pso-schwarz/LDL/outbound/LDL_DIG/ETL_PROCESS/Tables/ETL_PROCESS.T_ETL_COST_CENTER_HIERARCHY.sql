/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_COST_CENTER_HIERARCHY
   GENERATED FROM POWERDESIGNER ON Freitag, 24. Februar 2023 12:00:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_cost_center_hierarchy (
ctrl_area_cd STRING(5) NOT NULL OPTIONS(description='Code of the Controlling Area'),
child_cost_center STRING(20) NOT NULL OPTIONS(description='Identifier of the lower level Cost Center (child)'),
parent_cost_center STRING(20) OPTIONS(description='Identifier of the higher level Cost Center (parent)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (ctrl_area_cd, child_cost_center) NOT ENFORCED
) OPTIONS(description='This ETL table contains all hierarchical parent-child relationships for Cost Centers');