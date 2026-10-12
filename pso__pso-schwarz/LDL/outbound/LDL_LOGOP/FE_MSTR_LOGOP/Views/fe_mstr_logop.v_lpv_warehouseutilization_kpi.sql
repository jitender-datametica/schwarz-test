/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	fe_mstr_logop.v_lpv_warehouseutilization_kpi
Description		|	lpv warehouseutilization - view with KPIs
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_warehouseutilization_kpi (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), gr_date
OPTIONS(description='GR date. Original name - datum'), location_id
OPTIONS(description='Internal location number. Primary key. Original name - ORT'), location_name
OPTIONS(description='Location label. Original name - BEZ'), gang_nr
OPTIONS(description='Calculated from FIXBIN_ID - the first 2 digits of location ID'), area_nr
OPTIONS(description='Number of the area the stock is currently located in. FK: References LPV.BEREICH.NR. Original name - BEREICH'),
src_area_nr OPTIONS(description='Number of the area the stock is currently located in. Original name - bereich'),
stock_id OPTIONS(description='Surrogate key: Internal ID. Primary key. Original name - bestandid'), src_pallet_nr
OPTIONS(description='Number of the pallet on which the stock is located. Original name - lhmnr'), article_nr
OPTIONS(description='Article number. Original name - anr'), block_cd
OPTIONS(description='Whether the location is currently locked. V = No block. S = Blocked. Original name - SPERRE'),
capacity OPTIONS(description='Location capacity. Original name - PLATZ'), capacity_available
OPTIONS(description='Free location capacity. Original name - PLATZ_V'), picking_indicator
OPTIONS(description='Indicator whether the location is assigned to an article as a picking laction (table LPV.ASTBER). Original name - FIXPLATZ'),
src_qty
OPTIONS(description='Quantity (number of pieces of unit AST.VPE1). May be multiplied in order to display decimal places according to the global setting MengenFakt. Original name - menge'),
dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'),
dwh_valid_to OPTIONS(description='Valid to date')) AS SELECT *
FROM ldl_logop_fe_mstr_logop.v_lpv_warehouseutilization_add;