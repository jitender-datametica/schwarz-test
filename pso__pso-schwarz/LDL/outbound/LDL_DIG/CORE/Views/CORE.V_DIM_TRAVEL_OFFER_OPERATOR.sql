CREATE OR REPLACE VIEW ldl_dig_core.v_dim_travel_offer_operator (trav_offer_operator_cd, trav_offer_operator_descr)
OPTIONS(DESCRIPTION = `A REGULAR VIEW TO FETCH THE DISTINCT OFFER OPERATOR CODES FROM TRAVEL BOOKING FACT`) AS SELECT
DISTINCT offer_operator_cd AS trav_offer_operator_cd,
 NULL AS trav_offer_operator_descr
FROM ldl_dig_core.t_fact_travel_booking;