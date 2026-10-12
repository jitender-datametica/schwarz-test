CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_non_personalized_discount_hist_2 (client_id
OPTIONS(description='unique identifier of the DWH client / slice'), np_discount_sid
OPTIONS(description='Foreign Key for t_non_personalized_discount_2'), np_discount_status_cd
OPTIONS(description='Status_2 of the non personalized discount.'), np_discount_start_dt
OPTIONS(description='Start date of the non personalized discount.'), np_discount_end_dt
OPTIONS(description='End date of the non personalized discount.'), np_discount_booking_type_id
OPTIONS(description='Price change reason (analogous to ERP price change reasons) to be used for the discount.'),
np_discount_descr OPTIONS(description='Description of the non personalized discount.'), receipt_np_discount_name
OPTIONS(description='Name to be displayed in the discount line on the receipt.'), prev_np_discount_sid
OPTIONS(description='Surrogate Key of the predecessor of a non personalized discount.'), deleted_fg
OPTIONS(description='relation was not delivered by source system (anymore), if deleted_fg=1'), dwh_valid_from
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table contains the non personalised discount (historised version).`) AS SELECT client_id,
 np_discount_sid,
 np_discount_status_cd,
 np_discount_start_dt,
 np_discount_end_dt,
 np_discount_booking_type_id,
 np_discount_descr,
 receipt_np_discount_name,
 prev_np_discount_sid,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_non_personalized_discount_hist_2;