CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_RunCleanTables (
      pTableType      		STRING
	, pSchema      			STRING 
	, pApplicationName 		STRING 
	, pModuleName 			STRING 		
	, pRunClusteringDesc    STRING  
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
// PROCEDURE	:	sp_RunCleanTables(pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING )
// Input		:   pTableType				STRING (All, Static, Fact, Log, Empty)
// 				pSchema 				STRING 
// 				pApplicationName 		STRING
// 				pModuleName 			STRING 		
//     			pRunClusteringDesc    	STRING --> [0] running in sequence
//     			pMaxRuns				INTEGER
// Return		:	Error + Error Msg or in success case number of processed Tables
// Convert		:	None    
// Description	: 	Initialize Cleaning all PIT Tables based on Parameters, there is a max Runs (:= 100) to prevent endless loops
// 				PIT Tables are inputted statically, but must exist in the information schema of the corresponding Schema
//                 Logging is also enables  but must be enabled! 
// Example		:	Call sp_RunCleanTables('P_LEW_MART_PIT_ONPREM');
// ------------------------------------------------------------------------
// # History:
// #  1.0  2021-07-01 Andreas Kurz    Initial version


		var _rowCnt = 0, iCnt = 0, iMaxRuns = 100, strTableType = "ALL", strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmtLogStart = "", sqlStmtLogEnd = "", sqlStmt = "";
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
				, stat.TABLENAME_SCHEMA				
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
						WHEN TABLE_TYPE = 'EMPTY'       THEN -1::SMALLINT
						WHEN TABLE_TYPE = 'NOTUSED'     THEN -1::SMALLINT
						WHEN TABLE_TYPE = 'CLONED'      THEN -1::SMALLINT
						ELSE 
							-2::SMALLINT
					END AS TABLE_TYPE_ID
					, TRIM(UPPER('#PSCHEMA#.' || TABLE_NAME)) 		AS TABLENAME_SCHEMA
				FROM
				(
				VALUES
					  ('T_ADVERT_MEDIUM','STATIC',1)
					, ('T_ADVERT_MEDIUM_GROUP','STATIC',2)
					, ('T_ADVERT_MEDIUM_HIST','STATIC',3)
					, ('T_ADVERT_PERIOD','STATIC',4)
					, ('T_ADVERT_THEME','STATIC',5)
					, ('T_ADVERT_WEEK','FACT',6)
					, ('T_ADVERT_WEEK_ACTION_TYPE','FACT',7)
					, ('T_ADVERT_WEEK_ITEMGROUP_INT','FACT',8)
					, ('T_ADVERT_WEEK_ITEM_MEDIUM','FACT',9)
					, ('T_ADVERT_WEEK_ITEM_PERIOD','FACT',10)
					, ('T_ADVERT_WEEK_ITEM_PERIOD_WAWI','FACT',11)
					, ('T_ADVERT_WEEK_MEDIUM','FACT',12)
					, ('T_ADVERT_WEEK_MEDIUM_GRP','FACT',13)
					, ('T_ADVERT_WEEK_ORIG_ITEM','FACT',14)
					, ('T_ADVERT_WEEK_PERIOD','FACT',15)
					, ('T_ADVERT_WEEK_PERIOD_ACTION_TYPE','FACT',16)
					, ('T_ADVERT_WEEK_RELATED','STATIC',17)
					, ('T_ADVERT_WEEK_RELATED_TYPE','STATIC',18)
					, ('T_ADVERT_WEEK_SUBITEMGROUP','FACT',19)
					, ('T_ADVERT_WEEK_THEME','FACT',20)
					, ('T_ADVERT_WEEK_THEME_TOTAL','FACT',21)
					, ('T_ADVERT_WEEK_TOTAL','FACT',22)
					, ('T_CNTL_ETL_LOGGING','LOG',23)
					, ('T_CNTL_ETL_LOGGING_RUN_SEQ','LOG',24)
					, ('T_CNTL_ETL_PERFORMANCE','LOG',25)
					, ('T_COUNTRY_ADVERT_WEEK_START','STATIC',26)
					, ('T_DIM_CALENDAR','STATIC',27)
					, ('T_ITEMGROUP_INT_BUY_PRICE_RANGE','STATIC',28)
					, ('T_PIT_ACTION_TYPE','STATIC',29)
					, ('T_PIT_APT_ADVERT_MEDIUM_CLIENT','STATIC',30)
					, ('T_PIT_APT_ADVERT_THEME_CLIENT','STATIC',31)
					, ('T_PIT_APT_BASE_CLIENT_PROMOTIONPERIOD_ITEM','FACT',32)
					, ('T_PIT_APT_ITEM_LIST_TYPE','FACT',33)
					, ('T_PIT_APT_MEDIUM_CLIENT_PROMOTIONPERIOD_ITEM','FACT',34)
					, ('T_PIT_AUTOMATED_TESTING_ITEM','EMPTY',35)
					, ('T_PIT_AUTOMATED_TESTING_RULES','EMPTY',36)
					, ('T_PIT_CLIENTS','FACT',37)
					, ('T_PIT_CLIENTS_STORES','FACT',38)
					, ('T_PIT_CLIENT_ADVERT_WEEK','FACT',39)
					, ('T_PIT_CLIENT_ADVERT_WEEK_PERIOD_START','FACT',40)
					, ('T_PIT_COUNTRY','STATIC',41)
					, ('T_PIT_DAY_ITEM_STORE_ADV_CNT','FACT',42)
					, ('T_PIT_DAY_ITEM_STORE_CNT','FACT',43)
					, ('T_PIT_ETL_LOGGING','NOTUSED',44)
					, ('T_PIT_ETL_LOGGING_RUN','NOTUSED',45)
					, ('T_PIT_HIER_LEVEL','STATIC',46)
					, ('T_PIT_HIER_TYPE','STATIC',47)
					, ('T_PIT_ITEM_CLIENT_DAY','FACT',48)
					, ('T_PIT_ITEM_CLIENT_LAST_DAY','FACT',49)
					, ('T_PIT_ITEM_ECLIENT','FACT',50)
					, ('T_PIT_ITEM_ECLIENT_DAY','FACT',51)
					, ('T_PIT_ITEM_ELWIS_BRAND_TYPE_CLIENT_DAY','FACT',52)
					, ('T_PIT_ITEM_ELWIS_BRAND_TYPE_STORE_DAY','FACT',53)
					, ('T_PIT_ITEM_ELWIS_BUYING_LIST_TYPE_CLIENT_DAY','FACT',54)
					, ('T_PIT_ITEM_ELWIS_LIST_TYPE_CLIENT_DAY','FACT',55)
					, ('T_PIT_ITEM_ELWIS_LIST_TYPE_STORE_DAY','FACT',56)
					, ('T_PIT_PARAM','STATIC',57)
					, ('T_PIT_PV_SALES_CLIENT_DAY_ITEM','FACT',58)
					, ('T_PIT_REF_TILL_DISCOUNT','NOTUSED',59)
					, ('T_PIT_REPORTS_TOC','STATIC',60)
					, ('T_PIT_SALES_CLIENT_DAY_ITEM','FACT',61)
					, ('T_PIT_SALES_STORE_DAY_ITEM','FACT',62)
					, ('T_PIT_SCOPE_COUNTRY_INIT','NOTUSED',63)
					, ('T_PIT_SCOPE_COUNTRY_PARAM','STATIC',64)
					, ('T_PIT_SCOPE_COUNTRY_PARAM_BACKUP_AFTER','CLONED',65)
					, ('T_PIT_SCOPE_COUNTRY_PARAM_BACKUP_BEFORE','CLONED',66)
					, ('T_PIT_SCOPE_COUNTRY_PARAM_COUNTRY','STATIC',67)
					, ('T_PIT_SCOPE_COUNTRY_PARAM_NORMALIZED','STATIC',68)
					, ('T_PIT_SCOPE_COUNTRY_PARAM_REF','STATIC',69)
					, ('T_PIT_STORE_DAY_ITEM_PV','FACT',70)
					, ('T_PIT_STORE_DAY_ITEM_PV_REAGG','FACT',71)
					, ('T_PIT_STORE_DAY_ITEM_WAWI','FACT',72)
					, ('T_PIT_UPI_CLIENT_DAY_ITEM','FACT',73)
					, ('T_PIT_UPI_ECLIENT_DAY_ITEM','FACT',74)
					, ('T_PIT_UPI_STORE_DAY_ITEM','FACT',75)
					, ('T_PIT_VERSION_INFO','STATIC',76)
					, ('T_PIT_WEEK_ITEM_PERIOD_PV','FACT',77)
				)
				WHERE TRUE	
					AND '#PTABLETYPE#' = 'ALL' OR '#PTABLETYPE#' = TRIM(UPPER(TABLE_TYPE))
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
			) inf
			ON TRUE 
				AND inf.TABLENAME_SCHEMA = stat.TABLENAME_SCHEMA
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
		    sqlStmt = "TRUNCATE TABLE IF EXISTS " + res.getColumnValue(5) + ";";
		    //sqlStmt = "SELECT 'TRUNCATE TABLE IF EXISTS' || '" + res.getColumnValue(5) + "';";
			
			if ( _bLogging ) {
				sqlStmtLogStart = "";
				sqlStmtLogStart = "CALL sp_StartComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','TRUNCATE TABLE IF EXISTS" + res.getColumnValue(5) + "', '" + strRunCluster + "',QueryTag('" + PAPPLICATIONNAME + "','" + PMODULENAME + "',NULL));";

				sqlStmtLogEnd = ""; 
				sqlStmtLogEnd ="CALL sp_EndComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','TRUNCATE TABLE IF EXISTS"  + res.getColumnValue(5) + "', '"+ strRunCluster + "', to_char(1));";
			
		   
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
;