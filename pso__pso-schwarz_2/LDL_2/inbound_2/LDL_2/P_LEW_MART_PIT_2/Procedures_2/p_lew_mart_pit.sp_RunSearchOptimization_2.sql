/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_RunSearchOptimization
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE         R_LDL_D_PIT_ETL;
USE WAREHOUSE     WH_LDL_D_PIT_ETL_2XL;
USE DATABASE LDL_PRODUCTION_CLONE_PIT_CLONE_PARAM_TESTING;
USE SCHEMA          P_LEW_MART_PIT_2;

	DROP PROCEDURE IF EXISTS P_LEW_MART_PIT.sp_RunSearchOptimization(STRING, STRING, STRING, DOUBLE, STRING)
	;
	-- DESCRIBE PROCEDURE sp_RunSearchOptimization(STRING, STRING, STRING, DOUBLE, STRING)
	-- SHOW USER PROCEDURES
	-- SELECT get_ddl('PROCEDURE','sp_RunSearchOptimization')
	-- Check QH: SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));

	Call sp_RunSearchOptimization('P_LEW_MART_PIT_2','PITonCloud','Performance','0',100,FALSE);

 */
/* 
---------------------------------------------------------------------
PROCEDURE	:	sp_RunSearchOptimization(pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING )
Input		:   pSchema 				STRING 
				pApplicationName 		STRING
				pModuleName 			STRING 		
    			pRunClusteringDesc    	STRING --> [0] running in sequence
    			pMaxRuns				INTEGER
				pLogging				BOOLEAN	
Return		:	Error + Error Msg or in success case number of processed Tables
Convert		:	None    
Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
                Logging is also enables  but must be enabled! 
Example		:	Call sp_RunSearchOptimization('P_LEW_MART_PIT_2','PITonCloud','SearchOptimization',' ',100,FALSE);
SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_RunSearchOptimization (
      pSchema      			STRING 
	, pApplicationName 		STRING 
	, pModuleName 			STRING 		
	, pRunClusteringDesc    STRING  
	, pMaxRuns				DOUBLE
	, pLogging				BOOLEAN	
)
  RETURNS STRING
  LANGUAGE javascript
  STRICT
  EXECUTE AS CALLER
  AS
  $$
		var _rowCnt = 0, iCnt = 0, iMaxRuns = 100, strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmtLogStart = "", sqlStmtLogEnd = "", sqlStmt = "";
		var _bLogging = new Boolean("false");
        
		if ((PLOGGING === "") || (typeof(PLOGGING) === "undefined") || (PLOGGING === null)) {
			_bLogging = Boolean("false");
		} else {
			_bLogging = Boolean(PLOGGING);
		}
        
		if ((PMAXRUNS == "") || (PMAXRUNS == null) || (Number.isNaN(PMAXRUNS) == true)) { 
			PMAXRUNS = iMaxRuns; 
		} else {
			iMaxRuns = PMAXRUNS;
		}
		
		// CHECK INPUT runcluster 
		if ((PRUNCLUSTERINGDESC === "") || (typeof(PRUNCLUSTERINGDESC) === "undefined") || (PRUNCLUSTERINGDESC.length === 0) || (PRUNCLUSTERINGDESC === null)) { 
			PRUNCLUSTERINGDESC = strRunCluster; 
		} else {
			strRunCluster = PRUNCLUSTERINGDESC.toUpperCase();
		}	
		
		sqlStmt = "";
		sqlStmt = `
				SELECT DISTINCT
					  pit.Table_Schema
				FROM
					(
						SELECT
							  UPPER(TRIM(COLUMN1)) 				AS _Schema_Name
							, UPPER(TRIM(COLUMN2)) 				AS _Table_Name
							, _Schema_Name || '.' || _Table_Name 	AS Table_Schema	
						FROM
						(
						VALUES
							 ('P_LEW_MART_PIT_2','T_A_ADV_PERIOD_2')
							,('P_LEW_MART_PIT_2','T_A_ADV_WEEK_2')
							,('P_LEW_MART_PIT_2','T_A_ADV_WEEK_THEME')
							,('P_LEW_MART_PIT_2','T_A_REGION_ADV_WEEK_NAN')
							,('P_LEW_MART_PIT_2','T_CNTL_DIM_REJECT_REASON_2')
							,('P_LEW_MART_PIT_2','T_CNTL_DIM_UPI')
							,('P_LEW_MART_PIT_2','T_CNTL_PROCESSING_PARAM_NORMALIZED_2')
							,('P_LEW_MART_PIT_2','T_CNTL_UPI_DATA')
							,('P_LEW_MART_PIT_2','T_DIM_ADV_MEDIUM_HIER_2')
							,('P_LEW_MART_PIT_2','T_DIM_ADV_PERIOD_2')
							,('P_LEW_MART_PIT_2','T_DIM_ADV_THEME')
							,('P_LEW_MART_PIT_2','T_DIM_ADV_THEME_GRP')
							,('P_LEW_MART_PIT_2','T_F_STORE_DAY_ITEM_2')
							,('P_LEW_MART_PIT_2','T_CNTL_ETL_LOGGING_RUN_SEQ_2')
							--,('P_LEW_MART_PIT_2','T_CNTL_DIM_A_LEVEL')
							,('P_LEW_MART_PIT_2','T_CNTL_ETL_LOGGING_2')
							,('P_LEW_MART_PIT_2','T_DIM_ADV_WEEK_2')
							,('P_LEW_MART_PIT_2','T_DIM_ITEM_GRP_INT_2')
							,('P_LEW_MART_PIT_2','T_F_DELIVERY_WH_ITEM_2')
							,('P_LEW_MART_PIT_2','T_CNTL_DIM_DQ_RULE_2')
							,('P_LEW_MART_PIT_2','T_CNTL_DIM_KPI_SOURCE_TABLE')
							,('P_LEW_MART_PIT_2','T_DIM_ACTION_TYPE_2')
							,('P_LEW_MART_PIT_2','T_DIM_CLIENT_2')
							--,('P_LEW_MART_PIT_2','T_F_PRICE_ITEM')
							,('P_LEW_MART_PIT_2','T_CNTL_S2T_MAPPING')
							,('P_LEW_MART_PIT_2','T_CNTL_SOURCE_TARGET_MAPPING')
							,('P_LEW_MART_PIT_2','T_DIM_ADV_MEDIUM_2')
							,('P_LEW_MART_PIT_2','T_DIM_ADV_THEME_HIER')
							,('P_LEW_MART_PIT_2','T_DIM_REGION_HIER_2')
							,('P_LEW_MART_PIT_2','T_F_STORE_ADV_PERIOD_ITEM')
							,('P_LEW_MART_PIT_2','T_P_F_STORE_DAY_ADV_PERIOD_ITEM_2')
							,('P_LEW_MART_PIT_2','T_REL_ADV_MEDIUM2GRP_2')
							,('P_LEW_MART_PIT_2','T_CNTL_DIM_KPI_TRANSACTION_TYPE_CODES_2')
							,('P_LEW_MART_PIT_2','T_AGG_POS_STORE_ITEM_DAY_2')
							,('P_LEW_MART_PIT_2','T_A_ADV_PERIOD_NAN_2')
							,('P_LEW_MART_PIT_2','T_A_ADV_WEEK_CATEGORY_2')
							,('P_LEW_MART_PIT_2','T_A_ADV_WEEK_MEDIUM_2')
							,('P_LEW_MART_PIT_2','T_CNTL_DIM_PROCESSING_PARAM_2')
							,('P_LEW_MART_PIT_2','T_DIM_ADV_WEEK_RELATED_TYPE_2')
							,('P_LEW_MART_PIT_2','T_DIM_ITEM_FAMILY_GRP_2')
							,('P_LEW_MART_PIT_2','T_DIM_ORIG_ITEM_2')
							,('P_LEW_MART_PIT_2','T_P_F_RECEIPT_ITEM_2')
							,('P_LEW_MART_PIT_2','T_REL_ADV_THEME2GRP')
							,('P_LEW_MART_PIT_2','T_CNTL_DIM_A_CALC_RULES')
							,('P_LEW_MART_PIT_2','T_CNTL_DIM_KPIS')
							,('P_LEW_MART_PIT_2','T_CNTL_PROCESSING_PARAM_2')
							,('P_LEW_MART_PIT_2','T_CNTL_BUYING_PRICE_RANGE_2')
							,('P_LEW_MART_PIT_2','T_F_STORE_ADV_PERIOD')
							,('P_LEW_MART_PIT_2','T_CNTL_DIM_SOURCE_SYSTEM_2')
							,('P_LEW_MART_PIT_2','T_CNTL_ETL_PERFORMANCE_2')
							,('P_LEW_MART_PIT_2','T_CNTL_ETL_PROCESSING')
							,('P_LEW_MART_PIT_2','T_DIM_CALENDAR_2')
							,('P_LEW_MART_PIT_2','T_DIM_ITEM_HIER_2')
							,('P_LEW_MART_PIT_2','T_DIM_SUB_ITEM_GRP_2')
							,('P_LEW_MART_PIT_2','T_DIM_WAREHOUSE_2')
							,('P_LEW_MART_PIT_2','T_F_ADV_PERIOD_ITEM')
							,('P_LEW_MART_PIT_2','T_F_RECEIPT_2')
							,('P_LEW_MART_PIT_2','T_F_RECEIPT_ITEM_2')
							,('P_LEW_MART_PIT_2','T_F_REL_MEDIUM_STORE_DAY_ITEM_2')
							,('P_LEW_MART_PIT_2','T_F_STORE_DAY')
							,('P_LEW_MART_PIT_2','T_REL_ADV_MEDIUM2MEDIUM_2')
							,('P_LEW_MART_PIT_2','T_REL_NAN_IFG_UWG_WGI_2')
							,('P_LEW_MART_PIT_2','T_F_REGION_STORE_CNT_2')
							,('P_LEW_MART_PIT_2','T_DIM_ADV_MEDIUM_GRP_2')
							,('P_LEW_MART_PIT_2','T_F_DELIVERY_STORE_ITEM')
							,('P_LEW_FE_MSTR_PIT','T_AGG_DRILL_CAT_UWG_2')
							,('P_LEW_FE_MSTR_PIT','T_AGG_DRILL_CAT_WGI_2')
							,('P_LEW_FE_MSTR_PIT','T_AGG_DRILL_PERIOD_2')
							,('P_LEW_FE_MSTR_PIT','T_AGG_REGION_CATEGORY_ALL_2')
							,('P_LEW_FE_MSTR_PIT','T_AGG_REGION_MEDIUM_ALL_2')
							,('P_LEW_FE_MSTR_PIT','T_AGG_REGION_THEME_NAN')
							,('P_LEW_FE_MSTR_PIT','T_CNTL_FE_MSTR_PARAM_2')
							,('P_LEW_FE_MSTR_PIT','T_CNTL_FE_MSTR_REPORTING_LINES_2')
							,('P_LEW_FE_MSTR_PIT','T_CNTL_PROCESSING_PARAM_2')
							,('P_LEW_FE_MSTR_PIT','T_DIM_ADV_WEEK_RELATED_TYPE_2')
							,('P_LEW_FE_MSTR_PIT','T_DIM_VERSION_INFO_2')
							,('P_LEW_FE_MSTR_PIT','T_PIT_HIER_LEVEL_2')
							,('P_LEW_FE_MSTR_PIT','T_AGG_DRILL_THEME_2')
							,('P_LEW_FE_MSTR_PIT','T_AGG_DRILL_ITEM_2')
							,('P_LEW_FE_MSTR_PIT','T_AGG_DRILL_MEDIUM_2')
							,('P_LEW_FE_MSTR_PIT','T_AGG_REGION_ADV_WEEK_NAN_2')
							,('P_LEW_FE_MSTR_PIT','T_AGG_REGION_CATEGORY_NAN')
							,('P_LEW_FE_MSTR_PIT','T_AGG_REGION_MEDIUM_NAN')
							,('P_LEW_FE_MSTR_PIT','T_AGG_REGION_PERIOD_ALL_2')
							,('P_LEW_FE_MSTR_PIT','T_AGG_REGION_PERIOD_NAN')
							,('P_LEW_FE_MSTR_PIT','T_AGG_REGION_THEME_ALL_2')
							,('P_LEW_FE_MSTR_PIT','T_CNTL_FE_MSTR_ADV_WEEK_REPORT_LINKS')
							,('P_LEW_FE_MSTR_PIT','T_CNTL_FE_MSTR_REPORT_TOC_2')
							,('P_LEW_FE_MSTR_PIT','T_DIM_ADV_WEEK_2_ADV_WEEK_PREV_2')
							,('P_LEW_FE_MSTR_PIT','T_DIM_ADV_WEEK_RANGES')			
						)
						WHERE TRUE 
							AND UPPER(_Schema_Name) IN ('#PSCHEMA#') 
					) pit
			
					-- Inner Join Information Schema 
					INNER JOIN
					(
						SELECT 
							  UPPER(TRIM(Table_Schema)) AS _Schema_Name
							, UPPER(TRIM(Table_Name))	AS _Table_Name
						FROM INFORMATION_SCHEMA.TABLES 
						WHERE TRUE 
							AND UPPER(Table_Schema) IN ('#PSCHEMA#')
							AND UPPER(Table_Name)   LIKE 'T_%' 
							AND UPPER(Table_Name)   NOT LIKE 'TT%' 
							AND UPPER(Table_Name) 	NOT LIKE '%_TMP'
							AND UPPER(Table_Name) 	NOT LIKE '%_TEST'	
					) inf
					ON TRUE	
						AND inf._Schema_Name 	= pit._Schema_Name
						AND inf._Table_Name 	= pit._Table_Name
			;
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());


        // Retrieve from all uses tables
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNSEARCHOPTIMIZATION: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		var _rowCnt = res.getRowCount();
	
		while (res.next() && iCnt < iMaxRuns) {
		       	
			sqlStmt = "";
			sqlStmt = "ALTER TABLE IF EXISTS " + res.getColumnValue(1) + " ADD SEARCH OPTIMIZATION;";
			
			if ( _bLogging ) {
					
				sqlStmtLogStart = "";
				sqlStmtLogStart = "CALL sp_StartComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','" + res.getColumnValue(1) + "', '" + strRunCluster + "',f_QueryTag('" + PAPPLICATIONNAME + "','" + PMODULENAME + "',NULL));";

				sqlStmtLogEnd = ""; 
				sqlStmtLogEnd ="CALL sp_EndComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','"  + res.getColumnValue(1) + "', '"+ strRunCluster + "', to_char(1));";
			} // if ( _bLogging ) {
		   
			if ( _bLogging ) {
				try{
					snowflake.createStatement( { sqlText: sqlStmtLogStart } ).execute();
				} catch (ERROR){
				
					msg = "P_RUNSEARCHOPTIMIZATION_ALTER: [" + sqlStmtLogStart + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
					throw new Error(msg);
					return msg ;
				}
			} // if ( _bLogging ) {

		    try{
				snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			} catch (ERROR){
			
				msg = "P_RUNSEARCHOPTIMIZATION_ALTER: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
				throw new Error(msg);
				return msg ;
			}

			if ( _bLogging ) {
				try{
					snowflake.createStatement( { sqlText: sqlStmtLogEnd } ).execute();
				} catch (ERROR){
				
					msg = "P_RUNSEARCHOPTIMIZATION_ALTER: [" + sqlStmtLogEnd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
					throw new Error(msg);
					return msg ;
				}
			} // if ( _bLogging ) {
			
			iCnt += 1;
			
		} // while result set

		return "" + _rowCnt;			
$$
; -- End of sp_RunSearchOptimization

/*
Call sp_RunSearchOptimization('P_LEW_MART_PIT_2','PITonCloud','Performance','',100,FALSE);
Call P_LEW_MART_PIT.sp_RunSearchOptimization('P_LEW_MART_PIT_2','PITonCloud','Performance','[${CLIENT_ID}]',100,${PIT_LOGGING})
;
Call P_LEW_MART_PIT.sp_RunSearchOptimization('P_LEW_FE_MSTR_PIT','PITonCloud','Performance','[${CLIENT_ID}]',100,${PIT_LOGGING})
;
SHOW TABLES LIKE 'T_%';

SELECT 
	* 
FROM V_CNTL_ETL_LOGGING_2 lg
WHERE 
	TRUE 
	AND MOVING_RUN_ID_FROM_CURRENT = 0
	AND MODULE_NAME = 'Performance'
	AND APPLICATION_NAME = 'PITonCloud'
;
*/
/* --- EOF - END OF FILE --- */