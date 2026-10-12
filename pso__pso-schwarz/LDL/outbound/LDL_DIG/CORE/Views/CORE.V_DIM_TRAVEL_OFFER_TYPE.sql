CREATE OR REPLACE VIEW ldl_dig_core.v_dim_travel_offer_type (trav_offer_type_lvl1_name, trav_offer_type_lvl2_name,
trav_offer_type_lvl3_name, trav_offer_type_lvl4_name)
OPTIONS(DESCRIPTION = `A REGULAR VIEW TO FETCH THE CATEGORIZATION OF OFFER (4 LEVELS OF HIERARCHY)`) AS SELECT DISTINCT
 trav_offer_type_lvl1_name,
 trav_offer_type_lvl2_name,
 trav_offer_type_lvl3_name,
 trav_offer_type_lvl4_name
FROM ldl_dig_core.t_dim_travel_offer;