CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_RunPrepareManualRun (
      pSchema      				STRING 

	, pPitManualRunFg			DOUBLE
	, pPitmanualCountryList 	STRING
	, pCntAdvWeekReagg			DOUBLE
	, pAPTPeriodOnlyFg			DOUBLE 
	, pRestrictActionTypeList	STRING

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
// Example		:	CALL P_LEW_MART_PIT_ONPREM.sp_RunPrepareManualRun (4,'P_LEW_MART_PIT_ONPREM', '2021-07-30','2021-09-01',202130,202135);
// ------------------------------------------------------------------------
// # History:
// #  1.0  2021-07-01 Andreas Kurz    	Initial version
// #  1.3  2021-11-08 Andreas Kurz		Added additional logging



		var _rowCnt = 0,  msg = "", iMaxRunsAdvWeek = 150, strActionTypeList = "2,3", strRunCluster = "[0]", sqlStmtLogStart = "", sqlStmtLogEnd = "", sqlStmtCheck = "", sqlStmtCnt = "", sqlStmt = "";
        var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;"
		  
		if ((PPITMANUALRUNFG == "") || (PPITMANUALRUNFG == null) || (Number.isNaN(PPITMANUALRUNFG) == true) || (PPITMANUALRUNFG != 1) ) { 
			msg = "Missing parameter pPitManualRunFg or not a number: Mandatory Parameter must be 1)";
				
			return msg ;  
		} 		
		
		// restrict the number of reagg weeks
		if ((PCNTADVWEEKREAGG == "") || (PCNTADVWEEKREAGG == null) || (Number.isNaN(PCNTADVWEEKREAGG) == true) || PCNTADVWEEKREAGG < 1  || PCNTADVWEEKREAGG > iMaxRunsAdvWeek) { 
			PCNTADVWEEKREAGG =  iMaxRunsAdvWeek
		} 	

		if ((PRESTRICTACTIONTYPELIST == "") || (PRESTRICTACTIONTYPELIST == null) || (typeof(PRESTRICTACTIONTYPELIST) === "undefined") || (PRESTRICTACTIONTYPELIST.length === 0)) { 			
			msg = "Missing Parameter pRestrictActionTypeList To or not a number";
				
			throw new Error(msg);
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
							AND PARAM_ID IN ( 42, 43, 13, 52, 53, 6, 14, 16 ) /* PIT_MANUAL_RUN_FG | PI_MANUAL_COUNTRY_LIST | CNT_ADV_WEEK_REAGG | APT_PERIOD_ONLY_FG | RESTRICT_ACTION_TYPE_LIST | START_DT_PIT_DATA | START_DT_PIT_DATA*/
							AND DELETED_FG = 0
							AND CLIENT_ID IN
						(
								SELECT 
									CtrList.Value AS CLIENT_ID
								FROM
									TABLE(SPLIT_TO_TABLE('#PPITMANUALCOUNTRYLIST#',','))  CTRLIST
								WHERE TRUE
									AND CTRLIST.VALUE 				IS NOT NULL
									AND LENGTH(TRIM(CTRLIST.VALUE)) > 0
								GROUP BY 1
							)
						/* ALWAYS TAKE MAX VERSION NR IGNORE DATE_FROM DATE_TO IN CASE OF ALREADY CLOSED PERIODS */
						QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
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
				,'sp_RunPrepareManualRun( #PSCHEMA#, #PPITMANUALRUNFG#, #PPITMANUALCOUNTRYLIST#, #PCNTADVWEEKREAGG#, #PAPTPERIODONLYFG#, #PRESTRICTACTIONTYPELIST#)'
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
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PCNTADVWEEKREAGG#/g,PCNTADVWEEKREAGG);		
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PAPTPERIODONLYFG#/g,PAPTPERIODONLYFG);	
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PRESTRICTACTIONTYPELIST#/g,PAPTPERIODONLYFG);		
		
        // Log Start
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmtLogStart } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREMANUALRUN: [" + sqlStmtLogStart + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }

        // update params
        try{
				  snowflake.createStatement( { sqlText: sqlBeginTransaction } ).execute();
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
           
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
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
			SELECT
				  PA.CLIENT_ID
				, PA.PARAM_ID
				, PAR.PARAM_NAME
				, #PPITMANUALRUNFG#    					AS PARAM_VALUE
				, TO_CHAR(#PPITMANUALRUNFG#)         	AS PARAM_VALUE_CHAR
				, CURRENT_DATE()                        AS DWH_VALID_FROM
				, TO_DATE('9999-12-31','YYYY-MM-DD')    AS DWH_VALID_TO
				, PA.VERSION_NR + 1::INTEGER            AS VERSION_NR
				, 1::SMALLINT                           AS CURRENT_FG
			FROM
			(
				SELECT *
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
				WHERE PARAM_ID   = 42 /* PIT_MANUAL_RUN_FG */
					AND DELETED_FG = 0
				QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
			) AS PA
		
			/* PARAM REF */
			INNER JOIN
			(
				SELECT DISTINCT *
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_REF
				WHERE PARAM_ID = 42 /* PIT_MANUAL_RUN_FG */
			) AS PAR
					ON PA.PARAM_ID = PAR.PARAM_ID
		
			/* GET CLIENT_IDS FROM THE COUNTRY LIST PARAM  */
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
					ON PA.CLIENT_ID = TMP.CLIENT_ID
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
            
        	msg = "P_RUNPREPAREMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
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
				SELECT
					  PA.CLIENT_ID
					, PA.PARAM_ID
					, PAR.PARAM_NAME
					, NULL                							AS PARAM_VALUE
					, TMP._CTRLIST                        			AS PARAM_VALUE_CHAR
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
						_a.CLIENT_ID
						, _b._CTRLIST
					FROM
					(
						SELECT 
							CTRLIST.VALUE 			AS CLIENT_ID
						FROM
							TABLE(SPLIT_TO_TABLE('#PPITMANUALCOUNTRYLIST#',','))  CTRLIST
						WHERE TRUE
							AND CTRLIST.VALUE 				IS NOT NULL
							AND LENGTH(TRIM(CTRLIST.VALUE)) > 0
						GROUP BY 1
					) _a
					CROSS JOIN
					(
						SELECT 
							LISTAGG(CTRLIST.VALUE, ',') 	AS _CTRLIST 			
						FROM
							TABLE(SPLIT_TO_TABLE('#PPITMANUALCOUNTRYLIST#',','))  CTRLIST
						WHERE TRUE
							AND CTRLIST.VALUE 				IS NOT NULL
							AND LENGTH(TRIM(CTRLIST.VALUE)) > 0
					) _b				
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
            
        	msg = "P_RUNPREPAREMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
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
			SELECT DISTINCT
				  PA.CLIENT_ID
				, PA.PARAM_ID
				, PAR.PARAM_NAME
				, #PCNTADVWEEKREAGG#  					AS PARAM_VALUE
				, TO_CHAR(#PCNTADVWEEKREAGG#) 			AS PARAM_VALUE_CHAR
				, CURRENT_DATE()                        AS DWH_VALID_FROM
				, TO_DATE('9999-12-31','YYYY-MM-DD')    AS DWH_VALID_TO
				, PA.VERSION_NR + 1::INTEGER            AS VERSION_NR
				, 1::SMALLINT                           AS CURRENT_FG
			FROM
			(
				SELECT *
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
				WHERE PARAM_ID   = 13 /* CNT_ADV_WEEK_REAGG */
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
				WHERE PARAM_ID = 13 /* CNT_ADV_WEEK_REAGG */
			) AS PAR
					ON PA.PARAM_ID = PAR.PARAM_ID
		
			/* GET CLIENT_IDS FROM THE COUNTRY LIST PARAM */
			INNER JOIN
			(
				SELECT 
					CTRLIST.VALUE 			AS CLIENT_ID
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
		sqlStmt = sqlStmt.replace(/#PCNTADVWEEKREAGG#/g,PCNTADVWEEKREAGG);

        // Update 13 cnt_adv_week_reagg insert new version
        try{
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
           
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        res.next()
		_rowCnt += res.getRowCount();

		sqlStmt = "";
		sqlStmt = `
			-- Update 53 apt_period_only_fg insert new version
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
				, #PAPTPERIODONLYFG#					AS PARAM_VALUE
				, TO_CHAR(#PAPTPERIODONLYFG#)          	AS PARAM_VALUE_CHAR
				, CURRENT_DATE()                        AS DWH_VALID_FROM
				, TO_DATE('9999-12-31','YYYY-MM-DD')    AS DWH_VALID_TO
				, PA.VERSION_NR + 1::INTEGER            AS VERSION_NR
				, 1::SMALLINT                      		AS CURRENT_FG
			FROM
			(
				SELECT *
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
				WHERE PARAM_ID   = 53 /* APT_PERIOD_ONLY_FG */
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
				WHERE PARAM_ID = 53 /* APT_PERIOD_ONLY_FG */
			) AS PAR
					ON PA.PARAM_ID = PAR.PARAM_ID
		
			/* GET CLIENT_IDS FROM THE COUNTRY LIST PARAM */
			INNER JOIN
			(
				SELECT 
					  CTRLIST.VALUE 			AS CLIENT_ID
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
		sqlStmt = sqlStmt.replace(/#PAPTPERIODONLYFG#/g,PAPTPERIODONLYFG);	

        // Update 53 apt_period_only_fg insert new version
        try{
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
           
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        res.next()
		_rowCnt += res.getRowCount();

		sqlStmt = "";
		sqlStmt = `		
			-- Update param 52 restricted_action_type_list insert new version
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
				, NULL              					AS PARAM_VALUE
				, '#PRESTRICTACTIONTYPELIST#'   		AS PARAM_VALUE_CHAR
				, CURRENT_DATE                          AS DWH_VALID_FROM
				, TO_DATE('9999-12-31','YYYY-MM-DD')    AS DWH_VALID_TO
				, PA.VERSION_NR + 1::INTEGER            AS VERSION_NR
				, 1::SMALLINT                           AS CURRENT_FG
			FROM
			(
				SELECT *
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
				WHERE PARAM_ID = 52 /* RESTRICT_ACTION_TYPE_LIST */
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
				WHERE PARAM_ID = 52 /* RESTRICT_ACTION_TYPE_LIST */
			) AS PAR
					ON PA.PARAM_ID = PAR.PARAM_ID
		
			/* GET CLIENT_IDS FROM THE COUNTRY LIST PARAM  */
			INNER JOIN
			(
				SELECT 
					  CTRLIST.VALUE 			AS CLIENT_ID
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
		sqlStmt = sqlStmt.replace(/#PRESTRICTACTIONTYPELIST#/g,PRESTRICTACTIONTYPELIST);		

        // Update param 52 restricted_action_type_list insert new version
        try{
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
           
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        res.next()
		_rowCnt += res.getRowCount();
		
		sqlStmt = "";
		sqlStmt = `		
			-- Update param 14 start_dt_reagg insert new version
			-- Recalcualte  Update start_dt_reagg (14) <-- (@[end_dt_pit_data](8) - 6) - (@[cnt_adv_week_reagg](13)*7)	
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
				, TRY_TO_NUMBER(TO_CHAR(PAN.PARAM_VALUE,'YYYYMMDD'))	AS  PARAM_VALUE	
				, TO_CHAR(PAN.PARAM_VALUE, 'YYYY-MM-DD') 				AS  PARAM_VALUE_CHAR
				, CURRENT_DATE()                                  		AS  DWH_VALID_FROM
			
				, TO_DATE('9999-12-31','YYYY-MM-DD')            		AS  DWH_VALID_TO 
				, PA.VERSION_NR + 1::INTEGER                    		AS  VERSION_NR
				, 1::SMALLINT                          					AS  CURRENT_FG
			FROM
				(
				SELECT
					  PA.CLIENT_ID
					, 14::INTEGER                                                        					AS  PARAM_ID /* START_DT_REAGG */
					/*(@[END_DT_PIT_DATA](8) - 6) - (@[CNT_ADV_WEEK_REAGG](13)*7)*/
					, (PA.END_DT_PIT_DATA - 6) 
						-
					   iff(CWS.FOLLOWING_CAL_WEEK_FG=1,PA.CNT_ADV_WEEK_REAGG - 1,PA.CNT_ADV_WEEK_REAGG)*7  AS  PARAM_VALUE
				FROM 
					(
					SELECT
						PA.CLIENT_ID
						, MAX( IFF(PA.PARAM_ID = 8,TRY_TO_DATE(PA.PARAM_VALUE_CHAR,'YYYY-MM-DD'),NULL) ) 	AS END_DT_PIT_DATA
						, MAX( IFF(PA.PARAM_ID = 13,CAST(PA.PARAM_VALUE AS INTEGER),NULL) )   			  	AS CNT_ADV_WEEK_REAGG
					FROM 
						(
						SELECT CLIENT_ID, PARAM_ID, PARAM_VALUE, PARAM_VALUE_CHAR 
						FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
						WHERE TRUE
							-- AND CURRENT_DATE BETWEEN DWH_VALID_FROM AND DWH_VALID_TO
							AND DELETED_FG = 0
							AND PARAM_ID IN (8,13)
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
						QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
						) PA
					GROUP BY 1
					) PA
					
					/* # START OF ADV_WEEK DT PER COUNTRY */
					INNER JOIN #PSCHEMA#.T_COUNTRY_ADVERT_WEEK_START CWS
					ON CURRENT_DATE() BETWEEN CWS.DWH_VALID_FROM AND CWS.DWH_VALID_TO	
						AND CWS.CLIENT_ID = PA.CLIENT_ID  
						
				) PAN
				
				/* RETRIEVE MAX VERSION */
				INNER JOIN 
						(
						SELECT 
							CLIENT_ID
							, PARAM_ID
							, PARAM_NAME
							, VERSION_NR 
						FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
						
						WHERE PARAM_ID  = 14 /* START_DT_REAGG */
						AND DELETED_FG = 0 
						
						QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
						) PA
				ON  PA.CLIENT_ID  =  PAN.CLIENT_ID
				AND  PA.PARAM_ID   =  PAN.PARAM_ID
				
				/* PARAM REF */
				INNER JOIN
				(
					SELECT DISTINCT PARAM_ID, PARAM_NAME, PARAM_DESCR, PARAM_COLUMN_DATATYPE
					FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_REF 
					WHERE PARAM_ID  = 14 /* START_DT_REAGG */
				) PAR
				ON
					TRUE
					AND PA.PARAM_ID = PAR.PARAM_ID
			;
		`;			
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PPITMANUALCOUNTRYLIST#/g,PPITMANUALCOUNTRYLIST);


        // Update param 14 start_dt_reagg insert new version
		// Recalcualte  Update start_dt_reagg (14) <-- (@[end_dt_pit_data](8) - 6) - (@[cnt_adv_week_reagg](13)*7)
        try{
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        res.next()
		_rowCnt += res.getRowCount();

		sqlStmt = "";
		sqlStmt = `		
			-- Update param 6 start_dt_pit_data insert new version
			-- Overwrite in case start_dt_reagg < start_dt_pit_data else start_dt_reagg
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

				
				, TRY_TO_NUMBER(TO_CHAR(PAN.PARAM_VALUE,'YYYYMMDD')) 	AS  PARAM_VALUE
				, TO_CHAR(PAN.PARAM_VALUE,'YYYY-MM-DD') 				AS  PARAM_VALUE_CHAR
				, CURRENT_DATE()                                  		AS  DWH_VALID_FROM
			
				, TO_DATE('9999-12-31','YYYY-MM-DD')                    AS  DWH_VALID_TO 
				, PA.VERSION_NR + 1::INTEGER                            AS  VERSION_NR
				, 1::SMALLINT                          					AS  CURRENT_FG      
			FROM
				(
				SELECT
					  PA.CLIENT_ID
					, 6::INTEGER                                                        AS  PARAM_ID /* START_DT_REAGG */
					
					, CASE WHEN PA.START_DT_REAGG < PA.START_DT_PIT_DATA 
							THEN
								PA.START_DT_REAGG 
							ELSE
								PA.START_DT_PIT_DATA  
					END                                                                 AS  PARAM_VALUE
				FROM 
					(
					SELECT
						  CLIENT_ID
						, MAX( IFF(PA.PARAM_ID = 6,TRY_TO_DATE(PA.PARAM_VALUE_CHAR,'YYYY-MM-DD'),NULL) )::DATE   		AS START_DT_PIT_DATA
						, MAX( IFF(PA.PARAM_ID = 14,TRY_TO_DATE(PA.PARAM_VALUE_CHAR,'YYYY-MM-DD'),NULL) )::DATE   		AS START_DT_REAGG
					FROM
					(
						SELECT CLIENT_ID, PARAM_ID, PARAM_VALUE, PARAM_VALUE_CHAR  FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
						WHERE 1=1
							-- AND CURRENT_DATE BETWEEN DWH_VALID_FROM AND DWH_VALID_TO
							AND DELETED_FG = 0
							AND PARAM_ID IN (6,14)
							AND CLIENT_ID IN (
								SELECT 
									CTRLIST.VALUE 			AS CLIENT_ID
								FROM
									TABLE(SPLIT_TO_TABLE('#PPITMANUALCOUNTRYLIST#',','))  CTRLIST
								WHERE TRUE
									AND CTRLIST.VALUE 				IS NOT NULL
									AND LENGTH(TRIM(CTRLIST.VALUE)) > 0
								GROUP BY 1
							)
						QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
					) PA
					GROUP BY 1
					) PA
				) PAN
				
				/* RETRIEVE MAX VERSION */
				INNER JOIN 
						(
						SELECT 
							CLIENT_ID
							, PARAM_ID
							, PARAM_NAME
							, VERSION_NR 
						FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
						
						WHERE PARAM_ID  = 6 /* START_DT_PIT_DATA */
						AND DELETED_FG = 0
						
						QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
						) PA
				ON  PA.CLIENT_ID  =  PAN.CLIENT_ID
				AND  PA.PARAM_ID   =  PAN.PARAM_ID
				
				/* PARAM REF */
				INNER JOIN
				(
					SELECT DISTINCT PARAM_ID, PARAM_NAME, PARAM_DESCR, PARAM_COLUMN_DATATYPE
					FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_REF
					WHERE PARAM_ID  = 6 /* START_DT_PIT_DATA */
				) PAR
				ON
					1=1
					AND PA.PARAM_ID = PAR.PARAM_ID
			;   
		`;			
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PPITMANUALCOUNTRYLIST#/g,PPITMANUALCOUNTRYLIST);


		// Update param 6 start_dt_pit_data insert new version
		// Overwrite in case start_dt_reagg < start_dt_pit_data else start_dt_reagg
        try{
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        res.next()
		_rowCnt += res.getRowCount();

		sqlStmt = "";
		sqlStmt = `	
			-- Recalcualte  start_adv_week_reagg (16)	
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
					, 16::INTEGER                               AS  PARAM_ID /* START_ADV_WEEK_REAGG */ 
								
					, PAR.PARAM_NAME
				
					, CAST( COALESCE(CWS.ADV_WEEK_ID, CAST( NULL AS NUMBER(38,5))) AS NUMBER(38,5))
																AS 	PARAM_VALUE
					, TO_CHAR(CWS.ADV_WEEK_ID)		
																AS  PARAM_VALUE_CHAR 
					
					, CURRENT_DATE()                            AS  DWH_VALID_FROM
					, TO_DATE('9999-12-31','YYYY-MM-DD')        AS  DWH_VALID_TO    
					
					, PA.VERSION_NR + 1::INTEGER                AS  VERSION_NR
					, 1::SMALLINT                               AS  CURRENT_FG          
				FROM 
					(
						SELECT *
						FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM
						WHERE PARAM_ID IN (14) /* @[START_DT_REAGG] (14) */
						AND DELETED_FG = 0
						--AND CURRENT_DATE() BETWEEN DWH_VALID_FROM AND DWH_VALID_TO
						AND CLIENT_ID IN (
							SELECT 
								CTRLIST.VALUE 			AS CLIENT_ID
							FROM
								TABLE(SPLIT_TO_TABLE('#PPITMANUALCOUNTRYLIST#',','))  CTRLIST
							WHERE TRUE
								AND CTRLIST.VALUE 				IS NOT NULL
								AND LENGTH(TRIM(CTRLIST.VALUE)) > 0
							GROUP BY 1
							)
						QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
					) pa
				
					/*  Join the calendar lookup tables to get the Advertising Week ID for the dt parameters */
					INNER JOIN  (   
							SELECT 
								cws.client_id
								, cal.cal_dt 
								, CASE 
									WHEN cal.day_of_week >= cws.adv_week_start_day AND cws.following_cal_week_fg    = 0 THEN cal.cy_week            /* CalWeek of the date          */
									WHEN cal.day_of_week >= cws.adv_week_start_day AND cws.following_cal_week_fg    = 1 THEN nwk.cy_week            /* Next CalWeek of the date     */
									WHEN cal.day_of_week  < cws.adv_week_start_day AND cws.following_cal_week_fg    = 0 THEN cwk.cy_week_prev_1w    /* Previous CalWeek of the date */
									WHEN cal.day_of_week  < cws.adv_week_start_day AND cws.following_cal_week_fg    = 1 THEN cal.cy_week            /* Next CalWeek of the date     */
								END AS  adv_week_id
						
							FROM P_LEW_CORE_AC.v_cal_calendarday AS  cal
						
							/* # Start of adv_week dt per country */
							INNER JOIN #PSCHEMA#.t_country_advert_week_start cws
									ON cal.cal_dt BETWEEN cws.dwh_valid_from AND cws.dwh_valid_to
					
							/* # current week reference table */
							INNER JOIN P_LEW_CORE_AC.v_cal_week AS  cwk
									ON cal.cy_week = cwk.cy_week
						
							/* # next week reference table */
							INNER JOIN P_LEW_CORE_AC.v_cal_week AS  nwk
									ON cal.cy_week = nwk.cy_week_prev_1w
							
							WHERE cal.cal_dt <= CURRENT_DATE()
					
							GROUP BY 1,2,3
					
				)AS  cws
					ON PA.CLIENT_ID                   					= CWS.CLIENT_ID
					AND TO_DATE(PA.PARAM_VALUE_CHAR, 'YYYY-MM-DD')  	= CWS.CAL_DT
					
				/* param ref */
				CROSS JOIN
				(
					SELECT DISTINCT *
					FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_REF
					WHERE param_id IN (16) /* start_dt_reagg */
				) par
			;	
		`;			
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PPITMANUALCOUNTRYLIST#/g,PPITMANUALCOUNTRYLIST);


		// Recalcualte  start_adv_week_reagg (16)
		try{
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			snowflake.createStatement( { sqlText: sqlCommit } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREMANUALRUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
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
				,'sp_RunPrepareManualRun( #PSCHEMA#, #PPITMANUALRUNFG#, #PPITMANUALCOUNTRYLIST#, #PCNTADVWEEKREAGG#, #PAPTPERIODONLYFG#, #PRESTRICTACTIONTYPELIST#)'
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
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PCNTADVWEEKREAGG#/g,PCNTADVWEEKREAGG);		
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PAPTPERIODONLYFG#/g,PAPTPERIODONLYFG);	
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PRESTRICTACTIONTYPELIST#/g,PRESTRICTACTIONTYPELIST);		
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#ROWCOUNT#/g,_rowCnt.toString());
		
		
        // Log End
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmtLogEnd } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREMANUALRUN: [" + sqlStmtLogEnd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		
		// Loop all results
		var _rowCnt = res.getRowCount();
	

		return "" + _rowCnt;			
$$
;