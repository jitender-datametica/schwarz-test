CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_booking_number (booking_nr, booking_dt, travel_start_dt
, travel_end_dt, cancel_dt) AS SELECT DISTINCT booking_nr,
 booking_dt,
 travel_start_dt,
 travel_end_dt,
 cancel_dt
FROM ldl_dig_lec_share.v_fact_travel_booking
WHERE dwh_valid_fg
UNION ALL
SELECT '-1',
 DATE('1900-01-01'),
 DATE('1900-01-01'),
 DATE('1900-01-01'),
 DATE('1900-01-01');