CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_non_personalized_discount_store_hist (client_id
OPTIONS(description='unique identifier of the DWH client / slice.'), np_discount_sid
OPTIONS(description='Surrogate Key of the non personalized discount.'), store_loc_sid
OPTIONS(description='Surrogate Key LOCATION (eindeutig ueber alle Laender / Mandanten hinweg).'), deleted_fg
OPTIONS(description='relation was not delivered by source system (anymore), if deleted_fg=1'), dwh_valid_from
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This tables contains the Store for which the non-personalized promotion is valid.(historised version).`)
AS SELECT client_id,
 np_discount_sid,
 store_loc_sid,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_non_personalized_discount_store_hist;