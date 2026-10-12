CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_travel_booking_passenger_2 (trav_booking_sid,
dwh_valid_from_tmsp, dwh_valid_to_tmsp, dwh_valid_fg, passenger_salutation, passenger_full_name, passenger_birth_year,
dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, src_file_tmsp) AS SELECT trav_booking_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 passenger_salutation,
 passenger_full_name,
 passenger_birth_year,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_src_file_name,
 src_file_tmsp
FROM ldl_dig_lec_share.v_fact_travel_booking_passenger_2;