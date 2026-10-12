CREATE OR REPLACE TABLE ldl_p_lew_core.t_ref_item_relation_type (
item_rel_type_cd STRING(100) NOT NULL
OPTIONS(description='Source relationship type number, which identifies the type of the relationship between the parent item and the child item.'),
item_rel_type_grp_cd STRING(100) NOT NULL
OPTIONS(description='The relationship type group code that arranges the relationship types for a combining property, like source system or table.'),
item_rel_type_descr STRING(250)
OPTIONS(description='Descriptioin of the relationship type of the relation between the parent item and the child item.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (item_rel_type_cd, item_rel_type_grp_cd) NOT ENFORCED
)
OPTIONS(description='This table constains the relationship type of the relation between the Parent Item with the Child Item.\n             Manually filled with values derived from the source.');