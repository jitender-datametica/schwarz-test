CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_item_relation_type (item_rel_type_cd
OPTIONS(description='Source relationship type number, which identifies the type of the relationship between the parent item and the child item.'),
item_rel_type_grp_cd
OPTIONS(description='The relationship type group code that arranges the relationship types for a combining property, like source system or table.'),
item_rel_type_descr
OPTIONS(description='Descriptioin of the relationship type of the relation between the parent item and the child item.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table constains the relationship type of the relation between the Parent Item with the Child Item.\nManually filled with values derived from the source.`)
AS SELECT item_rel_type_cd,
 item_rel_type_grp_cd,
 item_rel_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_item_relation_type;