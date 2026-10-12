CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_non_personalized_discount_1 (client_id
OPTIONS(description='unique identifier of the DWH client / slice.'), np_discount_sid
OPTIONS(description='Surrogate Key of the non personalized discount.'), local_np_discount_nr
OPTIONS(description='Unique identifier of  a non personalized discount within the country_1/ tenant.'), np_discount_nr
OPTIONS(description='Global unique identifier of  a non personalized discount.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `Non-personalized discount, excluding Lidl Plus.`) AS SELECT client_id,
 np_discount_sid,
 local_np_discount_nr,
 np_discount_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_non_personalized_discount_1;