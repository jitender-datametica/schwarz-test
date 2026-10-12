/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	fe_mstr_logop.V_LPV_WH_UTILIZATION_KPI_1
Description		|	lpv warehouseutilization - view with KPIs
====================================================================================================
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LPV_WH_UTILIZATION_KPI_1(
   CLIENT_ID  COMMENT 'Client id - calculated based on the country_1 code'
 , WH_ID  COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)'
 , GANG_NR  COMMENT 'GR date. Original name - datum'
 , AREA_NR  COMMENT 'Number of the area the stock is currently located in. FK: References LPV.BEREICH.NR. Original name - BEREICH'
 , CAL_DT COMMENT 'REFERENCE DATE'
 , DWH_UPDATED COMMENT 'Record updated at'
 , TOTAL_BINS COMMENT 'COUNT OF LOCATION_ID'
 , BIN_CAPACITY  COMMENT 'Location_1 capacity. Original name - PLATZ'
 , BIN_CAPACITY_AVAILABLE  COMMENT 'Free location_1 capacity. Original name - PLATZ_V'
 , BLOCKED_BINS  COMMENT 'Whether the location_1 is currently locked. V = No block. S = Blocked. Original name - SPERRE'
) AS
SELECT
   CLIENT_ID
 , WH_ID
 , GANG_NR
 , AREA_NR
 , CAL_DT
 , DWH_UPDATED
 , TOTAL_BINS
 , BIN_CAPACITY
 , BIN_CAPACITY_AVAILABLE
 , BLOCKED_BINS
FROM FE_MSTR_LOGOP.V_LPV_WH_UTILIZATION_AAD_1
;
