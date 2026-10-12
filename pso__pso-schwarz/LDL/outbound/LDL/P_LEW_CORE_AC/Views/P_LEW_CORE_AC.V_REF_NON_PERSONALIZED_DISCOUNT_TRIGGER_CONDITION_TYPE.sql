CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_non_personalized_discount_trigger_condition_type (np_discount_trigger_condition_type_cd
OPTIONS(description='Code for trigger condition of a non-personalized discount.'),
np_discount_trigger_condition_type_name
OPTIONS(description='Name for trigger condition of a non-personalized discount.'),
np_discount_trigger_condition_type_descr
OPTIONS(description='Description for trigger condition of a non-personalized discount.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table contains the different trigger conditions of a non-personalized discount.`) AS SELECT
 np_discount_trigger_condition_type_cd,
 np_discount_trigger_condition_type_name,
 np_discount_trigger_condition_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_non_personalized_discount_trigger_condition_type;