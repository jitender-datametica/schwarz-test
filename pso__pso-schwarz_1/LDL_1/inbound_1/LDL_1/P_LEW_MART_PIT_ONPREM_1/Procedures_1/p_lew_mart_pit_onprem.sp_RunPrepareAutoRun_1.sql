CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_RunPrepareAutoRun (
      pSchema      				STRING 

	, pPitManualRunFg			DOUBLE
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
// PROCEDURE	:	sp_RunBFExecutionWrapper(pClient DOUBLE, pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING)
// Input		:   pClientId 				DOUBLE --> -1 ::= All Clients
// 				pSchema 				STRING
// 				pApplicationName 		STRING
// 				pModuleName 			STRING 		
//     			pRunClusteringDesc    	STRING --> [0] running in sequence
// Return		:	Error + Error Msg or in success case number of processed Tables
// Convert		:	None    
// Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
//                 Logging is also enables  but must be enabled! 
// Example		:	CALL P_LEW_MART_PIT_ONPREM.sp_RunPrepareAutoRun (4,'P_LEW_MART_PIT_ONPREM', '2021-07-30','2021-09-01',202130,202135);
// ------------------------------------------------------------------------
// # History:
// #  1.0  2021-07-01 Andreas Kurz    	Initial version
// #  1.3  2021-11-08 Andreas Kurz		Added additional logging




		var _rowCnt = 0,  msg = "", iMaxRunsAdvWeek = 150, strActionTypeList = "2,3", strRunCluster = "[0]", sqlStmtLogStart = "", sqlStmtLogEnd = "", sqlStmtCheck = "", sqlStmtCnt = "", sqlStmt = "";
        var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;"
		  	
		if ((PPITMANUALRUNFG == "") || (PPITMANUALRUNFG == null) || (Number.isNaN(PPITMANUALRUNFG) == true) || ((PPITMANUALRUNFG != 0) && (PPITMANUALRUNFG != 3))) { 
			msg = "Missing parameter pPitManualRunFg or not a number: Mandatory Parameter must be in (0,3))";
				
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
				-- update param 42, 13, 52, 53
				UPDATE #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_1
				FROM    
				(
					SELECT *
					FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_1
					WHERE PARAM_ID IN ( 42, 13, 52, 53 ) /* PIT_MANUAL_RUN_FG | CNT_ADV_WEEK_REAGG | APT_PERIOD_ONLY_FG | RESTRICT_ACTION_TYPE_LIST */
					AND DELETED_FG = 0
					AND CURRENT_FG = 1
					/* ALWAYS TAKE MAX VERSION NR IGNORE DATE_FROM DATE_TO IN CASE OF ALREADY CLOSED PERIODS */
					QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
				) AS SRC
			
				SET
					  DWH_VALID_TO  = CURRENT_DATE() - 1
					, DWH_UPDATED   = CURRENT_TIMESTAMP
					, CURRENT_FG    = 0::SMALLINT
			
				WHERE #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM.PARAM_ID   = SRC.PARAM_ID
				AND #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM.CLIENT_ID  = SRC.CLIENT_ID
				AND #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM.VERSION_NR = SRC.VERSION_NR
				AND #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM.DELETED_FG = 0
				;		
		`;			
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		

		sqlStmtLogStart = `
			CALL #PSCHEMA#.sp_StartComponentLogging(
				 '#PAPPLICATIONNAME#'
				,'#PMODULENAME#'
				,'sp_RunPrepareAutoRun( #PSCHEMA#, #PPITMANUALRUNFG#, #PCNTADVWEEKREAGG#, #PAPTPERIODONLYFG#, #PRESTRICTACTIONTYPELIST#)'
				,'#RUNCLUSTER#'
				,QueryTag('#PAPPLICATIONNAME#','#PMODULENAME#',NULL)
				);
		`;
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PAPPLICATIONNAME#/g,PAPPLICATIONNAME.toUpperCase());
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PMODULENAME#/g,PMODULENAME.toUpperCase());
		sqlStmtLogStart = sqlStmtLogStart.replace(/#RUNCLUSTER#/g,strRunCluster);		
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PPITMANUALRUNFG#/g,PPITMANUALRUNFG);
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PCNTADVWEEKREAGG#/g,PCNTADVWEEKREAGG);		
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PAPTPERIODONLYFG#/g,PAPTPERIODONLYFG);	
		sqlStmtLogStart = sqlStmtLogStart.replace(/#PRESTRICTACTIONTYPELIST#/g,PAPTPERIODONLYFG);				
		
        // Log Start
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmtLogStart } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREAUTORUN: [" + sqlStmtLogStart + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }

        // update params
        try{
				  snowflake.createStatement( { sqlText: sqlBeginTransaction } ).execute();
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
           
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREAUTORUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        res.next()
		_rowCnt = res.getRowCount();

		sqlStmt = "";
		sqlStmt = `
		-- Update param 42 pit_manual_run_fg insert new version
		INSERT INTO #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_1
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
				, TO_DATE('9999-12-31','YYYY-MM_1-DD')    AS DWH_VALID_TO
				, PA.VERSION_NR + 1::INTEGER            AS VERSION_NR
				, 1::SMALLINT                           AS CURRENT_FG
			FROM
			(
				SELECT *
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_1
				WHERE PARAM_ID   = 42 /* PIT_MANUAL_RUN_FG */
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
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_REF_1
				WHERE PARAM_ID = 42 /* PIT_MANUAL_RUN_FG */
			) AS PAR
					ON PA.PARAM_ID = PAR.PARAM_ID
			;
		`;			
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
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
			-- Update 13 cnt_adv_week_reagg insert new version
			INSERT INTO #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_1
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
				, #PCNTADVWEEKREAGG#  					AS PARAM_VALUE
				, TO_CHAR(#PCNTADVWEEKREAGG#) 			AS PARAM_VALUE_CHAR
				, CURRENT_DATE()                        AS DWH_VALID_FROM
				, TO_DATE('9999-12-31','YYYY-MM_1-DD')    AS DWH_VALID_TO
				, PA.VERSION_NR + 1::INTEGER            AS VERSION_NR
				, 1::SMALLINT                           AS CURRENT_FG
			FROM
			(
				SELECT *
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_1
				WHERE PARAM_ID   	= 13 /* CNT_ADV_WEEK_REAGG */
				AND DELETED_FG 		= 0
				QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
			) AS PA
		
			/* PARAM REF */
			INNER JOIN
			(
				SELECT DISTINCT *
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_REF_1
				WHERE PARAM_ID = 13 /* CNT_ADV_WEEK_REAGG */
			) AS PAR
					ON PA.PARAM_ID = PAR.PARAM_ID
			;
		`;			
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PCNTADVWEEKREAGG#/g,PCNTADVWEEKREAGG);

        // Update 13 cnt_adv_week_reagg insert new version
        try{
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
           
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREAUTORUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        res.next()
		_rowCnt += res.getRowCount();

		sqlStmt = "";
		sqlStmt = `
			-- Update 53 apt_period_only_fg insert new version
			INSERT INTO #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_1
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
				, TO_DATE('9999-12-31','YYYY-MM_1-DD')    AS DWH_VALID_TO
				, PA.VERSION_NR + 1::INTEGER            AS VERSION_NR
				, 1::SMALLINT                      		AS CURRENT_FG
			FROM
			(
				SELECT *
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_1
				WHERE PARAM_ID   	= 53 /* APT_PERIOD_ONLY_FG */
				AND DELETED_FG 		= 0
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
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_REF_1
				WHERE PARAM_ID = 53 /* APT_PERIOD_ONLY_FG */
			) AS PAR
					ON PA.PARAM_ID = PAR.PARAM_ID
			;
		`;			
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PAPTPERIODONLYFG#/g,PAPTPERIODONLYFG);	

        // Update 53 apt_period_only_fg insert new version
        try{
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
           
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREAUTORUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        res.next()
		_rowCnt += res.getRowCount();

		sqlStmt = "";
		sqlStmt = `		
			-- Update param 52 restricted_action_type_list insert new version
			INSERT INTO #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_1
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
				, TO_DATE('9999-12-31','YYYY-MM_1-DD')    AS DWH_VALID_TO
				, PA.VERSION_NR + 1::INTEGER            AS VERSION_NR
				, 1::SMALLINT                           AS CURRENT_FG
			FROM
			(
				SELECT *
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_1
				WHERE PARAM_ID 	= 52 /* RESTRICT_ACTION_TYPE_LIST */
				AND DELETED_FG 	= 0

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
				FROM #PSCHEMA#.T_PIT_SCOPE_COUNTRY_PARAM_REF_1
				WHERE PARAM_ID = 52 /* RESTRICT_ACTION_TYPE_LIST */
			) PAR
					ON PA.PARAM_ID = PAR.PARAM_ID
			;
		`;			
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA);
		sqlStmt = sqlStmt.replace(/#PRESTRICTACTIONTYPELIST#/g,PRESTRICTACTIONTYPELIST);		

        // Update param 52 restricted_action_type_list insert new version
        try{
            res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
            snowflake.createStatement( { sqlText: sqlCommit } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREAUTORUN: [" + sqlStmt + sqlStmtCnt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
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
				,'sp_RunPrepareAutoRun( #PSCHEMA#, #PPITMANUALRUNFG#, #PCNTADVWEEKREAGG#, #PAPTPERIODONLYFG#, #PRESTRICTACTIONTYPELIST#)'
				,'#RUNCLUSTER#'
				,'#ROWCOUNT#'
				);
		`;
	
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PAPPLICATIONNAME#/g,PAPPLICATIONNAME.toUpperCase());
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PMODULENAME#/g,PMODULENAME.toUpperCase());
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#RUNCLUSTER#/g,strRunCluster);		
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PPITMANUALRUNFG#/g,PPITMANUALRUNFG);
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PCNTADVWEEKREAGG#/g,PCNTADVWEEKREAGG);		
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PAPTPERIODONLYFG#/g,PAPTPERIODONLYFG);	
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#PRESTRICTACTIONTYPELIST#/g,PRESTRICTACTIONTYPELIST);			
		sqlStmtLogEnd = sqlStmtLogEnd.replace(/#ROWCOUNT#/g,_rowCnt.toString());
		
		
        // Log End
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmtLogEnd } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNPREPAREAUTORUN: [" + sqlStmtLogEnd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		
		// Loop all results
		var _rowCnt = res.getRowCount();
	

		return "" + _rowCnt;			
$$
;