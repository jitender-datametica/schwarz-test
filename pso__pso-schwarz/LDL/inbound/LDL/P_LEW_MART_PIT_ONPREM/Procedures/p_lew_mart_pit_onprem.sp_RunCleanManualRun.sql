CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_RunCleanManualRun (
      pSchema      				STRING 

	, pPitManualRunFg			DOUBLE
	, pPitmanualCountryList 	STRING
	
	, pApplicationName 			STRING 
	, pModuleName 				STRING 		
	, pRunClusteringDesc    	STRING 
)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  STRICT
  EXECUTE AS CALLER
  AS
  $$

// ---------------------------------------------------------------------
// PROCEDURE	:	sp_RunBFExecutionWrapper(pClient DOUBLE, pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pMaxRuns DOUBLE)
// Input		:   pClientId 				DOUBLE --> -1 ::= All Clients
// 				pSchema 				STRING
// 				pApplicationName 		STRING
// 				pModuleName 			STRING 		
//     			pRunClusteringDesc    	STRING --> [0] running in sequence
//     			pMaxRuns				DOUBLE
// Return		:	Error + Error Msg or in success case number of processed Tables
// Convert		:	None    
// Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
//                 Logging is also enables  but must be enabled! 
// Example		:	CALL P_LEW_MART_PIT_ONPREM.sp_RunCleanManualRun (4,'P_LEW_MART_PIT_ONPREM', '2021-07-30','2021-09-01',202130,202135);
// ------------------------------------------------------------------------
// # History:
// #  1.0  2021-07-01 Andreas Kurz    	Initial version
// #  1.3  2021-11-08 Andreas Kurz		Added additional logging
// #  1.4  2021-12-02 Nikolai Toknov	Change the logic for getting the previous value of the parameters (previous value -> previous value, different from the last value)


		var _rowCnt = 0,  msg = "", strRunCluster = "[0]", sqlStmtLogStart = "", sqlStmtLogEnd = "", sqlStmtCheck = "", sqlStmtCnt = "", sqlStmt = "";
        var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;"
		  	
		if ((PPITMANUALRUNFG == "") || (PPITMANUALRUNFG == null) || (Number.isNaN(PPITMANUALRUNFG) == true) || (PPITMANUALRUNFG != 1) ) { 
			msg = "Missing parameter pPitManualRunFg or not a number: Mandatory Parameter must be 1)";
				
			return msg ;  
		} 		
			
		// CHECK INPUT runcluster 
		if ((PRUNCLUSTERINGDESC === "") || (typeof(PRUNCLUSTERINGDESC) === "undefined") || (PRUNCLUSTERINGDESC.length === 0) || (PRUNCLUSTERINGDESC === null)) { 
			PRUNCLUSTERINGDESC = strRunCluster; 
		} else {
			strRunCluster = PRUNCLUSTERINGDESC.toUpperCase();
		}		
				

		sqlStmt = `
				UPDATE #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
					FROM
					(
						SELECT *
						FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
						WHERE TRUE
							AND PARAM_ID 	IN ( 42,43,13 ) /* PIT_MANUAL_RUN_FG | PI_MANUAL_COUNTRY_LIST | CNT_ADV_WEEK_REAGG | APT_PERIOD_ONLY_FG | RESTRICT_ACTION_TYPE_LIST | START_DT_PIT_DATA | START_DT_PIT_DATA*/
							AND DELETED_FG 	= 0
							/*NToknov 2021.11.30 delete condition */ --AND CURRENT_FG 	= 1
							AND CLIENT_ID IN
							(
								SELECT 
									CTRLIST.VALUE 			AS CLIENT_ID
								FROM
									TABLE(SPLIT_TO_TABLE('#PPITMANUALCOUNTRYLIST#',','))  CTRLIST
								WHERE TRUE
									AND CTRLIST.VALUE 				IS NOT NULL
									AND LENGTH(TRIM(CTRLIST.VALUE)) > 0
								GROUP BY 1						
							)
						/* ALWAYS TAKE MAX VERSION NR IGNORE DATE_FROM DATE_TO IN CASE OF ALREADY CLOSED PERIODS */
						QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
						/*NToknov 2021.11.30 protect the first version*/
						-- AND VERSION_NR <> MIN(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
						
					) AS SRC    
					SET
						  DWH_VALID_TO  = CURRENT_DATE() - 1
						, DWH_UPDATED   = CURRENT_TIMESTAMP
						, CURRENT_FG    = 0::SMALLINT 
					WHERE
						TRUE
						AND #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM.PARAM_ID     = SRC.PARAM_ID
						AND #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM.CLIENT_ID    = SRC.CLIENT_ID
						AND #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM.VERSION_NR   = SRC.VERSION_NR
						AND #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM.DELETED_FG   = 0::SMALLINT
					;
		`;			
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PPITMANUALCOUNTRYLIST#/g,PPITMANUALCOUNTRYLIST);

		sqlStmtLogStart = `
			CALL #PSCHEMA#.sp_StartComponentLogging(
				 '#PAPPLICATIONNAME#'
				,'#PMODULENAME#'
				,'sp_RunCleanManualRun( #PSCHEMA#, #PPITMANUALRUNFG#, #PPITMANUALCOUNTRYLIST#)'
				,'#RUNCLUSTER#'
				,QueryTag('#PAPPLICATIONNAME#','#PMODULENAME#',NULL)
				);
		`;
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PAPPLICATIONNAME#/g,PAPPLICATIONNAME.toUpperCase());
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PMODULENAME#/g,PMODULENAME.toUpperCase());
		sqlStmtLogStart = sqlStmtLogStart.replace(/#RUNCLUSTER#/g,strRunCluster);		
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PPITMANUALRUNFG#/g,PPITMANUALRUNFG);
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PPITMANUALCOUNTRYLIST#/g,PPITMANUALCOUNTRYLIST);
		
		
        // Log Start
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmtLogStart } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNCLEANMANUALRUN: [" + sqlStmtLogStart + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }

        // update params
        try{
				  snowflake.createStatement( { sqlText: sqlBeginTransaction } ).execute();
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
           
        } catch (ERROR){
            
        	msg = "P_RUNCLEANMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        res.next()
		_rowCnt = res.getRowCount();
		
		sqlStmt = "";
		sqlStmt = `
		-- Update param 42 pit_manual_run_fg insert new version
			INSERT INTO #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
				(
					CLIENT_ID
					, PARAM_ID
					, PARAM_NAME
					, PARAM_VALUE
					, PARAM_VALUE_CHAR
					, DWH_VALID_FROM
					, DWH_VALID_TO
					, VERSION_NR
					, CURRENT_FG
				)
				SELECT DISTINCT
					PA.CLIENT_ID
					, PA.PARAM_ID
					, PAR.PARAM_NAME
					, case when PA_PREV.PARAM_ID is not null then PA_PREV.PARAM_VALUE else PA.PARAM_VALUE end 
                                                                    AS PARAM_VALUE
					, case when PA_PREV.PARAM_ID is not null then PA_PREV.PARAM_VALUE_CHAR else PA.PARAM_VALUE_CHAR end
                                                                    AS PARAM_VALUE_CHAR
					, CURRENT_DATE()                                AS DWH_VALID_FROM
					, TO_DATE('9999-12-31','YYYY-MM-DD')            AS DWH_VALID_TO
					, PA.VERSION_NR + 1::INTEGER                    AS VERSION_NR
					, 1::SMALLINT                           		AS CURRENT_FG
				FROM
				(
					SELECT *
					FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
					WHERE PARAM_ID   		= 42 /* PIT_MANUAL_RUN_FG */
						AND DELETED_FG 		= 0
					QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
				) AS PA
			
				/* GET PREVIOUS VERSION */
				LEFT JOIN
				(
					select * from (SELECT *
					FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
					WHERE PARAM_ID   		= 42 /* PIT_MANUAL_RUN_FG */
						AND DELETED_FG 		= 0
                        QUALIFY PARAM_VALUE<>lead (PARAM_VALUE) Over(partition by CLIENT_ID, PARAM_ID order by VERSION_NR))
                         QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID) 
				) AS PA_PREV
						ON PA.PARAM_ID     	= PA_PREV.PARAM_ID
					AND PA.CLIENT_ID    	= PA_PREV.CLIENT_ID
	
				/* PARAM REF */
				INNER JOIN
				(
					SELECT DISTINCT *
					FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_REF
					WHERE PARAM_ID = 42 /* PIT_MANUAL_RUN_FG */
				) AS PAR
						ON PA.PARAM_ID         = PAR.PARAM_ID
					-- AND PA_PREV.PARAM_ID    = PAR.PARAM_ID
			
				/* ONLY CLIENTS WHICH ARE PART OF THE MANUAL REAGG PROCESS WILL BE COVERED */
				INNER JOIN
				(
					SELECT 
						CTRLIST.Value AS CLIENT_ID
					FROM
						TABLE(SPLIT_TO_TABLE('#PPITMANUALCOUNTRYLIST#',','))  CTRLIST
					WHERE TRUE
						AND CTRLIST.VALUE 				IS NOT NULL
						AND LENGTH(TRIM(CTRLIST.VALUE)) > 0
					GROUP BY 1
				) AS TMP
					ON PA.CLIENT_ID         = TMP.CLIENT_ID
					--AND PA_PREV.CLIENT_ID   = TMP.CLIENT_ID
				;		
		`;			
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PPITMANUALCOUNTRYLIST#/g,PPITMANUALCOUNTRYLIST);
		sqlStmt = sqlStmt.replace(/#PPITMANUALRUNFG#/g,PPITMANUALRUNFG);		

        // Update param 42 pit_manual_run_fg insert new version
        try{
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
           
        } catch (ERROR){
            
        	msg = "P_RUNCLEANMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        res.next()
		_rowCnt += res.getRowCount();		

		sqlStmt = "";
		sqlStmt = `		
			-- Update param 43 pit_manual_country_list insert new version
			INSERT INTO #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
				(
					  CLIENT_ID
					, PARAM_ID
					, PARAM_NAME
					, PARAM_VALUE
					, PARAM_VALUE_CHAR
					, DWH_VALID_FROM
					, DWH_VALID_TO
					, VERSION_NR
					, CURRENT_FG
				)
				SELECT DISTINCT
					  PA.CLIENT_ID
					, PA.PARAM_ID
					, PAR.PARAM_NAME
					, NULL                							AS PARAM_VALUE
					, NULL		                        			AS PARAM_VALUE_CHAR
					, CURRENT_DATE()                                AS DWH_VALID_FROM
					, TO_DATE('9999-12-31','YYYY-MM-DD')            AS DWH_VALID_TO
					, PA.VERSION_NR + 1::INTEGER                    AS VERSION_NR
					, 1::SMALLINT                            		AS CURRENT_FG
				FROM
				(
					SELECT *
					FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
					WHERE PARAM_ID   = 43 /* PIT_MANUAL_COUNTRY_LIST */
					AND DELETED_FG = 0
					QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
				) AS PA
			
				/* PARAM REF */
				INNER JOIN
				(
					SELECT DISTINCT
						PARAM_ID
						, PARAM_NAME
						, PARAM_DESCR
						, PARAM_COLUMN_DATATYPE
					FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_REF
					WHERE PARAM_ID = 43 /* PIT_MANUAL_RUN_FG */
				) AS PAR
						ON PA.PARAM_ID = PAR.PARAM_ID
			
				/* GET CLIENT_IDS FROM THE COUNTRY LIST PARAM  */
				INNER JOIN
				(
					SELECT 
						  CTRLIST.VALUE 			AS CLIENT_ID
						, LISTAGG(CLIENT_ID, ',') 	AS _CTRLIST
					FROM
						TABLE(SPLIT_TO_TABLE('#PPITMANUALCOUNTRYLIST#',','))  CTRLIST
					WHERE TRUE
						AND CTRLIST.VALUE 				IS NOT NULL
						AND LENGTH(TRIM(CTRLIST.VALUE)) > 0
					GROUP BY 1
				) AS TMP
						ON PA.CLIENT_ID = TMP.CLIENT_ID
				;
		`;			
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PPITMANUALCOUNTRYLIST#/g,PPITMANUALCOUNTRYLIST);
	
        // Update param 43 pit_manual_country_list insert new version
        try{
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
           
        } catch (ERROR){
            
        	msg = "P_RUNCLEANMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        res.next()
		_rowCnt += res.getRowCount();
		
		sqlStmt = "";
		sqlStmt = `			
			-- Update 13 cnt_adv_week_reagg insert new version
			INSERT INTO #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
				(
					CLIENT_ID
					, PARAM_ID
					, PARAM_NAME
					, PARAM_VALUE
					, PARAM_VALUE_CHAR
					, DWH_VALID_FROM
					, DWH_VALID_TO
					, VERSION_NR
					, CURRENT_FG
				)
				SELECT
					PA.CLIENT_ID
					, PA.PARAM_ID
					, PAR.PARAM_NAME
					, case when PA_PREV.PARAM_ID is not null then PA_PREV.PARAM_VALUE else PA.PARAM_VALUE end 
                                                                    AS PARAM_VALUE
					, case when PA_PREV.PARAM_ID is not null then PA_PREV.PARAM_VALUE_CHAR else PA.PARAM_VALUE_CHAR end
                                                                    AS PARAM_VALUE_CHAR
					, CURRENT_DATE()                        		AS DWH_VALID_FROM
					, TO_DATE('9999-12-31','YYYY-MM-DD')    		AS DWH_VALID_TO
					, PA.VERSION_NR + 1::INTEGER                    AS VERSION_NR
					, 1::SMALLINT                          			AS CURRENT_FG
				FROM
				(
					SELECT *
					FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
					WHERE PARAM_ID   	= 13 /* CNT_ADV_WEEK_REAGG */
					AND DELETED_FG 		= 0
					QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
				) AS PA
			
				/* GET PREVIOUS VERSION */
				LEFT JOIN
				(
					select * from (SELECT *
					FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
					WHERE PARAM_ID   = 13 /* CNT_ADV_WEEK_REAGG */
						AND DELETED_FG 		= 0
                        QUALIFY PARAM_VALUE<>lead (PARAM_VALUE) Over(partition by CLIENT_ID, PARAM_ID order by VERSION_NR))
                         QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID) 
				) AS PA_PREV
						ON PA.PARAM_ID     	= PA_PREV.PARAM_ID
					AND PA.CLIENT_ID    	= PA_PREV.CLIENT_ID				
				
				/* PARAM REF*/
				INNER JOIN
				(
					SELECT DISTINCT
						PARAM_ID
						, PARAM_NAME
						, PARAM_DESCR
						, PARAM_COLUMN_DATATYPE
					FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_REF
					WHERE PARAM_ID = 13 /* CNT_ADV_WEEK_REAGG */
				) AS PAR
						ON PA.PARAM_ID     = PAR.PARAM_ID
			
				/* ONLY CLIENTS WHICH ARE PART OF THE MANUAL REAGG PROCESS WILL BE COVERED */
				INNER JOIN
				(
					SELECT 
						CTRLIST.VALUE 				AS CLIENT_ID
						, LISTAGG(CLIENT_ID, ',') 	AS _CTRLIST
					FROM
						TABLE(SPLIT_TO_TABLE('#PPITMANUALCOUNTRYLIST#',','))  CTRLIST
					WHERE TRUE
						AND CTRLIST.VALUE 				IS NOT NULL
						AND LENGTH(TRIM(CTRLIST.VALUE)) > 0
					GROUP BY 1
				) AS TMP
						ON PA.CLIENT_ID = TMP.CLIENT_ID
					-- AND PA.CLIENT_ID = PA_PREV.CLIENT_ID
				;			
		`;			
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PPITMANUALCOUNTRYLIST#/g,PPITMANUALCOUNTRYLIST);

        // Update 13 cnt_adv_week_reagg insert new version
        try{
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			snowflake.createStatement( { sqlText: sqlCommit } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNCLEANMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        res.next()
		_rowCnt += res.getRowCount();

	
		sqlStmtLogEnd = "";
		sqlStmtLogEnd = `		
			CALL #PSCHEMA#.sp_EndComponentLogging(
				 '#PAPPLICATIONNAME#'
				,'#PMODULENAME#'
				,'sp_RunCleanManualRun( #PSCHEMA#, #PPITMANUALRUNFG#, #PPITMANUALCOUNTRYLIST#)'
				,'#RUNCLUSTER#'
				,'#ROWCOUNT#'
				);
		`;
	
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PAPPLICATIONNAME#/g,PAPPLICATIONNAME.toUpperCase());
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PMODULENAME#/g,PMODULENAME.toUpperCase());
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#RUNCLUSTER#/g,strRunCluster);		
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PPITMANUALRUNFG#/g,PPITMANUALRUNFG);
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PPITMANUALCOUNTRYLIST#/g,PPITMANUALCOUNTRYLIST);
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#ROWCOUNT#/g,_rowCnt.toString());
		
		
        // Log End
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmtLogEnd } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNCLEANMANUALRUN: [" + sqlStmtLogEnd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		
		// Loop all results
		var _rowCnt = res.getRowCount();
	

		return "" + _rowCnt;			
$$
;