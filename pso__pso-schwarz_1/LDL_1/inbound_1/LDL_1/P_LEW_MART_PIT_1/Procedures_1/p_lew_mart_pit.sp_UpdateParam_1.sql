/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_UpdateParam
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
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_MART_PIT_1; 

	DROP PROCEDURE IF EXISTS P_LEW_MART_PIT.sp_UpdateParam(STRING, STRING, STRING, DOUBLE, STRING, BOOLEAN)
	;
	-- DESCRIBE PROCEDURE sp_UpdateParam(STRING, STRING, STRING, DOUBLE, STRING, BOOLEAN)
	-- SHOW USER PROCEDURES
	-- SELECT get_ddl('PROCEDURE','SP_UPDATEPARAM')
	-- Check QH: SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));

	Call sp_RunSearchOptimization('P_LEW_MART_PIT_1','PITonCloud','Performance','',100,FALSE);
	SELECT * FROM P_LEW_MART_PIT.T_CNTL_PROCESSING_PARAM_1 WHERE CLIENT_ID = 21 AND PARAM_ID IN (1, 40, 41)
*/

/* 
---------------------------------------------------------------------
PROCEDURE	:	sp_UpdateParam(pApplicationName STRING, pPCLIENTIDingDesc STRING)
Input		:   pClientId 			STRING 
				pSchema				STRING
				pParamName			STRING
				pParamValue			DOUBLE
				pParamValueChar		STRING
				pScope				BOOLEAN (True/False) for BEGIN Transaction and Commit. Default is FALSE not BT and COMMIT
Return		:	Error + Error Msg | Success Nbr of rows (modules and or compenents) of this run
Convert		:	None    
Description	: 	Updating various Parameters. 
Example		:	Call P_LEW_MART_PIT.sp_UpdateParam( '23','P_LEW_MART_PIT_1', 'EXEC_PIT_MANUAL_RUN_FG', 2 , NULL);
				Call P_LEW_MART_PIT.sp_UpdateParam( '23','P_LEW_MART_PIT_1', 'EXEC_PIT_MANUAL_COUNTRY_LST', NULL , '');
				
				Call sp_UpdateParam( '23','P_LEW_MART_PIT_1', 'START_DT_REAGG', CAST( to_char('${START_DT_REAGG}'::DATE,'YYYYMMDD') AS INTEGER), null); --START_DT_REAGG
				Call sp_UpdateParam( '23','P_LEW_MART_PIT_1', 'EXEC_PIT_MANUAL_COUNTRY_LST', null, '${EXEC_PIT_MANUAL_COUNTRY_LST}'); --EXEC_PIT_MANUAL_COUNTRY_LST
				Call P_LEW_MART_PIT.sp_UpdateParam( '21','P_LEW_MART_PIT_1', 'START_DT_PIT_DATA'                , CAST( to_char('2022-03-23'::DATE,'YYYYMMDD') AS INTEGER) , NULL)				
				Call P_LEW_MART_PIT.sp_UpdateParam( '21','P_LEW_MART_PIT_1', 'START_DT_PIT_DATA'                , CAST( to_char('2022-03-24'::DATE,'YYYYMMDD') AS INTEGER) , NULL, TRUE)
					, pScope				BOOLEAN
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_UpdateParam (
      pClientId    			STRING    
	, pSchema				STRING	
	, pParamName			STRING
	, pParamValue			DOUBLE
	, pParamValueChar		STRING	

)
  RETURNS STRING
  LANGUAGE javascript
  CALLED ON NULL INPUT
  AS
  $$
	  
  		var _rowCnt = 0,  msg = "", SQLCODE = 0, SQLSTATE = '00000', strClient = "0", sqlStmtIns = "", sqlStmtUpd = "";
        var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;";
		var strSchema = "P_LEW_MART_PIT_1";
		var strParamValueChar = "";	
		var strClient = "-1";
		var strValue = "NULL";	
		var _bScope = new Boolean("false");
  
		// CHECK INPUT PCLIENTID 
		if ((PCLIENTID === "") || (typeof(PCLIENTID) === "undefined") || (PCLIENTID.length === 0) || (PCLIENTID === null)) { 
			PCLIENTID = strClient; 
		} else {
			strClient = PCLIENTID.toUpperCase();
		}	
		
		// 
		//if ((PSCOPE === "") || (typeof(PSCOPE) === "undefined") || (PSCOPE === null)) {
		//	_bScope = Boolean("false");
		//} else {
		//	_bScope = Boolean(PSCOPE);
		//}
		
		// CHECK INPUT pSchema 
		if ((PSCHEMA === "") || (typeof(PSCHEMA) === "undefined") || (PSCHEMA.length === 0) || (PSCHEMA === null)) { 
			PSCHEMA = strSchema; 
		} else {
			strSchema = PSCHEMA.toUpperCase();
		}
		
		
		// CHECK INPUT pParamValueChar 
		if ((PPARAMVALUE === "") || (typeof(PPARAMVALUE) === "undefined") || (PPARAMVALUE.length === 0) || (PPARAMVALUE === null)) { 
			PPARAMVALUE = strValue; 
		}		

		
		// CHECK INPUT pParamValueChar 
		if ((PPARAMVALUECHAR === "") || (typeof(PPARAMVALUECHAR) === "undefined") || (PPARAMVALUECHAR.length === 0) || (PPARAMVALUECHAR === null)) { 
			PPARAMVALUECHAR = strParamValueChar; 
		} else {
			strParamValueChar = PPARAMVALUECHAR.toUpperCase();
		}		
		
		if ((PPARAMNAME === "") || (typeof(PPARAMNAME) === "undefined") || (PPARAMNAME.length === 0) || (PPARAMNAME === null)) { 
			msg = "Missing parameter pParamName";
				
			throw new Error(msg);				
			return msg ;  
		}		
		

		sqlStmtUpd = "";
		sqlStmtUpd = `
			-- update param #PPARAMID# for client [ #PCLIENTID# ]
			UPDATE #PSCHEMA#.T_CNTL_PROCESSING_PARAM_1 trg
			FROM    
			(
			
				SELECT 
					  pa.CLIENT_ID
					, pa.PARAM_ID
					, pa.VERSION_NR
				FROM
					(
					SELECT 
						  CLIENT_ID
						, PARAM_ID
						, VERSION_NR
					FROM #PSCHEMA#.T_CNTL_PROCESSING_PARAM_1					
					WHERE TRUE
						AND CLIENT_ID 	IN ( #PCLIENTID# )
						AND DELETED_FG 	= 0
						AND CURRENT_FG 	= 1
						AND REJECT_FG  	= 0
					/* ALWAYS TAKE MAX VERSION NR IGNORE DATE_FROM DATE_TO IN CASE OF ALREADY CLOSED PERIODS */
					QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
				) pa 
				
				/* PARAM REF */
				INNER JOIN
				(
					SELECT DISTINCT
						  PARAM_ID
						, PARAM_NAME
						, PARAM_DESCR
						, PARAM_COLUMN_DATATYPE
					FROM #PSCHEMA#.T_CNTL_DIM_PROCESSING_PARAM_1
					WHERE TRUE
						AND UPPER(TRIM(PARAM_NAME))  	=  UPPER(TRIM('#PPARAMNAME#'))
						AND DELETED_FG 	= 0
						AND REJECT_FG  	= 0
					-- Deduplication 
					QUALIFY ROW_NUMBER() OVER(PARTITION BY PARAM_ID ORDER BY DWH_UPDATED_TS DESC) = 1						
				) par
				ON TRUE
					AND pa.PARAM_ID = par.PARAM_ID
					
			) src
			
			SET 
				  VALID_TO_DT  		= CURRENT_DATE() - 1
				, DWH_UPDATED_TS   	= CURRENT_TIMESTAMP
				, CURRENT_FG    	= 0::SMALLINT
			
			WHERE TRUE
				AND trg.PARAM_ID   = src.PARAM_ID
				AND trg.CLIENT_ID  = src.CLIENT_ID
				AND trg.VERSION_NR = src.VERSION_NR
				AND trg.DELETED_FG = 0
				AND trg.REJECT_FG  = 0
				AND trg.CLIENT_ID  IN ( #PCLIENTID# ) 
				;		
		`;		
		
	
		// Variable Substitution
		sqlStmtUpd = sqlStmtUpd.replace(/#PCLIENTID#/g,strClient);
		sqlStmtUpd = sqlStmtUpd.replace(/#PSCHEMA#/g,strSchema);
		sqlStmtUpd = sqlStmtUpd.replace(/#PPARAMNAME#/g,PPARAMNAME.toUpperCase());		

		sqlStmtIns = "";
		sqlStmtIns = `
		-- Update param 42 pit_manual_run_fg insert new version
			INSERT INTO #PSCHEMA#.T_CNTL_PROCESSING_PARAM_1
			(
				  CLIENT_ID
				, PARAM_ID
				, PARAM_VALUE
				, PARAM_VALUE_CHAR
				, VALID_FROM_DT
				, VALID_TO_DT
				, VERSION_NR
				, CURRENT_FG
			)
			SELECT
				  pa.CLIENT_ID
				, pa.PARAM_ID
				-- Value 			
				, CASE 
					WHEN TRIM(UPPER(PARAM_COLUMN_DATATYPE)) = 'SMALLINT' THEN
						COALESCE(CAST(#PPARAMVALUE# AS SMALLINT),-1::SMALLINT)
					WHEN TRIM(UPPER(PARAM_COLUMN_DATATYPE)) = 'INTEGER' THEN	
						COALESCE(CAST(#PPARAMVALUE# AS INTEGER),-1::INTEGER)	
					WHEN TRIM(UPPER(PARAM_COLUMN_DATATYPE)) = 'NUMBER(38,5)' THEN	
						COALESCE(CAST(#PPARAMVALUE# AS NUMBER(38,5)),-1::NUMBER(38,5))	
					WHEN TRIM(UPPER(PARAM_COLUMN_DATATYPE)) = 'DATE' THEN		
						COALESCE(CAST(#PPARAMVALUE# AS INTEGER),88881231::INTEGER)						
					WHEN TRIM(UPPER(PARAM_COLUMN_DATATYPE)) = 'VARCHAR' THEN	
						NULL
					ELSE
						NULL
				  END 									AS PARAM_VALUE
				-- Value Char
				, CASE 
					WHEN TRIM(UPPER(PARAM_COLUMN_DATATYPE)) = 'SMALLINT' THEN
						TO_CHAR(COALESCE(CAST(#PPARAMVALUE# AS SMALLINT),-1::SMALLINT))
					WHEN TRIM(UPPER(PARAM_COLUMN_DATATYPE)) = 'INTEGER' THEN			
						TO_CHAR(COALESCE(CAST(#PPARAMVALUE# AS INTEGER),-1::INTEGER))	
					WHEN TRIM(UPPER(PARAM_COLUMN_DATATYPE)) = 'NUMBER(38,5)' THEN			
						TO_CHAR(COALESCE(CAST(#PPARAMVALUE# AS NUMBER(38,5)),-1::NUMBER(38,5)))	
					WHEN TRIM(UPPER(PARAM_COLUMN_DATATYPE)) = 'DATE' THEN	
						TO_CHAR(TO_DATE(TO_CHAR(COALESCE(CAST(#PPARAMVALUE# AS INTEGER),88881231::INTEGER)),'YYYYMMDD'),'YYYY-MM_1-DD')											
					WHEN TRIM(UPPER(PARAM_COLUMN_DATATYPE)) = 'VARCHAR' THEN
						iff(len(TRIM('#PPARAMVALUECHAR#'))=0,NULL,TRIM('#PPARAMVALUECHAR#'))
					ELSE
						NULL
				  END 									AS PARAM_VALUE_CHAR
				
				, CURRENT_DATE()                        AS DWH_VALID_FROM
				, TO_DATE('9999-12-31','YYYY-MM_1-DD')    AS DWH_VALID_TO
				
				, pa.VERSION_NR + 1::INTEGER            AS VERSION_NR
				, 1::SMALLINT                           AS CURRENT_FG
			FROM
			(
				SELECT 
					  CLIENT_ID
					, PARAM_ID
					, VERSION_NR
				FROM #PSCHEMA#.T_CNTL_PROCESSING_PARAM_1
				WHERE TRUE
					AND CLIENT_ID 	IN ( #PCLIENTID# )
					AND DELETED_FG 	= 0
					AND REJECT_FG  	= 0
				-- several updates per day 
				QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
			) pa
		
			/* PARAM REF */
			INNER JOIN
			(
				SELECT DISTINCT
					  PARAM_ID
					, PARAM_NAME
					, PARAM_DESCR
					, PARAM_COLUMN_DATATYPE
				FROM #PSCHEMA#.T_CNTL_DIM_PROCESSING_PARAM_1
				WHERE TRUE
					AND UPPER(TRIM(PARAM_NAME))  =  UPPER(TRIM('#PPARAMNAME#'))
					AND DELETED_FG 	= 0
					AND REJECT_FG  	= 0
				-- Deduplication 
				QUALIFY ROW_NUMBER() OVER(PARTITION BY PARAM_ID ORDER BY DWH_UPDATED_TS DESC) = 1						
			) par
			ON TRUE
				AND pa.PARAM_ID = par.PARAM_ID
			;
		`;			
		
		// Variable Substitution
		sqlStmtIns = sqlStmtIns.replace(/#PCLIENTID#/g,strClient);
		sqlStmtIns = sqlStmtIns.replace(/#PSCHEMA#/g,strSchema);
		sqlStmtIns = sqlStmtIns.replace(/#PPARAMNAME#/g,PPARAMNAME.toUpperCase());	
		sqlStmtIns = sqlStmtIns.replace(/#PPARAMVALUE#/g,PPARAMVALUE);	
		sqlStmtIns = sqlStmtIns.replace(/#PPARAMVALUECHAR#/g,strParamValueChar);			
	
	

        try{
			//Begin Transaction
		    //if ( _bScope ) {
				snowflake.createStatement( { sqlText: sqlBeginTransaction } ).execute();
			//} // if ( _bScope )
			
			var resUpd = snowflake.createStatement( { sqlText: sqlStmtUpd } ).execute();
			var resIns = snowflake.createStatement( { sqlText: sqlStmtIns } ).execute();
			
			//End  Transaction Commit
		    //if ( _bScope ) {
				snowflake.createStatement( { sqlText: sqlCommit } ).execute();
			//} // if ( _bScope )			
        } catch (ERROR){
            msg = "UpdateParam: [" + sqlStmtUpd + sqlStmtIns + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;
        }
		
		resUpd.next();
		_rowCnt = resUpd.getRowCount();

		resIns.next();
		_rowCnt += resIns.getRowCount();
	
		return "" + _rowCnt;
		
  $$
; -- End of sp_UpdateParam