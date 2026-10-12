/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_BRAND_TYPE
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-11-02 Andreas Kurz	    Initial version
#									Necessary for MSTR Lookup join
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_BRAND_TYPE
COMMENT = 'View Dimension Action Type'
AS
SELECT
	  dim.BRAND_TYPE_CD			
	, dim.BRAND_TYPE_CD_DESC	
FROM 
(
SELECT 
	  COLUMN1 AS BRAND_TYPE_CD
	, COLUMN2 AS BRAND_TYPE_CD_DESC
FROM
VALUES
     ('N/A' , 'Not Applicable')
    ,('M'  	, 'Marke')
    ,('EM'  , 'Eigenmarke')
) dim
;

--SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_BRAND_TYPE LIMIT 1;


/* --- EOF - END OF FILE --- */

