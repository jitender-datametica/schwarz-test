CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_coupon_to_item_hist_2 (client_id
OPTIONS(description='unique identifier of the DWH client / slice'), coupon_sid
OPTIONS(description='unique identifier of the Coupon (surrogate key)'), item_sid
OPTIONS(description='unique identifier of the Item_2 that is linked to the coupon (surrogate key)'), loyalty_prog_cd
OPTIONS(description='identifier of the loyalty program the coupon belongs to'), coupon_relation_type_cd
OPTIONS(description='code identifying how the item_2 is related to the coupon'), participating_in_benefit_fg
OPTIONS(description='Flag which indicates whether the benefit of the coupon is related to the item_2 or not. Example: If a certain item_2 is purchased, then a benefit for another item_2 will be provided in the coupon. Both items are related to the coupon, but the benefit is related to just one of them.'),
deleted_fg
OPTIONS(description='Mapping is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.'),
dwh_valid_from
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.')) AS SELECT client_id,
 coupon_sid,
 item_sid,
 loyalty_prog_cd,
 coupon_relation_type_cd,
 participating_in_benefit_fg,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_coupon_to_item_hist_2;