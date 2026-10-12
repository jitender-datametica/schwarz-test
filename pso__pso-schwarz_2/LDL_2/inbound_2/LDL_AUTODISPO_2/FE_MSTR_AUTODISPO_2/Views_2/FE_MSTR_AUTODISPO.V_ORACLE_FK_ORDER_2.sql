CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_ORACLE_FK_ORDER_2(
	ITEM_NR
	, DELETED
	, ORD_STORECALCULATION_ID
	, STORE
	, ORD_UNIT_ID
	, COUNTRY_2
	, ORD_ORDER_TYPE
	, ORD_CASE_SIZE
	, DATE
	, GENERATION_DATE
	, ORD_QUANTITY
	, ORD_UNIT_QUANTITY
	, ORD_PIECES_QUANTITY
	, PALLET_SPORTS
	, QUANTITY_IN_BOXES
	, AVG_QUANTITY
) AS
    /* Version: 1.2
    ** Author:    Dominik Pfarr
    ** Date:      2023-10-24
    ** Changes:   removing qualication on max(storecalc_id) as it is handled in Oracle view; setting the dates to ::date
    */	
SELECT ORD_ITEM_NR item_nr
	,DELETED
	,ORD_STORECALCULATION_ID
	,ORD_STORE_NR store
	,ORD_UNIT_ID
	,COUNTRY_2
	,ORD_ORDER_TYPE
    ,ORD_CASE_SIZE
	,DATEADD(DAY, ord_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE DATE
	,DATEADD(DAY, ORD_GEN_TIME_ID - 365.25 * (4712) - 2, '0000-01-01')::DATE GENERATION_DATE
	,ORD_QUANTITY
	,ORD_UNIT_QUANTITY
    ,ORD_PIECES_QUANTITY
	,CASE WHEN ORD_UNIT_ID = 2 THEN ROUND(ORD_QUANTITY, 0) / 2 WHEN ORD_UNIT_ID = 3 THEN ROUND(ORD_QUANTITY, 0) END pallet_sports
	,(ord_pieces_quantity / ord_case_size) AS QUANTITY_in_boxes
	,ROUND(AVG(ord_pieces_quantity / ord_case_size) OVER (
			PARTITION BY country_2
			,store
			,item_nr
			,ord_order_type
			,ord_unit_id
			,DAYOFWEEK(DATE) ORDER BY DATE ROWS BETWEEN 11 PRECEDING AND CURRENT ROW
			), 2) avg_quantity
FROM CORE.T_ORACLE_V_FK_ORDER_2
WHERE DELETED = 0 ;