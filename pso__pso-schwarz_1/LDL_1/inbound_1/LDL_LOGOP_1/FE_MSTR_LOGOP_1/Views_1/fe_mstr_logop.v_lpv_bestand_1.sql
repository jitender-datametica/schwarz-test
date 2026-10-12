/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_lpv_bestand_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2025-05-23      Michal Kubica           Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    View for LPV Bestand report
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LPV_BESTAND_1(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code',
	WH_ID COMMENT 'Warehouse ID',
	ARTICLE_NR COMMENT 'Article number. PK. Original name - ANR',
	ARTICLE_DESCRIPTION COMMENT 'Article name. Original name - KTXT',
	ITEM_GROUP COMMENT 'Item_1 group. Original name - V2',
	ARTICLE_FAMILY COMMENT 'Article family. Original name - V3',
	UNIT_1 COMMENT 'Number of units for each packaging unit_1 2. Original name - ANZAHL_VPE2',
	UNIT_NAME COMMENT 'Artcile unit_1 name. Original name - UNIT_1',
	SRC_QTY COMMENT 'Quantity (number of pieces of unit_1 AST.VPE1). May be multiplied in order to display decimal places according to the global setting MengenFakt. Original name - menge',
	SRC_AREA_NR COMMENT 'Number of the area the stock is currently located in. Original name - bereich',
	SRC_PALLET_NR COMMENT 'Number of the pallet on which the stock is located. Original name - lhmnr',
	PALLET_COUNT COMMENT 'Count of pallets excluding duplicates',
	DWH_UPDATED COMMENT 'Latest update time'
) AS
SELECT 
A.CLIENT_ID, 
A.WH_ID, 
A.ARTICLE_NR, 
A.ARTICLE_DESCR, 
A.V2_ITEM_GROUP, 
A.V3_ARTICLE_FAMILY, 
TO_NUMBER(REPLACE(A.QUANTITY_UNIT2, ',', '')) /1000,
A.ARTICLE_UNIT_NAME,
TO_NUMBER(REPLACE(B.SRC_QTY, ',', ''))/1000,  
B.SRC_AREA_NR,
B.SRC_PALLET_NR,
CASE WHEN ROW_NUMBER() OVER (PARTITION BY B.SRC_PALLET_NR ORDER BY A.CLIENT_ID) = 1 THEN 1 ELSE 0 END AS PALLET_COUNT,
MAX(B.DWH_UPDATED) OVER (PARTITION BY A.CLIENT_ID, A.WH_ID) AS DWH_UPDATED
FROM "DATA".T_LPV_AST_1 A
LEFT JOIN "DATA".T_LPV_BESTAND_1 B
ON A.CLIENT_ID = B.CLIENT_ID
AND A.WH_ID = B.WH_ID 
AND A.ARTICLE_NR = B.ARTICLE_NR 
WHERE CURRENT_DATE BETWEEN A.DWH_VALID_FROM AND A.DWH_VALID_TO
AND A.DELETED_FG = FALSE
AND CURRENT_DATE BETWEEN B.DWH_VALID_FROM AND B.DWH_VALID_TO
AND B.DELETED_FG = FALSE;