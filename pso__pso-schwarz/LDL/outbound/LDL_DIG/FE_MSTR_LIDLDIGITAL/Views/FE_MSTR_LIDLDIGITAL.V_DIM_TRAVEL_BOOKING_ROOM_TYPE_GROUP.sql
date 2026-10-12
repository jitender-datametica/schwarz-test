/*
    A real dimension table for TRAV_BOOKING_ROOM_TYPE_GROUP is not provided.
    This view can be used in MSTR to filter for a TRAV_BOOKING_ROOM_TYPE_GROUP.
*/


CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_booking_room_type_group (trav_booking_room_type_group_cd
, trav_booking_room_type_group_descr) AS SELECT DISTINCT trav_booking_room_type_group_cd,
 trav_booking_room_type_group_cd AS trav_booking_room_type_group_descr
FROM ldl_dig_lec_share.v_dim_travel_booking_room_type
UNION ALL
SELECT '-1',
 '';