/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	fe_mstr_logop.v_lpv_warehouseutilization_kpi
Description		|	lpv warehouseutilization - view with KPIs
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LPV_WAREHOUSEUTILIZATION_KPI(
	CLIENT_ID COMMENT 'Client id - calculated based on the country code',
	WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	GR_DATE COMMENT 'GR date. Original name - datum',
	LOCATION_ID COMMENT 'Internal location number. Primary key. Original name - ORT',
	LOCATION_NAME COMMENT 'Location label. Original name - BEZ',
	GANG_NR COMMENT 'Calculated from FIXBIN_ID - the first 2 digits of location ID',
	AREA_NR COMMENT 'Number of the area the stock is currently located in. FK: References LPV.BEREICH.NR. Original name - BEREICH',
	SRC_AREA_NR COMMENT 'Number of the area the stock is currently located in. Original name - bereich',
	STOCK_ID COMMENT 'Surrogate key: Internal ID. Primary key. Original name - bestandid',
	SRC_PALLET_NR COMMENT 'Number of the pallet on which the stock is located. Original name - lhmnr',
	ARTICLE_NR COMMENT 'Article number. Original name - anr',
	BLOCK_CD COMMENT 'Whether the location is currently locked. V = No block. S = Blocked. Original name - SPERRE',
	CAPACITY COMMENT 'Location capacity. Original name - PLATZ',
	CAPACITY_AVAILABLE COMMENT 'Free location capacity. Original name - PLATZ_V',
	PICKING_INDICATOR COMMENT 'Indicator whether the location is assigned to an article as a picking laction (table LPV.ASTBER). Original name - FIXPLATZ',
	SRC_QTY COMMENT 'Quantity (number of pieces of unit AST.VPE1). May be multiplied in order to display decimal places according to the global setting MengenFakt. Original name - menge',
	DWH_UPDATED COMMENT 'Record updated at',
	DWH_VALID_FROM COMMENT 'Valid from date',
	DWH_VALID_TO COMMENT 'Valid to date'
) AS
SELECT 
	 client_id
	, wh_id
	, gr_date
	, location_id
	, location_name
	, gang_nr
	, area_nr
	, src_area_nr
	, stock_id
	, src_pallet_nr
	, article_nr
	, block_cd
	, capacity
	, capacity_available
	, picking_indicator
	, src_qty
	, dwh_updated
	, dwh_valid_from 
	, dwh_valid_to
FROM FE_MSTR_LOGOP.V_LPV_WAREHOUSEUTILIZATION_ADD;