CREATE OR REPLACE VIEW ldl_dig_core.v_dim_travel_offer_trip_type (trav_offer_trip_type_cd, trav_offer_trip_type_descr)
OPTIONS(DESCRIPTION = `A REGULAR VIEW TO FETCH THE DIFFERENT TRIP TYPES ASSOCIATED WITH THE TRAVEL OFFER  ( CRUISE | BATHING HOLIDAY | ROUND TRIP | …)`)
AS SELECT DISTINCT trav_offer_trip_type_cd,
 NULL AS trav_offer_trip_type_descr
FROM ldl_dig_core.t_dim_travel_offer;