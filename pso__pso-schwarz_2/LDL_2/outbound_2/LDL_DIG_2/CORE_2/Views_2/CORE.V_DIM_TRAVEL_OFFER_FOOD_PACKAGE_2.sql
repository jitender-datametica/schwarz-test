CREATE OR REPLACE VIEW ldl_dig_core.v_dim_travel_offer_food_package_2 (trav_offer_food_pack_type_cd,
trav_offer_food_pack_type_descr)
OPTIONS(DESCRIPTION = `A REGULAR VIEW TO FETCH THE CATEGORIZATION OF FOOD & BEVERAGE PACKAGES FOR TRAVEL OFFER  (ALL INCLUSIVE | HALF BOARD | …). BECAUSE OF DIFFERENT SOURCES MAY BE DIFFERENT FROM THE FOOD PACKAGE_2 IN TRAVEL BOOKING`)
AS SELECT DISTINCT trav_offer_food_pack_type_cd,
 NULL AS trav_offer_food_pack_type_descr
FROM ldl_dig_core.t_dim_travel_offer_2;