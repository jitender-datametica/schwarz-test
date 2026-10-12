/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	fe_mstr_logop.V_LPV_WH_UTILIZATION_AAD_1
Description		|	lpv warehouseutilization - view with additional columns

====================================================================================================
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LPV_WH_UTILIZATION_AAD_1(
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

WITH WHX AS
(
    SELECT DISTINCT
       W.CLIENT_ID
     , W.WH_ID
     , W.LOCATION_ID
     , W.LOCATION_NAME
     , CONCAT('AISLE', ' ', SUBSTRING(W.LOCATION_ID, 1, 2)) AS GANG_NR
     , W.AREA_NR
     , IFF(W.BLOCK_CD = 'S',1,0) AS BLOCK_CD
     , IFF(W.CAPACITY >= 1000, W.CAPACITY/960000, W.CAPACITY) AS CAPACITY
     , IFF(W.CAPACITY_AVAILABLE >= 1000, W.CAPACITY_AVAILABLE/960000, CAPACITY_AVAILABLE) AS CAPACITY_AVAILABLE
     , MAX(W.DWH_UPDATED) OVER (PARTITION BY W.CLIENT_ID, W.WH_ID ) AS DWH_UPDATED
     , W.DWH_VALID_FROM
     , W.DWH_VALID_TO
    FROM "DATA".T_LPV_WHX_1 W
    WHERE  W.DELETED_FG = FALSE 
        AND W.AREA_NR BETWEEN 700 AND 899
)

SELECT
   WHX.CLIENT_ID
 , WHX.WH_ID
 , WHX.GANG_NR
 , WHX.AREA_NR
 , CAL_DT
 , WHX.DWH_UPDATED
 , COUNT(WHX.LOCATION_ID) AS TOTAL_BINS
 , SUM(WHX.CAPACITY) AS BIN_CAPACITY
 , SUM(WHX.CAPACITY_AVAILABLE) AS BIN_CAPACITY_AVAILABLE
 , SUM(WHX.BLOCK_CD) AS BLOCKED_BINS

FROM WHX

INNER JOIN DATA.T_CAL_CALENDARDAY_1 C
    ON CAL_DT BETWEEN WHX.DWH_VALID_FROM AND WHX.DWH_VALID_TO

WHERE 
	C.CAL_DT BETWEEN CURRENT_DATE-185 AND CURRENT_DATE
GROUP BY
   WHX.CLIENT_ID
 , WHX.WH_ID
 , WHX.GANG_NR
 , WHX.AREA_NR
 , CAL_DT
 , WHX.DWH_UPDATED
;