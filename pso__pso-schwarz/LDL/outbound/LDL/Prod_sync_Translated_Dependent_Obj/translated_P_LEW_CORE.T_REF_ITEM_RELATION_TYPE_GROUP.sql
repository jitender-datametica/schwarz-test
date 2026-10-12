CREATE OR REPLACE TABLE ldl_p_lew_core.t_ref_item_relation_type_group (
item_rel_type_grp_cd STRING(100) NOT NULL
OPTIONS(description='The relationship type group code that arranges the relationship types for a combining property, like source system or table.'),
item_rel_type_grp_descr STRING(250)
OPTIONS(description='The relationship type group description for arranged relationship types.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (item_rel_type_grp_cd) NOT ENFORCED
)
OPTIONS(description='The relationship type group arranges the relationship types via a combining property, like source system or table.\n             Manually filled.');