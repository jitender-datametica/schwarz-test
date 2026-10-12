CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_non_personalized_discount_trigger_itemgroup (client_id
OPTIONS(description='unique identifier of the DWH client / slice.'), np_discount_sid
OPTIONS(description='Surrogate Key of the non personalized discount.'), np_discount_trigger_nr
OPTIONS(description='Unique Identifier of the trigger for a non-personalized discount.'), np_discount_action_nr
OPTIONS(description='Unique Identifier of the action for a non-personalized discount.'), item_grp_int_sid
OPTIONS(description='Surrogate Key ITEMGROUP INTERNATIONAL'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table contains the item group(s)required to trigger the non personalized discount, which may differ from the item group(s) to which the discount is applied.`)
AS SELECT client_id,
 np_discount_sid,
 np_discount_trigger_nr,
 np_discount_action_nr,
 item_grp_int_sid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_non_personalized_discount_trigger_itemgroup;