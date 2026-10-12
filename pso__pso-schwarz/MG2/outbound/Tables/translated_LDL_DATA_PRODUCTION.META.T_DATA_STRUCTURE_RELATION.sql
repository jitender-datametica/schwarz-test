CREATE OR REPLACE TABLE ldl_data_production_meta.t_data_structure_relation (
data_struct_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the data structure.'),
base_data_struct_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the data structure.'),
data_struct_rel_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the way how one data structure forms the base for another data structure.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (data_struct_sid, base_data_struct_sid, dwh_valid_from_tmsp, data_struct_rel_type_cd) NOT ENFORCED
)
OPTIONS(description='This table links data structures to their related base structures. This includes the following scenarios: (1) An external table is based on a file. (2) A view is based on one or several tables or other views. (3) A schema definition file defines the structure of a data file. (4) The hierarchy of frontend objects. (The type of relationship is defined by the relationship type code.)');