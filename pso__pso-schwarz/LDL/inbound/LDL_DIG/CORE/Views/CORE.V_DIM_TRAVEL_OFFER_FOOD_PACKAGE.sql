CREATE OR REPLACE VIEW CORE.V_DIM_TRAVEL_OFFER_FOOD_PACKAGE(
	TRAV_OFFER_FOOD_PACK_TYPE_CD,
	TRAV_OFFER_FOOD_PACK_TYPE_DESCR
) COMMENT='A regular view to fetch the categorization of food & beverage packages for travel offer  (All inclusive | half board | …). Because of different sources may be different from the food package in travel booking'
 AS
SELECT DISTINCT TRAV_OFFER_FOOD_PACK_TYPE_CD,
       NULL AS TRAV_OFFER_FOOD_PACK_TYPE_DESCR
FROM CORE.T_DIM_TRAVEL_OFFER;