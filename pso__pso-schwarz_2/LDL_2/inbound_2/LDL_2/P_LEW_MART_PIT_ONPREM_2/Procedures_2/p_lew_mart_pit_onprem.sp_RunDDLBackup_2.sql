CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_RunDDLBackup (
      pTableType			STRING
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
// PROCEDURE	:	sp_RunDDLBackup(pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING )
// Input		:   pTableType				STRING ((All), Tables, Views, Procedures, Functions, Sequences)
// 				pSchema 				STRING 
// 				pApplicationName 		STRING
// 				pModuleName 			STRING 		
//     			pRunClusteringDesc    	STRING --> [0] running in sequence
//     			pMaxRuns				INTEGER
// Return		:	Error + Error Msg or in success case number of processed Tables
// Convert		:	None    
// Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
//                 Logging is also enables  but must be enabled! 
// Example		:	Call sp_RunDDLBackup('P_LEW_MART_PIT_ONPREM');
// ------------------------------------------------------------------------
// # History:
// #  1.0  2021-07-01 Andreas Kurz    Initial version

		var _rowCnt = 0, iCnt = 0, iMaxRuns = 150, strTableType = "ALL", strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmtLogStart = "", sqlStmtLogEnd = "", sqlStmt = "";
		var _bLogging = new Boolean("false");
        
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
				/* Extract Tables */
				Table_Schema || '.' || Table_Name  AS NAME_SCHEMA
				, Table_Name  AS SF_NAME
				, 'Table' AS _TABLE_TYPE
				, 'GET_DDL( ''' || UPPER(_TABLE_TYPE) || ''',''' || NAME_SCHEMA || ''')' AS SQL_GETDDL
				, 'DESC ' || UPPER(_TABLE_TYPE) || ' ' || NAME_SCHEMA || ';' AS SQL_DESCRIBE
				, 'DROP ' || UPPER(_TABLE_TYPE) || ' IF EXISTS ' || NAME_SCHEMA || ';' AS SQL_DROP					
				, ROW_COUNT  AS RecNbr
				, TABLE_OWNER AS OWNER
				, COALESCE("COMMENT",'') AS "COMMENT"
				, to_char(CREATED,'YYYY-MM_2-DD HH24:MI:SS.FF9')	AS DWH_CREATED_TS
				, 'Last altered  TS: ' || to_char(LAST_ALTERED,'YYYY-MM_2-DD HH24:MI:SS.FF9') 		AS ANNOTATION
			FROM INFORMATION_SCHEMA.TABLES 
			WHERE TRUE 
				AND UPPER(Table_Schema) IN ('#PSCHEMA#')
				AND UPPER(Table_Name)   LIKE 'T_%' 
				AND NOT
				(   
					UPPER(Table_Name)   LIKE 'TT%' 
					OR
					UPPER(Table_Name) 	LIKE '%_TMP'
					OR
					UPPER(Table_Name) 	LIKE '%_TEST'					
					OR
					UPPER(Table_Name) 	LIKE '@%'
					OR
					UPPER(Table_Name) 	LIKE 'T_PIT_STORE_DAY_ITEM_WAWI_REAGG'					
				)
				AND
				(	
					'#PTABLETYPE#' = 'ALL' 
					OR 
					'#PTABLETYPE#' = 'TABLE'
				)
				
			UNION ALL
			
				/* Extract Views */
				SELECT 
				Table_Schema || '.' || Table_Name  AS NAME_SCHEMA
				, Table_Name  AS SF_NAME
				, 'View' AS _TABLE_TYPE
				, 'GET_DDL( ''' || UPPER(_TABLE_TYPE) || ''',''' || NAME_SCHEMA || ''')' AS SQL_GETDDL
				, 'DESC ' || UPPER(_TABLE_TYPE) || ' ' || NAME_SCHEMA || ';' AS SQL_DESCRIBE 
				, 'DROP ' || UPPER(_TABLE_TYPE) || ' IF EXISTS ' || NAME_SCHEMA || ';' AS SQL_DROP
				, -1::VARCHAR  AS RecNbr
				, TABLE_OWNER AS OWNER	
				, COALESCE("COMMENT",'') AS "COMMENT"
				, to_char(CREATED,'YYYY-MM_2-DD HH24:MI:SS.FF9')	AS DWH_CREATED_TS
				, 'Last altered  TS: ' || to_char(LAST_ALTERED,'YYYY-MM_2-DD HH24:MI:SS.FF9') 		AS ANNOTATION
			FROM INFORMATION_SCHEMA.VIEWS 
			WHERE TRUE 
				AND UPPER(Table_Schema) IN ('#PSCHEMA#')
				AND UPPER(Table_Name)   LIKE 'V_%' 
				AND UPPER(Table_Name)   NOT LIKE 'TT%' 
				AND UPPER(Table_Name) 	NOT LIKE '%_TMP'
				AND UPPER(Table_Name) 	NOT LIKE 'V_PIT_AUTOMATED_TESTING_RULES'
				AND UPPER(Table_Name) 	NOT LIKE '@%'					
				AND 
				(	
					'#PTABLETYPE#' = 'ALL' 
					OR 
					'#PTABLETYPE#' = 'VIEW'
				)
				
			UNION ALL
			
			SELECT 
				/* Extract Functions */										
				FUNCTION_Schema || '.' || FUNCTION_Name  AS NAME_SCHEMA
				, FUNCTION_Name  AS SF_NAME
				, 'Function' AS _TABLE_TYPE
				, 'GET_DDL( ''' || UPPER(_TABLE_TYPE) || ''',''' || FUNCTION_Name || 
				  regexp_replace(ARGUMENT_SIGNATURE, 'CLIENT([a-zA-z0-9\\_]+)|ADV([a-zA-z0-9\\_]+)|CAL([a-zA-z0-9\\_]+)|P([a-zA-z0-9\\_]+)|NET([a-zA-z0-9\\_]+)|VAT([a-zA-z0-9\\_]+)|GROSS([a-zA-z0-9\\_]+)|', '')
				  || ''')' AS SQL_GETDDL
				, 'DESC ' || UPPER(_TABLE_TYPE) || ' ' || NAME_SCHEMA || 
					regexp_replace(ARGUMENT_SIGNATURE, 'CLIENT([a-zA-z0-9\\_]+)|ADV([a-zA-z0-9\\_]+)|CAL([a-zA-z0-9\\_]+)|P([a-zA-z0-9\\_]+)|NET([a-zA-z0-9\\_]+)|VAT([a-zA-z0-9\\_]+)|GROSS([a-zA-z0-9\\_]+)|', '')
					|| ';' AS SQL_DESCRIBE	
				, 'DROP ' || UPPER(_TABLE_TYPE) || ' IF EXISTS ' || NAME_SCHEMA || 
					regexp_replace(ARGUMENT_SIGNATURE, 'CLIENT([a-zA-z0-9\\_]+)|ADV([a-zA-z0-9\\_]+)|CAL([a-zA-z0-9\\_]+)|P([a-zA-z0-9\\_]+)|NET([a-zA-z0-9\\_]+)|VAT([a-zA-z0-9\\_]+)|GROSS([a-zA-z0-9\\_]+)|', '')
					 || ';' AS SQL_DROP
				, -1::VARCHAR  AS RecNbr
				, FUNCTION_OWNER AS OWNER	
				, COALESCE("COMMENT",'') AS "COMMENT"
				, to_char(CREATED,'YYYY-MM_2-DD HH24:MI:SS.FF9')	AS DWH_CREATED_TS
				, 'Last altered  TS: ' || to_char(LAST_ALTERED,'YYYY-MM_2-DD HH24:MI:SS.FF9')
				  || '|' || ' Function Language: ' || FUNCTION_LANGUAGE 
				  || '|' || ' Function Return Data Type: ' || DATA_TYPE 
				  || '|' || ' Function Argument Signature: ' || ARGUMENT_SIGNATURE
				  || '|' || ' Function Null Call: ' || IS_NULL_CALL					  
				  AS ANNOTATION				
			FROM INFORMATION_SCHEMA.FUNCTIONS
			WHERE TRUE 
				AND UPPER(FUNCTION_Schema) IN ('#PSCHEMA#')
				AND UPPER(FUNCTION_Name)    NOT LIKE 'TT%'					
				AND UPPER(FUNCTION_Name) 	NOT LIKE '%_TMP'	
				AND UPPER(FUNCTION_Name) 	NOT LIKE '@%'	
				AND
				(	
					'#PTABLETYPE#' = 'ALL' 
					OR 
					'#PTABLETYPE#' = 'FUNCTION'
				)
				
			UNION ALL
			
			SELECT 
				/* Extract Procedures */
				PROCEDURE_Schema || '.' || PROCEDURE_Name  AS NAME_SCHEMA
				, PROCEDURE_Name  AS SF_NAME
				, 'Procedure' AS _TABLE_TYPE
				, 'GET_DDL( ''' || UPPER(_TABLE_TYPE) || ''',''' || PROCEDURE_Name || 
					regexp_replace(ARGUMENT_SIGNATURE, 'CLIENT([a-zA-z0-9\\_]+)|ADV([a-zA-z0-9\\_]+)|CAL([a-zA-z0-9\\_]+)|P([a-zA-z0-9\\_]+)|NET([a-zA-z0-9\\_]+)|VAT([a-zA-z0-9\\_]+)|GROSS([a-zA-z0-9\\_]+)|', '')
					|| ''')' AS SQL_GETDDL
				, 'DESC ' || UPPER(_TABLE_TYPE) || ' ' || NAME_SCHEMA || 
					regexp_replace(ARGUMENT_SIGNATURE, 'CLIENT([a-zA-z0-9\\_]+)|ADV([a-zA-z0-9\\_]+)|CAL([a-zA-z0-9\\_]+)|P([a-zA-z0-9\\_]+)|NET([a-zA-z0-9\\_]+)|VAT([a-zA-z0-9\\_]+)|GROSS([a-zA-z0-9\\_]+)|', '')
					|| ';' AS SQL_DESCRIBE	
				, 'DROP ' || UPPER(_TABLE_TYPE) || ' IF EXISTS ' || NAME_SCHEMA || 
					regexp_replace(ARGUMENT_SIGNATURE, 'CLIENT([a-zA-z0-9\\_]+)|ADV([a-zA-z0-9\\_]+)|CAL([a-zA-z0-9\\_]+)|P([a-zA-z0-9\\_]+)|NET([a-zA-z0-9\\_]+)|VAT([a-zA-z0-9\\_]+)|GROSS([a-zA-z0-9\\_]+)|', '')
					 || ';' AS SQL_DROP
				, -1::VARCHAR  AS RecNbr						 
				, PROCEDURE_OWNER AS OWNER	
				, COALESCE("COMMENT",'') AS "COMMENT"
				, to_char(CREATED,'YYYY-MM_2-DD HH24:MI:SS.FF9')	AS DWH_CREATED_TS
				, 'Last altered  TS: ' || to_char(LAST_ALTERED,'YYYY-MM_2-DD HH24:MI:SS.FF9')
				  || '|' || ' Procedure Language: ' || PROCEDURE_LANGUAGE 
				  || '|' || ' Procedure Return Data Type: ' || DATA_TYPE 
				  || '|' || ' Procedure Argument Signature: ' || ARGUMENT_SIGNATURE				  
				  AS ANNOTATION										 
			FROM INFORMATION_SCHEMA.PROCEDURES
			WHERE TRUE 
				AND UPPER(PROCEDURE_Schema) IN ('#PSCHEMA#')
				AND UPPER(PROCEDURE_Name)    NOT LIKE 'TT%'
				AND UPPER(PROCEDURE_Name) 	NOT LIKE '%_TMP'
				AND UPPER(PROCEDURE_Name) 	NOT LIKE '@%'						
				AND
				(	
					'#PTABLETYPE#' = 'ALL' 
					OR 
					'#PTABLETYPE#' = 'PROCEDURE'
				)				
				
			UNION ALL
  			
			SELECT 
  				/* Extract Sequence */
				SEQUENCE_Schema || '.' || SEQUENCE_Name  AS NAME_SCHEMA
				, SEQUENCE_Name  AS SF_NAME
				, 'Sequence' AS _TABLE_TYPE
				, 'GET_DDL( ''' || UPPER(_TABLE_TYPE) || ''',''' || NAME_SCHEMA || ''')' AS SQL_GETDDL
				, 'DESC ' || UPPER(_TABLE_TYPE) || ' ' || NAME_SCHEMA || ';' AS SQL_DESCRIBE	
				, 'DROP ' || UPPER(_TABLE_TYPE) || ' IF EXISTS ' || NAME_SCHEMA ||  ';' AS SQL_DROP
				, -1::VARCHAR  AS RecNbr						 
				, SEQUENCE_OWNER AS OWNER	
				, COALESCE("COMMENT",'') AS "COMMENT"
				, to_char(CREATED,'YYYY-MM_2-DD HH24:MI:SS.FF9')	AS DWH_CREATED_TS
				, 'Last altered  TS: ' || to_char(LAST_ALTERED,'YYYY-MM_2-DD HH24:MI:SS.FF9')
				  || '|' || ' Data Type: ' || DATA_TYPE 
				  || '|' || ' Start Value: ' || START_VALUE
				  || '|' || ' Next Value: ' || NEXT_VALUE
				  || '|' || ' Increment: ' || "INCREMENT"
				  || '|' || ' Min Value: ' || MINIMUM_VALUE
				  || '|' || ' Max Value: ' || MAXIMUM_VALUE
				  AS ANNOTATION	
			FROM INFORMATION_SCHEMA.SEQUENCES
			WHERE TRUE 
				AND UPPER(SEQUENCE_Schema) IN ('#PSCHEMA#')
				AND UPPER(SEQUENCE_Name)    NOT LIKE 'TT%'
				AND UPPER(SEQUENCE_Name) 	NOT LIKE '%_TMP'
				AND UPPER(SEQUENCE_Name) 	NOT LIKE '@%'
				AND
				(	
					'#PTABLETYPE#' = 'ALL' 
					OR 
					'#PTABLETYPE#' = 'SEQUENCE'
				)
			;

		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());
		sqlStmt = sqlStmt.replace(/#PTABLETYPE#/g,strTableType);
		
		// Retrieve from all uses tables
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNDDLBACKUP: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		var _rowCnt = res.getRowCount();
	
		while (res.next() && iCnt < iMaxRuns) {
		       	
			sqlStmt = "";
			sqlStmt = `
				INSERT INTO T_CNTL_DLL_RESULT_TMP_2
				(
	  				  SF_SCHEMA           	
					, NAME_SCHEMA			
					, TABLE_TYPE  
					, SF_NAME
					, OWNER	
					, RecNbr
					, DESCRIPTION
					, CREATED_TS
					, ANNOTATION
					, SQL_GETDDL    		
					, SQL_DESCRIBE			
					, SQL_DROP      		
								 
        		
				
					, SQL_RESULT
				)	
				SELECT
					  '#PSCHEMA#' 					AS SF_SCHEMA
					, '#FILE#' 						AS NAME_SCHEMA
					, '#TYPE#' 						AS TABLE_TYPE
					, '#SF_NAME#'					AS SF_NAME
					, '#OWNER#' 					AS OWNER
					, '#ROW_COUNT#' 				AS RecNbr
					, '#COMMENT#' 					AS DESCRIPTION
					, '#DWH_CREATED_TS#' 			AS CREATED_TS
					, '#ANNOTATION#' 				AS ANNOTATION
					, 'SELECT ' || '#GETDDL#'		AS SQL_GETDDL 
					, '#DESCRIBE#'					AS SQL_DESCRIBE
					, '#DROP#'						AS SQL_DROP
					, REGEXP_REPLACE(
						UPPER(#SQL_CMD#)
						,'#PSCHEMA#.','') 			AS SQL_RESULT

			`;
		
			// Variable Substitution
			sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());			
			sqlStmt = sqlStmt.replace(/#FILE#/g,			res.getColumnValue(1).toUpperCase() );
			sqlStmt = sqlStmt.replace(/#TYPE#/g,			res.getColumnValue(3).toUpperCase() );			
			sqlStmt = sqlStmt.replace(/#SF_NAME#/g,			res.getColumnValue(2).toUpperCase() );		
			sqlStmt = sqlStmt.replace(/#OWNER#/g,			res.getColumnValue(8).toUpperCase() );
			sqlStmt = sqlStmt.replace(/#ROW_COUNT#/g,		res.getColumnValue(7) );
			sqlStmt = sqlStmt.replace(/#COMMENT#/g,			res.getColumnValue(9).toUpperCase().replace(/\'/g,"''") );
			sqlStmt = sqlStmt.replace(/#ANNOTATION#/g,		res.getColumnValue(11).toUpperCase() );			
			sqlStmt = sqlStmt.replace(/#DWH_CREATED_TS#/g,	res.getColumnValue(10).toUpperCase() );
			sqlStmt = sqlStmt.replace(/#GETDDL#/g,			res.getColumnValue(4).toUpperCase().replace(/\'/g,"''") );		
			sqlStmt = sqlStmt.replace(/#DESCRIBE#/g,		res.getColumnValue(5).toUpperCase().replace(/\'/g,"''") );
			sqlStmt = sqlStmt.replace(/#DROP#/g,			res.getColumnValue(6).toUpperCase().replace(/\'/g,"''") );		
			sqlStmt = sqlStmt.replace(/#SQL_CMD#/g,			res.getColumnValue(4).toUpperCase() );							
				
			sqlStmtLogStart = "";
			sqlStmtLogStart = "CALL sp_StartComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','" + res.getColumnValue(2) + ' - ' + res.getColumnValue(1) + "', '" + strRunCluster + "',QueryTag('" + PAPPLICATIONNAME + "','" + PMODULENAME + "',NULL));";

		    sqlStmtLogEnd = ""; 
		    sqlStmtLogEnd ="CALL sp_EndComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','"  + res.getColumnValue(2) + ' - ' + res.getColumnValue(1) + "', '"+ strRunCluster + "', to_char(1));";
	
		   if ( _bLogging ) {
				try{
					snowflake.createStatement( { sqlText: sqlStmtLogStart } ).execute();
				} catch (ERROR){
					
					msg = "P_RUNDDLBACKUP: [" + sqlStmtLogStart + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
						
					throw new Error(msg);
					return msg ;
				}
			} // _bLogging

		    try{
				snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			} catch (ERROR){
			
				msg = "P_RUNDDLBACKUP: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
				throw new Error(msg);
				return msg ;
			}

			if ( _bLogging ) {
				try{
					snowflake.createStatement( { sqlText: sqlStmtLogEnd } ).execute();
				} catch (ERROR){
				
					msg = "P_RUNDDLBACKUP: [" + sqlStmtLogEnd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
					throw new Error(msg);
					return msg ;
				}
			} // _bLogging
			
			iCnt += 1;
			
		} // while result set

		try{
				snowflake.createStatement( { sqlText: "COMMIT;" } ).execute();
		} catch (ERROR){
			
				msg = "P_RUNDDLBACKUP: [" + "COMMIT" + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
				throw new Error(msg);
				return msg ;
		}
		
		return "" + _rowCnt;			
$$
;