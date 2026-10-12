CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_booking_channel (trav_booking_channel_cd,
trav_booking_channel_descr) AS SELECT trav_booking_channel_cd,
 trav_booking_channel_descr
FROM ldl_dig_lec_share.v_dim_travel_booking_channel
UNION ALL
SELECT '-1',
 '';