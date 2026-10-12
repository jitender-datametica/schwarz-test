/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_BRAND_NAME
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-11-02 Andreas Kurz	    Initial version
#									Necessary for MSTR Lookup join
#  1.1  2025-01-15 Nikolai Toknov	Change view (only T_AGG_REGION_CENTRAL_NAN)
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE DATABASE	LDL_PRODUCTION_CLONE_PIT_QS;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_BRAND_NAME
COMMENT = 'View Dimension Brand Name'
AS
SELECT 
	BRAND_NAME
FROM
(	
	SELECT BRAND_NAME FROM P_LEW_FE_MSTR_PIT.T_AGG_REGION_CENTRAL_NAN 	WHERE TRUE AND DELETED_FG = 0 AND REJECT_FG = 0 GROUP BY 1

	UNION ALL
	-- Add Default Value
	SELECT
		dim.BRAND_NAME	
	FROM 
	(
	SELECT 
		COLUMN1 AS BRAND_NAME
	FROM
	VALUES
		('N/A')
	) dim
) 
GROUP BY 1
;

--SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_BRAND_NAME LIMIT 100;


/* --- EOF - END OF FILE --- */

