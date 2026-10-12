CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_booking_room_type_2 (trav_booking_room_type_cd,
trav_booking_room_type_descr, trav_booking_room_type_group_cd) AS SELECT trav_booking_room_type_cd,
 trav_booking_room_type_descr,
  CASE
  WHEN trav_booking_room_type_group_cd = ''
  THEN '-1'
  ELSE IFNULL(trav_booking_room_type_group_cd, '-1')
  END AS trav_booking_room_type_group_cd
FROM ldl_dig_lec_share.v_dim_travel_booking_room_type_2
UNION ALL
SELECT '-1',
 '',
 '-1';