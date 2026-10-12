CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_booking_distribution_system_2 (trav_booking_dist_sys_cd,
trav_booking_dist_sys_descr) AS SELECT trav_booking_dist_sys_cd,
 trav_booking_dist_sys_descr
FROM ldl_dig_lec_share.v_dim_travel_booking_distribution_system_2
UNION ALL
SELECT '-1',
 '';