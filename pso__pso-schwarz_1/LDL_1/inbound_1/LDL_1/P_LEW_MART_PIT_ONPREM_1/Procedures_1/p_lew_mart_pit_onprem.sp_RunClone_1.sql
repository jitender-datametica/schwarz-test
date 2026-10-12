CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_RunClone (
      pTableType			STRING
	, pSchema   			STRING 
	, pApplicationName 		STRING 
	, pModuleName 			STRING 		
	, pRunClusteringDesc    STRING  
	, pSchemaTRG   			STRING 	
	, pMaxRuns				DOUBLE
	, pLogging				BOOLEAN
)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  STRICT
  EXECUTE AS CALLER
  AS
  $$


// ---------------------------------------------------------------------
// PROCEDURE	:	sp_RunClone(pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING )
// Input		:   pTableType				STRING ((All), Tables, Views, Procedures, Functions, Sequences)
// 				pSchema 				STRING 
// 				pApplicationName 		STRING
// 				pModuleName 			STRING 		
//     			pRunClusteringDesc    	STRING --> [0] running in sequence
//     			pSchemaTRG   			STRING --> target Schema assuming schemas on the same DB
//     			pMaxRuns				INTEGER
// Return		:	Error + Error Msg or in success case number of processed Tables
// Convert		:	None    
// Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
//                 Logging is also enables  but must be enabled! 
// Example		:	Call sp_RunClone('P_LEW_MART_PIT_ONPREM');
// ------------------------------------------------------------------------
// # History:
// #  1.0  2021-07-01 Andreas Kurz    Initial version


		var _rowCnt = 0, iCnt = 0, iMaxRuns = 150, strTableType = "ALL", strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmtLogStart = "", sqlStmtLogEnd = "", sqlStmtUseSourceSchema = "", sqlStmtUseTargetSchema = "", sqlStmtClone = "", sqlStmt = "";
		var _bLogging = new Boolean("false");
		var sqlStmtModuleLogStart = "", sqlStmtModuleLogEnd = ""; 
        
		if ((PLOGGING === "") || (typeof(PLOGGING) === "undefined") || (PLOGGING === null)) {
			_bLogging = Boolean("false");
		} else {
			_bLogging = Boolean(PLOGGING);
		}
		
		if ((PMAXRUNS === "") || (PMAXRUNS === null) || (Number.isNaN(PMAXRUNS) == true)) { 
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
				  ddl.SF_SCHEMA  
				, ddl.NAME_SCHEMA
				, ddl.TABLE_TYPE 	
				, ddl.SF_NAME 
				, ddl.SQL_RESULT
				, ddl._DWH_CREATED_TS			
				, COALESCE(vi.VIEW_SORTORDER, 1) AS _SORT_ORDER
			FROM
			(
			SELECT  
				  SF_SCHEMA  
				, NAME_SCHEMA
				, UPPER(TRIM(TABLE_TYPE)) AS TABLE_TYPE
				, SF_NAME 
				, SQL_RESULT
				, to_timestamp(DWH_CREATED_TS) AS _DWH_CREATED_TS
			FROM P_LEW_MART_PIT_ONPREM.T_CNTL_DLL_RESULT_TMP_1
			WHERE TRUE
				AND SF_SCHEMA 	= '#PSCHEMA#'
				AND SF_NAME		IS NOT NULL
				AND SF_NAME		NOT LIKE 'T_PIT_STORE_DAY_ITEM_WAWI_REAGG'
				AND SF_NAME		NOT LIKE 'V_PIT_AUTOMATED_TESTING_RULES'
				AND SF_NAME		NOT LIKE '%_TEST'
				AND
				(	
					'#PTABLETYPE#' = 'ALL' 
					OR 
					'#PTABLETYPE#' = UPPER(TRIM(TABLE_TYPE))
				)				
			
			QUALIFY ROW_NUMBER() OVER (PARTITION BY SF_SCHEMA, NAME_SCHEMA, TABLE_TYPE, DELETED_FG ORDER BY _DWH_CREATED_TS DESC) = 1
			
			) ddl
			
			LEFT JOIN			
			(
			SELECT
				  COLUMN1 AS VIEW_SORTORDER
				, COLUMN2 AS VIEW_NAME
				, 'VIEW'  AS TABLE_TYPE
			FROM 
			(
				VALUES 
				(1,'V_PIT_PARAM_1')
				, (2,'V_PIT_SCOPE_COUNTRY_INIT_1')
				, (3,'V_PIT_ADVERT_MEDIUM_1')
				, (4,'V_PIT_ADVERT_MEDIUM_GRP_1')
				, (5,'V_PIT_ADVERT_THEME_1')
				, (6,'V_PIT_ADV_PERIOD_1')
				, (7,'V_PIT_ADV_WEEK_1')
				, (8,'V_PIT_ADV_WEEK_PERIOD_1')
				, (9,'V_PIT_ADV_WEEK_PREV_WEEKS_1')
				, (10,'V_PIT_ADV_WEEK_RANGES_1')
				, (11,'V_PIT_ADV_WEEK_RLTD_TYPE_1')
				, (12,'V_PIT_ADV_WEEK_START_1')
				, (13,'V_PIT_APT_ANALYTICS_ADVERT_MEDIUM_1')
				, (14,'V_PIT_APT_BASE_CLIENT_DAY_ITEM_1')
				, (15,'V_PIT_APT_BASE_CLIENT_DAY_ITEM_DENORM_1')
				, (16,'V_PIT_APT_BASE_CLIENT_PROMOTIONPERIOD_ITEM_DENORM_1')
				, (17,'V_PIT_APT_CORE_ITEM_PROMOTION_1')
				, (18,'V_PIT_APT_CORE_ADVERT_THEME_CLIENT_1')
				, (19,'V_PIT_APT_CORE_ITEM_PROMOTION_MEDIUM_1')
				, (20,'V_PIT_APT_CORE_ADVERT_MEDIUM_CLIENT_1')
				, (21,'V_PIT_ITEM_CLIENT_DAY_HIST_1')
				, (22,'V_PIT_BASE_ADV_WEEK_ORIG_ITEM_1')
				, (23,'V_PIT_BASE_CATEGORY_ALL_1')
				, (24,'V_PIT_BASE_CATEGORY_ITEM_1')
				, (25,'V_PIT_BASE_MEDIUM_ALL_1')
				, (26,'V_PIT_BASE_MEDIUM_ITEM_1')
				, (27,'V_PIT_BASE_PERIOD_ALL_1')
				, (28,'V_PIT_BASE_PERIOD_ITEM_1')
				, (29,'V_PIT_BASE_THEME_ALL_1')
				, (30,'V_PIT_BASE_THEME_ITEM_1')
				, (31,'V_PIT_DAY_ITEM_STORE_ADV_CNT_1')
				, (32,'V_PIT_DAY_ITEM_STORE_CNT_1')
				, (33,'V_PIT_ETL_LOGGING_RUN_1')
				, (34,'V_PIT_INTEGRAL_SALES_STORE_DAY_ITEM_1')
				, (35,'V_PIT_ITEMGROUP_INTERNATIONAL_1')
				, (36,'V_PIT_ITEM_CLIENT_DAY_CURRENT_1')
				, (37,'V_PIT_ITEM_1')
				, (38,'V_PIT_ITEM_FAMILYGROUP_1')
				, (39,'V_PIT_SUBITEMGROUP_1')
				, (40,'V_PIT_MSI_DRILL_ALL_ITEM_1')
				, (41,'V_PIT_MSI_DRILL_DETAIL_1')
				, (42,'V_PIT_MSI_DRILL_MEDIUM_1')
				, (43,'V_PIT_MSI_DRILL_THEME_1')
				, (44,'V_PIT_MSI_DRILL_UWG_1')
				, (45,'V_PIT_MSI_DRILL_UWG_ITEM_1')
				, (46,'V_PIT_PV_SALES_STORE_DAY_ITEM_1')
				, (47,'V_PIT_REPORTS_TOC_1')
				, (48,'V_PIT_SCOPE_COUNTRY_INIT_1')
				, (49,'V_PIT_SCOPE_COUNTRY_PARAM_1')
				, (50,'V_PIT_SCOPE_COUNTRY_PARAM_COUNTRY_1')
				, (51,'V_PIT_SCOPE_COUNTRY_PARAM_LOG_1')
				, (52,'V_PIT_STORE_DAY_ITEM_PV_1')
				, (53,'V_PIT_VERSION_INFO_1')
				, (54,'V_PIT_WEEK_ITEM_PERIOD_PV_1')
				, (55,'V_PIT_WTD_ADV_WEEK_1')
				)
			) vi
			ON TRUE 
				AND ddl.TABLE_TYPE 	= vi.TABLE_TYPE
				AND ddl.SF_NAME 	= vi.VIEW_NAME
			
			ORDER BY ddl.TABLE_TYPE, _SORT_ORDER, ddl._DWH_CREATED_TS 
			;
			
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());
		sqlStmt = sqlStmt.replace(/#PTABLETYPE#/g,PTABLETYPE.toUpperCase());
		
		// Retrieve from all uses tables
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNCLONE: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		var _rowCnt = res.getRowCount();
	
		sqlStmtModuleLogStart = "";
		sqlStmtModuleLogStart = "CALL P_LEW_MART_PIT_ONPREM.sp_StartModuleLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','" + strRunCluster + "',P_LEW_MART_PIT_ONPREM.QueryTag('" + PAPPLICATIONNAME + "','" + PMODULENAME + "',NULL));";

		sqlStmtModuleLogEnd = ""; 
		sqlStmtModuleLogEnd ="CALL P_LEW_MART_PIT_ONPREM.sp_EndModuleLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','" + strRunCluster + "');";
	
		if ( _bLogging ) {
			try{
	            snowflake.createStatement( { sqlText: sqlStmtModuleLogStart } ).execute();
    	    } catch (ERROR){
            
        		msg = "P_RUNCLONE: [" + sqlStmtModuleLogStart + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
				throw new Error(msg);
				return msg ;           
        	}
        } // if ( _bLogging ) {
        
		while (res.next() && iCnt < iMaxRuns) {
		    
			sqlStmt = "";
			if (res.getColumnValue(3).toUpperCase() === "TABLE" || res.getColumnValue(3).toUpperCase() === "SEQUENCE" || res.getColumnValue(3).toUpperCase() === "VIEW" ){
				sqlStmt = `
					DROP #TABLE_TYPE# IF EXISTS #PSCHEMATRG#.#SF_NAME#
					;
				`;
			}
		
			// Variable Substitution
			sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());			
			sqlStmt = sqlStmt.replace(/#PSCHEMATRG#/g,PSCHEMATRG.toUpperCase());	
	
			sqlStmt = sqlStmt.replace(/#SF_SCHEMA#/g,			res.getColumnValue(1).toUpperCase() );		
			sqlStmt = sqlStmt.replace(/#NAME_SCHEMA#/g,			res.getColumnValue(2).toUpperCase() );			
			sqlStmt = sqlStmt.replace(/#TABLE_TYPE#/g,			res.getColumnValue(3).toUpperCase() );			
			sqlStmt = sqlStmt.replace(/#SF_NAME#/g,				res.getColumnValue(4).toUpperCase() );
			sqlStmt = sqlStmt.replace(/#SQL_RESULT#/g,			res.getColumnValue(5).toUpperCase() );			


		
		
			sqlStmtUseTargetSchema = "";
			sqlStmtUseTargetSchema = `
				USE SCHEMA #PSCHEMATRG#
				;
			`;
			// Variable Substitution
			sqlStmtUseTargetSchema = sqlStmtUseTargetSchema.replace(/#PSCHEMATRG#/g,PSCHEMATRG.toUpperCase());	
			
			sqlStmtUseSourceSchema = "";
			sqlStmtUseSourceSchema = `
				USE SCHEMA #PSCHEMA#
				;
			`;
			// Variable Substitution
			sqlStmtUseSourceSchema = sqlStmtUseSourceSchema.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());	

		
			sqlStmtClone = "";
			if (res.getColumnValue(3).toUpperCase() === "TABLE" || res.getColumnValue(3).toUpperCase() === "SEQUENCE") {
				sqlStmtClone = `
					CREATE #TABLE_TYPE# IF NOT EXISTS #PSCHEMATRG#.#SF_NAME#
						CLONE #PSCHEMA#.#SF_NAME#;
				`;
			
			} else if (res.getColumnValue(3).toUpperCase() === "VIEW" || res.getColumnValue(3).toUpperCase() === "FUNCTION") {
				sqlStmtClone = `
					#SQL_RESULT#
				`;
			sqlStmtClone = sqlStmtClone.replace(/#SQL_RESULT#/g,			res.getColumnValue(5).toUpperCase() );	
			} else {
				sqlStmtClone = `
					SELECT CURRENT_DATE();
				`;				
			}

			// Variable Substitution
			sqlStmtClone = sqlStmtClone.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());			
			sqlStmtClone = sqlStmtClone.replace(/#PSCHEMATRG#/g,PSCHEMATRG.toUpperCase());	
				   
			sqlStmtClone = sqlStmtClone.replace(/#SF_SCHEMA#/g,				res.getColumnValue(1).toUpperCase() );		
			sqlStmtClone = sqlStmtClone.replace(/#NAME_SCHEMA#/g,			res.getColumnValue(2).toUpperCase() );			
			sqlStmtClone = sqlStmtClone.replace(/#TABLE_TYPE#/g,			res.getColumnValue(3).toUpperCase() );			
			sqlStmtClone = sqlStmtClone.replace(/#SF_NAME#/g,				res.getColumnValue(4).toUpperCase() );
			sqlStmtClone = sqlStmtClone.replace(/#SQL_RESULT#/g,			res.getColumnValue(5).toUpperCase() );
		
			sqlStmtClone = sqlStmtClone.replace(/CREATE OR REPLACE VIEW /g,	"CREATE OR REPLACE VIEW " + PSCHEMATRG.toUpperCase() + "." );		
			sqlStmtClone = sqlStmtClone.replace(/CREATE OR REPLACE FUNCTION /g,	"CREATE OR REPLACE FUNCTION " + PSCHEMATRG.toUpperCase() + "." );		
			
		
			sqlStmtLogStart = "";
			sqlStmtLogStart = "CALL P_LEW_MART_PIT_ONPREM.sp_StartComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','" + res.getColumnValue(3) + ' - ' + res.getColumnValue(4) + "', '" + strRunCluster + "',P_LEW_MART_PIT_ONPREM.QueryTag('" + PAPPLICATIONNAME + "','" + PMODULENAME + "',NULL));";

		    sqlStmtLogEnd = ""; 
		    sqlStmtLogEnd ="CALL P_LEW_MART_PIT_ONPREM.sp_EndComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','"  + res.getColumnValue(3) + ' - ' + res.getColumnValue(4) + "', '"+ strRunCluster + "', to_char(1));";
	
		   if ( _bLogging ) {
				try{
					snowflake.createStatement( { sqlText: sqlStmtLogStart } ).execute();
				} catch (ERROR){
					
					msg = "P_RunClone: [" + sqlStmtLogStart + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
						
					throw new Error(msg);
					return msg ;
				}
			} // _bLogging

		    try{
		    	if (res.getColumnValue(3).toUpperCase() === "TABLE" || res.getColumnValue(3).toUpperCase() === "SEQUENCE" || res.getColumnValue(3).toUpperCase() === "VIEW") {
		    		snowflake.createStatement( { sqlText: sqlStmt } ).execute();
		    	}
				//snowflake.createStatement( { sqlText: sqlStmtUseTargetSchema } ).execute();
				if (res.getColumnValue(3).toUpperCase() === "TABLE" || res.getColumnValue(3).toUpperCase() === "VIEW" || res.getColumnValue(3).toUpperCase() === "FUNCTION") {
					snowflake.createStatement( { sqlText: sqlStmtClone } ).execute();
				}
				//snowflake.createStatement( { sqlText: sqlStmtUseSourceSchema } ).execute();
			} catch (ERROR){
			
				msg = "P_RunClone: [" + sqlStmtClone + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
				throw new Error(msg);
				return msg ;
			}
			
			if ( _bLogging ) {
				try{
					snowflake.createStatement( { sqlText: sqlStmtLogEnd } ).execute();
				} catch (ERROR){
				
					msg = "P_RunClone: [" + sqlStmtLogEnd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
					throw new Error(msg);
					return msg ;
				}
			} // _bLogging
			
			iCnt += 1;
			
		} // while result set

		if ( _bLogging ) {
			try{
            
            	snowflake.createStatement( { sqlText: sqlStmtModuleLogEnd } ).execute();
        	} catch (ERROR){
            
        		msg = "P_RUNCLONE: [" + sqlStmtModuleLogEnd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
				throw new Error(msg);
				return msg ;           
        	}
        } // if ( _bLogging ) {
		
		return "" + _rowCnt;			
$$
;