/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_lpv_warehouseutilization_add_1
Description		|	lpv warehouseutilization - view with additional columns
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LPV_WAREHOUSEUTILIZATION_ADD_1(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code',
	WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	GR_DATE COMMENT 'GR date. Original name - datum',
	LOCATION_ID COMMENT 'Internal location_1 number. Primary key. Original name - ORT',
	LOCATION_NAME COMMENT 'Location_1 label. Original name - BEZ',
	GANG_NR COMMENT 'Calculated from FIXBIN_ID - the first 2 digits of location_1 ID',
	AREA_NR COMMENT 'Number of the area the stock is currently located in. FK: References LPV.BEREICH.NR. Original name - BEREICH',
	SRC_AREA_NR COMMENT 'Number of the area the stock is currently located in. Original name - bereich',
	STOCK_ID COMMENT 'Surrogate key: Internal ID. Primary key. Original name - bestandid',
	SRC_PALLET_NR COMMENT 'Number of the pallet on which the stock is located. Original name - lhmnr',
	ARTICLE_NR COMMENT 'Article number. Original name - anr',
	BLOCK_CD COMMENT 'Whether the location_1 is currently locked. V = No block. S = Blocked. Original name - SPERRE',
	CAPACITY COMMENT 'Location_1 capacity. Original name - PLATZ',
	CAPACITY_AVAILABLE COMMENT 'Free location_1 capacity. Original name - PLATZ_V',
	PICKING_INDICATOR COMMENT 'Indicator whether the location_1 is assigned to an article as a picking laction (table LPV.ASTBER). Original name - FIXPLATZ',
	SRC_QTY COMMENT 'Quantity (number of pieces of unit_1 AST.VPE1). May be multiplied in order to display decimal places according to the global setting MengenFakt. Original name - menge',
	DWH_UPDATED COMMENT 'Record updated at',
	DWH_VALID_FROM COMMENT 'Valid from date',
	DWH_VALID_TO COMMENT 'Valid to date'
) AS
WITH bestand AS ( 
SELECT 
	client_id, 
	wh_id, 
	gr_date, 
	src_area_nr, 
	stock_id, 
	src_pallet_nr, 
	article_nr, 
	src_qty, 
	dwh_updated 
FROM "DATA".t_lpv_bestand_1 
	WHERE /*CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to AND */ deleted_fg = FALSE 
), 
whx AS ( 
SELECT 
	client_id, 
	wh_id, 
	location_id, 
	location_name, 
	CONCAT('Aisle', ' ', SUBSTRING(location_id, 1, 2)) AS gang_nr, 
	area_nr, 
	IFF(block_cd = 'S', 'Blocked', 'No Block') AS block_cd, 
	IFF(capacity >= 1000, capacity/960000, capacity) AS capacity, 
	IFF(capacity_available >= 1000, capacity_available/960000, capacity_available) AS capacity_available,
	picking_indicator,
	dwh_valid_from,
	dwh_valid_to
FROM "DATA".t_lpv_whx_1 
	WHERE /*CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to AND */ deleted_fg = FALSE ) 
SELECT 
	w.client_id, 
	w.wh_id, 
	be.gr_date, 
	w.location_id, 
	w.location_name, 
	w.gang_nr, 
	w.area_nr,
	area.area_descr,
	/*CASE
		WHEN (area.area_descr IN ( 'Reserve-Bereich HRL', 'Reserve-Bereich', 'Reserve Area RACK', 'Kommissionier-Bereich HRL', 'Reserve Area RACK NEW2')) THEN 'Ambient'
		WHEN (area.area_descr IN ( 'Reserve-Bereich FRISCHE', 'Reserve Area CHILLER', 'Reserve Area CHILLER NEW2', '')) THEN 'Chiller'
		WHEN (area.area_descr IN ( 'Reserve-Bereich TIKO', 'Reserve Area FREEZER')) THEN 'Freezer'
		WHEN (area.area_descr IN ( 'Reserve-Bereich Block', 'Reserve-Bereich BLOCK')) THEN 'Block'
		WHEN (area.area_descr IN ( 'Reserve-Bereich SCHOKO')) THEN 'Schoko'
		WHEN (area.area_descr IN ( 'Reserve-Bereich NONFOOD', 'Reserve-Bereich NON-FOOD')) THEN 'NonFood'
		ELSE 'Unassigned'
	END AS area, */ 
	MAX(be.stock_id) AS stock_id, 
	MAX(be.src_pallet_nr) AS src_pallet_nr, 
	MAX(be.article_nr) AS article_nr, 
	w.block_cd, 
	w.capacity, 
	w.capacity_available, 
	w.picking_indicator, 
	MAX(be.src_qty) AS src_qty, 
	MAX(be.dwh_updated) AS dwh_updated, 
	w.dwh_valid_from,
	w.dwh_valid_to
FROM whx w 
LEFT JOIN bestand be 
ON w.client_id = be.client_id 
AND w.wh_id = be.wh_id 
	AND w.area_nr = be.src_area_nr
LEFT JOIN "DATA".T_LPV_AREA_1 area
ON w.client_id = area.client_id 
AND w.wh_id = area.wh_id 
	AND w.area_nr = area.area_nr
WHERE w.area_nr BETWEEN 700 AND 899 -- only reserves should be taken into ACCOUNT_1
AND be.GR_DATE BETWEEN w.dwh_valid_from AND w.dwh_valid_to -- show history data
GROUP BY 
	w.client_id, 
	w.wh_id, 
	be.gr_date, 
	w.location_id, 
	w.location_name, 
	w.gang_nr, 
	w.area_nr,
	area.area_descr,
	w.block_cd, 
	w.capacity, 
	w.capacity_available, 
	w.picking_indicator,
	w.dwh_valid_from,
	w.dwh_valid_to;