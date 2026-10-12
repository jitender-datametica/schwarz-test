CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_booking_food_package_1 (trav_booking_food_pack_type_cd,
trav_booking_food_pack_type_descr) AS SELECT trav_booking_food_pack_type_cd,
 trav_booking_food_pack_type_descr
FROM ldl_dig_lec_share.v_dim_travel_booking_food_package_1
UNION ALL
SELECT '-1',
 '';