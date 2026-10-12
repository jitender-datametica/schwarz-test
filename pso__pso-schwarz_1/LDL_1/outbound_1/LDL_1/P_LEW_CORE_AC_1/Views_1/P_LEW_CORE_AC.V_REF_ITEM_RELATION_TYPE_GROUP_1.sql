CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_item_relation_type_group_1 (item_rel_type_grp_cd
OPTIONS(description='The relationship type group code that arranges the relationship types for a combining property, like source system or table.'),
item_rel_type_grp_descr OPTIONS(description='The relationship type group description for arranged relationship types.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `The relationship type group arranges the relationship types via a combining property, like source system or table.\nManually filled.`)
AS SELECT item_rel_type_grp_cd,
 item_rel_type_grp_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_item_relation_type_group_1;