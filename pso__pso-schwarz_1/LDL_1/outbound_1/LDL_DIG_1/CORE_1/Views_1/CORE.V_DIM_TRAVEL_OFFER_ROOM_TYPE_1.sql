CREATE OR REPLACE VIEW ldl_dig_core.v_dim_travel_offer_room_type_1 (trav_offer_room_type_cd, trav_offer_room_type_descr)
OPTIONS(DESCRIPTION = `A REGULAR VIEW TO FETCH THE CATEGORIZATION OF ROOM TYPE FOR TRAVEL OFFER  (SINGLE | DOUBLE |..)`)
AS SELECT DISTINCT trav_offer_room_type_cd,
 NULL AS trav_offer_room_type_descr
FROM ldl_dig_core.t_dim_travel_offer_1;