/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_COST_STRUCTURE_ASSOCIATION_2
   GENERATED FROM POWERDESIGNER ON Freitag, 10. Februar 2023 11:37:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_cost_structure_association_2 (
cost_item STRING(20) NOT NULL OPTIONS(description='Identifier of the lower level Cost Center/Cost Element'),
hierarchy_group_nr STRING(20) NOT NULL
OPTIONS(description='Identifier of the associated lower level Cost Center/Cost Element group'),
cost_structure_type_cd STRING(5) OPTIONS(description='Code of the Cost Structure'),
ctrl_area_cd STRING(5) OPTIONS(description='Code of the Controlling Area'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cost_item, hierarchy_group_nr) NOT ENFORCED
)
OPTIONS(description='Table that contains the relationships between the cost center/cost element and the correspondent lowest group level per each hierarchy_2');