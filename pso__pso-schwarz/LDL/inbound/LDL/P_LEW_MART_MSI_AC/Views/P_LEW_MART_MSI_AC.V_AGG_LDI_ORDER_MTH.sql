/*
 * ----------------------------------------------------------------------------
 *  History:
 * 
 *   Vrs Date       Developer               Task
 *   --- ---------- ----------------------- --------------------------------
 *   1.0 2022-11-07 Andrzej Wandtke         AP0140749 CC Dashboard - Initial version 
 * ----------------------------------------------------------------------------
 */


CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_AGG_LDI_ORDER_MTH
AS
SELECT
 CLIENT_ID
,CLIENT_ID_ONLINE
,CY
,CY_MONTH 
,ORDER_CNT_MTH 
,ORDER_LINE_CNT_MTH
FROM P_LEW_MART_MSI.V_AGG_LDI_ORDER_MTH
;