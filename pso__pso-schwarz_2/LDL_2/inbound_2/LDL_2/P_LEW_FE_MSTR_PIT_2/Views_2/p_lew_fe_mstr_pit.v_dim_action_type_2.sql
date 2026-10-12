/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_ACTION_TYPE
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_2 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-12-20 Andreas Kurz	    Initial version
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

-- LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT
--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
--SELECT GET_DDL('view','P_LEW_FE_MSTR_PIT.V_DIM_ACTION_TYPE_2');
*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status_2
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ACTION_TYPE_2
COMMENT = 'View Dimension Action Type'
AS
SELECT
	  typ.ACTION_TYPE_ID			
	, typ.FE_MSTR_RELEVANT_FG		
	, typ.ACTION_TYPE_SORT_VAL	
	, typ.ACTION_TYPE_NAME		
	, typ.ACTION_TYPE_DESCR		
	, typ.VALID_FROM_DT			
	, typ.VALID_TO_DT				
	, typ.VERSION_NR				
	, typ.CURRENT_FG				
	, typ.REJECT_FG				
	, typ.REJECT_REASON_ID		
	, typ.DELETED_FG				
	, typ.DWH_CREATED_TS			
	, typ.DWH_UPDATED_TS			
	, typ.LOAD_ID										
FROM P_LEW_MART_PIT.T_DIM_ACTION_TYPE_2 typ
WHERE TRUE

	-- Restrict ActionsType
	AND typ.ACTION_TYPE_ID IN (2,3,11,12,-1000,-2000)
	
	AND typ.DELETED_FG 	= 0
	AND typ.REJECT_FG	= 0
	AND typ.CURRENT_FG	= 1
	
QUALIFY VERSION_NR = MAX(typ.VERSION_NR) OVER (PARTITION BY typ.ACTION_TYPE_ID)
;	

--SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ACTION_TYPE_2 LIMIT 1;


/* --- EOF - END OF FILE --- */

