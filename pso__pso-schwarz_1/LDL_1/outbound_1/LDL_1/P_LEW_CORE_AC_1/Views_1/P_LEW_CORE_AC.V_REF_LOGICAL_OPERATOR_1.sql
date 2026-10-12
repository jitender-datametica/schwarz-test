CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_logical_operator_1 (logical_operator_cd
OPTIONS(description='Code of  item_1/itemgroup_1 combination type for a non personalized discount.'), logical_operator_descr
OPTIONS(description='Description of  item_1/itemgroup_1 combination type for a non personalized discount.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table contains the different item_1/itemgroup_1 combination type for a non personalized discount.(Mix&Match)`)
AS SELECT logical_operator_cd,
 logical_operator_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_logical_operator_1;