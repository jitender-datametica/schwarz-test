CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_offer_trip_type_1 (trav_offer_trip_type_cd,
trav_offer_trip_type_descr) AS SELECT trav_offer_trip_type_cd,
 trav_offer_trip_type_cd AS trav_offer_trip_type_descr
FROM ldl_dig_lec_share.v_dim_travel_offer_trip_type_core_view_1
UNION ALL
SELECT '-1',
 '';