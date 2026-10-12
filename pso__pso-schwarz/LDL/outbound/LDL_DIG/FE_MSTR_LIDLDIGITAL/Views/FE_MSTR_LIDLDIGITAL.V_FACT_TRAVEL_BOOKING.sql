CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_travel_booking (trav_booking_sid, dwh_valid_from_tmsp,
dwh_valid_to_tmsp, dwh_valid_fg, booking_nr, trav_offer_sid, process_nr, cust_sid, trav_cost_center_cd,
trav_booking_channel_cd, cust_booking_ref_sid, cust_booking_ref_link, trav_booking_svc_type_cd, tour_operator_cd,
booking_dt, travel_start_dt, travel_end_dt, duration_of_travel, prebooking_days, curr_trav_booking_status_cd, cancel_dt
, child_cnt, passenger_cnt, curr_cd, init_booking_svc_price_val, init_booking_svc_provision_val,
curr_booking_svc_price_val, curr_booking_svc_provision_val, cancel_price_val, cancel_provision_val,
trav_booking_coupon_cd, coupon_price_val, is_flight_svc_avail_fg, flight_svc_cd, departure_airport_cd,
arrival_airport_cd, destination_country_cd, destination_region_name, cruise_region_name, trav_booking_room_type_cd,
trav_booking_food_pack_type_cd, is_hotel_svc_avail_fg, hotel_svc_cd, hotel_giata_nr, hotel_city_name,
is_misc_svc_avail_fg, curr_trav_booking_svc_status_cd, init_trav_booking_svc_status_cd, trav_booking_dist_sys_cd,
tour_operator_agency_cd, offer_operator_cd, trav_booking_coupon_cust_cd) AS SELECT trav_booking_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 booking_nr,
 IFNULL(trav_offer_sid, -1) AS trav_offer_sid,
 process_nr,
 IFNULL(cust_sid, -1) AS cust_sid,
  CASE
  WHEN trav_cost_center_cd = ''
  THEN '-1'
  ELSE IFNULL(trav_cost_center_cd, '-1')
  END AS trav_cost_center_cd,
  CASE
  WHEN trav_booking_channel_cd = ''
  THEN '-1'
  ELSE IFNULL(trav_booking_channel_cd, '-1')
  END AS trav_booking_channel_cd,
 IFNULL(cust_booking_ref_sid, -1) AS cust_booking_ref_sid,
 cust_booking_ref_link,
  CASE
  WHEN trav_booking_svc_type_cd = ''
  THEN '-1'
  ELSE IFNULL(trav_booking_svc_type_cd, '-1')
  END AS trav_booking_svc_type_cd,
  CASE
  WHEN tour_operator_cd = ''
  THEN '-1'
  ELSE IFNULL(tour_operator_cd, '-1')
  END AS tour_operator_cd,
 booking_dt,
 travel_start_dt,
 travel_end_dt,
 DATE_DIFF(travel_end_dt, travel_start_dt, DAY) AS duration_of_travel,
 DATE_DIFF(travel_start_dt, booking_dt, DAY) AS prebooking_days,
  CASE
  WHEN curr_trav_booking_status_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_trav_booking_status_cd, '-1')
  END AS curr_trav_booking_status_cd,
 cancel_dt,
 child_cnt,
 passenger_cnt,
  CASE
  WHEN curr_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_cd, '')
  END AS curr_cd,
 init_booking_svc_price_val,
 init_booking_svc_provision_val,
 curr_booking_svc_price_val,
 curr_booking_svc_provision_val,
 cancel_price_val,
 cancel_provision_val,
  CASE
  WHEN trav_booking_coupon_cd = ''
  THEN '-1'
  ELSE IFNULL(trav_booking_coupon_cd, '')
  END AS trav_booking_coupon_cd,
 coupon_price_val,
 is_flight_svc_avail_fg,
  CASE
  WHEN flight_svc_cd = ''
  THEN '-1'
  ELSE IFNULL(flight_svc_cd, '')
  END AS flight_svc_cd,
  CASE
  WHEN departure_airport_cd = ''
  THEN '-1'
  ELSE IFNULL(departure_airport_cd, '')
  END AS departure_airport_cd,
  CASE
  WHEN arrival_airport_cd = ''
  THEN '-1'
  ELSE IFNULL(arrival_airport_cd, '')
  END AS arrival_airport_cd,
  CASE
  WHEN destination_country_cd = ''
  THEN '-1'
  ELSE IFNULL(destination_country_cd, '')
  END AS destination_country_cd,
 destination_region_name,
 cruise_region_name,
  CASE
  WHEN trav_booking_room_type_cd = ''
  THEN '-1'
  ELSE IFNULL(trav_booking_room_type_cd, '-1')
  END AS trav_booking_room_type_cd,
  CASE
  WHEN trav_booking_food_pack_type_cd = ''
  THEN '-1'
  ELSE IFNULL(trav_booking_food_pack_type_cd, '-1')
  END AS trav_booking_food_pack_type_cd,
 is_hotel_svc_avail_fg,
  CASE
  WHEN hotel_svc_cd = ''
  THEN '-1'
  ELSE IFNULL(hotel_svc_cd, '')
  END AS hotel_svc_cd,
 hotel_giata_nr,
 hotel_city_name,
 is_misc_svc_avail_fg,
  CASE
  WHEN curr_trav_booking_svc_status_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_trav_booking_svc_status_cd, '-1')
  END AS curr_trav_booking_svc_status_cd,
  CASE
  WHEN init_trav_booking_svc_status_cd = ''
  THEN '-1'
  ELSE IFNULL(init_trav_booking_svc_status_cd, '-1')
  END AS init_trav_booking_svc_status_cd,
  CASE
  WHEN trav_booking_dist_sys_cd = ''
  THEN '-1'
  ELSE IFNULL(trav_booking_dist_sys_cd, '-1')
  END AS trav_booking_dist_sys_cd,
  CASE
  WHEN tour_operator_agency_cd = ''
  THEN '-1'
  ELSE IFNULL(tour_operator_agency_cd, '-1')
  END AS tour_operator_agency_cd,
  CASE
  WHEN offer_operator_cd = ''
  THEN '-1'
  ELSE IFNULL(offer_operator_cd, '-1')
  END AS offer_operator_cd,
  CASE
  WHEN trav_booking_coupon_cust_cd = ''
  THEN '-1'
  ELSE IFNULL(trav_booking_coupon_cust_cd, '')
  END AS trav_booking_coupon_cust_cd
FROM ldl_dig_lec_share.v_fact_travel_booking
WHERE dwh_valid_fg;