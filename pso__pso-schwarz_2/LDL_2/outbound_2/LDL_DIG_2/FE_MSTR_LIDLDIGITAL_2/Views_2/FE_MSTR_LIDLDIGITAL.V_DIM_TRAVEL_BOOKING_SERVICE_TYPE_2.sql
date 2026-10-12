CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_booking_service_type_2 (trav_booking_svc_type_cd,
trav_booking_svc_type_descr) AS SELECT trav_booking_svc_type_cd,
 trav_booking_svc_type_descr
FROM ldl_dig_lec_share.v_dim_travel_booking_service_type_2
UNION ALL
SELECT '-1',
 '';