CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_offer_room_type (trav_offer_room_type_cd,
trav_offer_room_type_descr) AS SELECT trav_offer_room_type_cd,
 trav_offer_room_type_cd -- DESCR is null in the source view
 AS trav_offer_room_type_descr
FROM ldl_dig_lec_share.v_dim_travel_offer_room_type_core_view
UNION ALL
SELECT '-1',
 '';