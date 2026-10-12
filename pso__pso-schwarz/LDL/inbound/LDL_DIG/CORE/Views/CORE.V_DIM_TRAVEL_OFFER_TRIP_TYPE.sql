CREATE OR REPLACE VIEW CORE.V_DIM_TRAVEL_OFFER_TRIP_TYPE(
	TRAV_OFFER_TRIP_TYPE_CD,
	TRAV_OFFER_TRIP_TYPE_DESCR
) COMMENT='A regular view to fetch the different trip types associated with the travel offer  ( Cruise | bathing holiday | round trip | …)'
 AS
SELECT DISTINCT TRAV_OFFER_TRIP_TYPE_CD,
       NULL AS TRAV_OFFER_TRIP_TYPE_DESCR
FROM CORE.T_DIM_TRAVEL_OFFER;