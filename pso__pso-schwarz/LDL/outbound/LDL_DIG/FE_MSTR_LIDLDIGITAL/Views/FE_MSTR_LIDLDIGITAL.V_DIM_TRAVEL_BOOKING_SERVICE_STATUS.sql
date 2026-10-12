CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_booking_service_status (trav_booking_svc_status_cd,
trav_booking_svc_status_descr) AS SELECT trav_booking_svc_status_cd,
 trav_booking_svc_status_descr
FROM ldl_dig_lec_share.v_dim_travel_booking_service_status
UNION ALL
SELECT '-1',
 '';