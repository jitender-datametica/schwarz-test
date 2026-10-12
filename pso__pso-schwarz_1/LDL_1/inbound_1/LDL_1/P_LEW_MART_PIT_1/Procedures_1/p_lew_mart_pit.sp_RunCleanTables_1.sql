/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2021
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_RunCleanTables
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
USE ROLE			R_LDL_D_PIT_ETL;
USE WAREHOUSE		WH_LDL_D_PIT_ETL_S;
USE DATABASE		LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA			P_LEW_MART_PIT_1;
 */
/* 
---------------------------------------------------------------------
PROCEDURE	:	sp_RunCleanTables(pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING )
Input		:   pTableType				STRING (All, Static, Fact, Log, Empty)
				pSchema 				STRING 
				pApplicationName 		STRING
				pModuleName 			STRING 		
    			pRunClusteringDesc    	STRING --> [0] running in sequence
    			pMaxRuns				INTEGER
    			pLogging				BOOLEAN (True/False) for Logging
Return		:	Error + Error Msg or in success case number of processed Tables
Convert		:	None    
Description	: 	Initialize Cleaning all PIT Tables based on Parameters, there is a max Runs (:= 100) to prevent endless loops
				PIT Tables are inputted statically, but must exist in the information schema of the corresponding Schema
                Logging is also enables  but must be enabled! 
Example		:	Call P_LEW_FE_MSTR_PIT.sp_RunCleanTables('AGG','P_LEW_FE_MSTR_PIT','PITonCloud','RunCleanAGGTables','10,11,13,14,16,17',100, FALSE)
;
#Clean Start Page of Countries
--DELETE FROM P_LEW_MART_PIT.T_DIM_ADV_WEEK_1
WHERE TRUE
	AND CLIENT_ID IN (#csv_list_of_countries_which_need_to_be_cleaned_from_start_page#)
	AND PROCESSED_ADV_WEEK_FG = 1
;
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_RunCleanTables (
      pTableType      		STRING
	, pSchema      			STRING 
	, pApplicationName 		STRING 
	, pModuleName 			STRING 		
	, pRunClusteringDesc    STRING  
	, pMaxRuns				DOUBLE
	, pLogging				BOOLEAN	
)
  RETURNS STRING
  LANGUAGE javascript
  STRICT
  AS
  $$
		var _rowCnt = 0, iCnt = 0, iMaxRuns = 100, strTableType = "ALL", strRunCluster = "0", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmtLogStart = "", sqlStmtLogEnd = "", sqlStmt = "";
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
		
		// CHECK INPUT pTableType
		if ((PTABLETYPE === "") || (typeof(PTABLETYPE) === "undefined") || (PTABLETYPE.length === 0) || (PTABLETYPE === null)) { 
			PTABLETYPE = strTableType; 
		} else {
			strTableType = PTABLETYPE.toUpperCase();
		}
		
		sqlStmt = "";
		sqlStmt = `
			SELECT
				  stat.TABLE_NAME
				, stat.TABLE_TYPE
				, stat.SEQ_NUM				
				, stat.TABLE_TYPE_ID
				, stat.TABLE_NAME
			FROM
			(
				SELECT
					  TRIM(UPPER(COLUMN1)) 						AS TABLE_NAME 
					, TRIM(UPPER(COLUMN2)) 						AS TABLE_TYPE 
					, COLUMN3 									AS SEQ_NUM
					, CASE 
						WHEN TABLE_TYPE = 'STATIC' 		THEN  1::SMALLINT
						WHEN TABLE_TYPE = 'FACT'		THEN  2::SMALLINT
						WHEN TABLE_TYPE = 'LOG'         THEN  3::SMALLINT
						WHEN TABLE_TYPE = 'AGG'			THEN  4::SMALLINT
						WHEN TABLE_TYPE = 'EMPTY'       THEN -1::SMALLINT
						WHEN TABLE_TYPE = 'NOTUSED'     THEN -1::SMALLINT
						WHEN TABLE_TYPE = 'CLONED'      THEN -1::SMALLINT
						ELSE 
							-2::SMALLINT
					  END AS TABLE_TYPE_ID
				FROM
				(
				VALUES
					  ('P_LEW_MART_PIT.T_ADVERTISEMENT_CHANNEL_1','NOTUSED',1)
					, ('P_LEW_MART_PIT.T_AGG_POS_STORE_ITEM_DAY_1','FACT',1)
					, ('P_LEW_MART_PIT.T_A_ADV_PERIOD_1','FACT',1)
					, ('P_LEW_MART_PIT.T_A_ADV_WEEK_1','FACT',1)
					, ('P_LEW_MART_PIT.T_A_ADV_WEEK_CATEGORY_1','FACT',1)
					, ('P_LEW_MART_PIT.T_A_ADV_WEEK_MEDIUM_1','FACT',1)
					, ('P_LEW_MART_PIT.T_A_ADV_WEEK_NAN','FACT',1)
					, ('P_LEW_MART_PIT.T_A_ADV_WEEK_THEME','FACT',1)
					, ('P_LEW_MART_PIT.T_A_REGION_ADV_WEEK_NAN','FACT',1)
					
					, ('P_LEW_FE_MSTR_PIT.T_AGG_REGION_CATEGORY_ALL_1','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_REGION_PERIOD_ALL_1','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_REGION_THEME_ALL_1','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_REGION_CATEGORY_NAN','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_REGION_MEDIUM_NAN','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_REGION_MEDIUM_ALL_1','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_REGION_PERIOD_NAN','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_REGION_THEME_NAN','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_REGION_ADV_WEEK_NAN_1','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_DRILL_CAT_UWG_1','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_DRILL_CAT_WGI_1','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_DRILL_ITEM_1','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_DRILL_MEDIUM_1','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_DRILL_PERIOD_1','AGG',1)
					, ('P_LEW_FE_MSTR_PIT.T_AGG_DRILL_THEME_1','AGG',1)
					
					, ('P_LEW_MART_PIT.T_CNTL_BUYING_PRICE_RANGE_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_DIM_A_LEVEL','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_DIM_DQ_RULE_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_DIM_KPI_TRANSACTION_TYPE_CODES_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_DIM_PROCESSING_PARAM_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_DIM_REJECT_REASON_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_DIM_SOURCE_SYSTEM_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_DIM_UPI','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_ETL_LOGGING_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_ETL_LOGGING_RUN_SEQ_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_ETL_PERFORMANCE_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_ETL_PROCESSING','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_PROCESSING_PARAM_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_PROCESSING_PARAM_NORMALIZED_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_S2T_MAPPING','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_S2T_MAPPING_WORK','NOTUSED',1)
					, ('P_LEW_MART_PIT.T_CNTL_SOURCE_TARGET_MAPPING','STATIC',1)
					, ('P_LEW_MART_PIT.T_CNTL_UPI_DATA','STATIC',1)
					, ('P_LEW_MART_PIT.T_DIM_ACTION_TYPE_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_DIM_ADV_MEDIUM_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_DIM_ADV_MEDIUM_GRP_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_DIM_ADV_MEDIUM_HIER_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_DIM_ADV_PERIOD_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_DIM_ADV_THEME_HIER','STATIC',1)
					, ('P_LEW_MART_PIT.T_DIM_ADV_WEEK_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_DIM_CALENDAR_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_DIM_CLIENT_1','STATIC',1)
					, ('P_LEW_MART_PIT.T_DIM_ITEM_HIER_1','FACT',1)
					, ('P_LEW_MART_PIT.T_DIM_REGION_HIER_1','FACT',1)
					, ('P_LEW_MART_PIT.T_F_ADV_PERIOD_ITEM','FACT',1)
					, ('P_LEW_MART_PIT.T_F_DELIVERY_STORE_ITEM','FACT',1)
					, ('P_LEW_MART_PIT.T_F_DELIVERY_WH_ITEM_1','FACT',1)
					, ('P_LEW_MART_PIT.T_F_PRICE_ITEM','FACT',1)
					, ('P_LEW_MART_PIT.T_F_RECEIPT_1','FACT',1)
					, ('P_LEW_MART_PIT.T_F_RECEIPT_ITEM_1','FACT',1)
					, ('P_LEW_MART_PIT.T_F_REGION_STORE_CNT_1','FACT',1)
					, ('P_LEW_MART_PIT.T_F_REL_MEDIUM_STORE_DAY_ITEM_1','FACT',1)
					, ('P_LEW_MART_PIT.T_F_STORE_ADV_PERIOD','FACT',1)
					, ('P_LEW_MART_PIT.T_F_STORE_ADV_PERIOD_ITEM','FACT',1)
					, ('P_LEW_MART_PIT.T_F_STORE_DAY','FACT',1)
					, ('P_LEW_MART_PIT.T_F_STORE_DAY_ITEM_1','FACT',1)
					, ('P_LEW_MART_PIT.T_P_F_RECEIPT_ITEM_1','FACT',1)
					, ('P_LEW_MART_PIT.T_P_F_STORE_DAY_ADV_PERIOD_ITEM_1','FACT',1)
					, ('P_LEW_MART_PIT.T_REL_ADV_MEDIUM2GRP_1','STATIC',1)				
				)
				WHERE TRUE	
					AND 
					(
						'#PTABLETYPE#' = 'ALL' 
						OR 
						'#PTABLETYPE#' = TRIM(UPPER(TABLE_TYPE))
					)
			) stat
			
			INNER JOIN
			(
				SELECT 
					Table_Schema || '.' || Table_Name  AS TABLENAME_SCHEMA
				FROM INFORMATION_SCHEMA.TABLES 
				WHERE TRUE 
					AND UPPER(Table_Schema) IN ('#PSCHEMA#')
					AND UPPER(Table_Name)   LIKE 'T_%' 
					AND UPPER(Table_Name)   NOT LIKE 'TT%' 
					AND UPPER(Table_Name) 	NOT LIKE '%_TMP'
					AND UPPER(Table_Name) 	NOT LIKE '%_TEST'
			) inf
			ON TRUE 
				AND inf.TABLENAME_SCHEMA = stat.TABLE_NAME
			`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());
		sqlStmt = sqlStmt.replace(/#PTABLETYPE#/g,PTABLETYPE.toUpperCase());


        // Retrieve from all uses tables
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNCLEANTABLE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		var _rowCnt = res.getRowCount();
	
		while (res.next() && iCnt < iMaxRuns) {
		       	
			
			sqlStmt = "";
		    sqlStmt = "DELETE FROM " + res.getColumnValue(5) + " WHERE TRUE AND CLIENT_ID IN(" + strRunCluster + ");";
			
			if ( _bLogging ) {
				sqlStmtLogStart = "";
				sqlStmtLogStart = "CALL P_LEW_MART_PIT.sp_StartComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','DELETE FROM " + res.getColumnValue(5) + "', '[" + strRunCluster + "]',P_LEW_MART_PIT.QueryTag('" + PAPPLICATIONNAME + "','" + PMODULENAME + "',NULL));";

				sqlStmtLogEnd = ""; 
				sqlStmtLogEnd ="CALL P_LEW_MART_PIT.sp_EndComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','DELETE FROM "  + res.getColumnValue(5) + "', '["+ strRunCluster + "]', to_char(1));";
			
		   
				try{
					snowflake.createStatement( { sqlText: sqlStmtLogStart } ).execute();
				} catch (ERROR){
				
					msg = "P_RUNCLEANTABLE_TRUNCATE: [" + sqlStmtLogStart + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
					throw new Error(msg);
					return msg ;
				}
			} // if ( _bLogging )

		    try{
				snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			} catch (ERROR){
			
				msg = "P_RUNCLEANTABLE_TRUNCATE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
				throw new Error(msg);
				return msg ;
			}

			if ( _bLogging ) {
				try{
					snowflake.createStatement( { sqlText: sqlStmtLogEnd } ).execute();
				} catch (ERROR){
				
					msg = "P_RUNCLEANTABLE_TRUNCATE: [" + sqlStmtLogEnd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
					throw new Error(msg);
					return msg ;
				}
			} // if ( _bLogging )
			
			iCnt += 1;
			
		} // while result set

		return "" + _rowCnt;			
$$
; -- End of sp_RunCleanTables


	