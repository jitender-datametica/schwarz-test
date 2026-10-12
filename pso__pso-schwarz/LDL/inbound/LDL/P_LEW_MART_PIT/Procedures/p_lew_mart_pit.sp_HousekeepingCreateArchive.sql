/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_HousekeepingCreateArchive
#-------------------------------------------------------------------------------
# Describtion: 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-05-14 Nikolai Toknov    	Initial version
#-------------------------------------------------------------------------------
*/

/* TO DO: update description
---------------------------------------------------------------------
PROCEDURE	:	sp_HousekeepingCreateArchive(pSchema STRING, pTableName STRING )
Input		:   pSchema 				STRING 
				pTableName 				STRING
				pExecute				BOOLEAN
				pScope				BOOLEAN (True/False) for BEGIN Transaction and Commit. Default is FALSE not BT and COMMIT				
Return		:	Error + Error Msg or in success case name of backuped table
Convert		:	None    
Description	: 	Copies / backup important tables 
				Format: #PSCHEMA#.#PTABLENAME#_{Current TS:: YYYYMMDD_H24MISS}_TMP
Example		:	Call P_LEW_MART_PIT.sp_HousekeepingCreateArchive(-1 ,'ALL','HOUSEKEEPING',3,0);
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_HousekeepingCreateArchive (
	  pClientIds 				STRING 
	, pHouskeepingArchiveMode	STRING
	, pApplicationName			STRING
	, pPITLoggingLevel			DOUBLE
	, pLoadID					DOUBLE
	
)
  RETURNS STRING
  LANGUAGE javascript
  STRICT
  EXECUTE AS CALLER
  AS
  $$
  
   var strClient = "-1" , sqlStmt = "", sqlStmtHousekeeping="", strOut="";
   var sqlStmtStartComponentLoggingTmp = "" , sqlStmtEndComponentLoggingTmp = "";
   var sqlCreateArchive = "CREATE OR REPLACE TABLE #SF_SCHEMA#_ARCH.#SF_TABLE_NAME#_#TS# CLONE #SF_SCHEMA#.#SF_TABLE_NAME#;";
 
   var sqlStmtStartComponentLogging = "CALL sp_StartComponentLogging('${LOAD_ID}','${APPLICATION_NAME}','HOUSEKEEPING', 'CLONE TABLE #SF_SCHEMA#.#SF_TABLE_NAME#: #SQL#', '[${CLIENT_ID}]', f_QueryTag('HOUSEKEEPING','${APPLICATION_NAME}','[${CLIENT_ID}]'),'${SCHEMA}',${PIT_LOGGING_LEVEL});";
   var sqlStmtEndComponentLogging = "CALL sp_EndComponentLogging('${APPLICATION_NAME}','HOUSEKEEPING', 'CLONE TABLE #SF_SCHEMA#.#SF_TABLE_NAME#: #SQL#', '[${CLIENT_ID}]','${SCHEMA}',0,${PIT_LOGGING_LEVEL});" ;

	
	sqlStmtStartComponentLogging=sqlStmtStartComponentLogging.replace(/\${CLIENT_ID}/g,PCLIENTIDS);
	sqlStmtEndComponentLogging=sqlStmtEndComponentLogging.replace(/\${CLIENT_ID}/g,PCLIENTIDS);
	
	sqlStmtStartComponentLogging=sqlStmtStartComponentLogging.replace(/\${APPLICATION_NAME}/g,PAPPLICATIONNAME);
	sqlStmtEndComponentLogging=sqlStmtEndComponentLogging.replace(/\${APPLICATION_NAME}/g,PAPPLICATIONNAME);
	
	sqlStmtStartComponentLogging=sqlStmtStartComponentLogging.replace(/\${PIT_LOGGING_LEVEL}/g,PPITLOGGINGLEVEL.toString());
	sqlStmtEndComponentLogging=sqlStmtEndComponentLogging.replace(/\${PIT_LOGGING_LEVEL}/g,PPITLOGGINGLEVEL.toString());
	
	sqlStmtStartComponentLogging=sqlStmtStartComponentLogging.replace(/\${LOAD_ID}/g,PLOADID.toString());
	sqlStmtEndComponentLogging=sqlStmtEndComponentLogging.replace(/\${LOAD_ID}/g,PLOADID.toString());

	// STEP 1.2 choose correct tamplate
  
		
		if ((PHOUSKEEPINGARCHIVEMODE === "ALL")||(PHOUSKEEPINGARCHIVEMODE === "HK")) {
		
                sqlStmtHousekeeping=sqlCreateArchive.replace(/#TS#/g,PLOADID.toString());

				// STEP 2. Loop: take all rows from config tables
				sqlStmt = "";
				sqlStmt = `	
						select TABLE_SCHEMA as SF_SCHEMA 
							  ,TABLE_NAME as SF_TABLE_NAME
						from INFORMATION_SCHEMA.TABLES
							where TRUE
								and TABLE_TYPE='BASE TABLE'
                                and TABLE_NAME not like '%/_ARCH' escape '/'
								and TABLE_SCHEMA in ('P_LEW_MART_PIT', 'P_LEW_FE_MSTR_PIT')
								and 
									('#HOUSKEEPINGARCHIVEMODE#'='ALL'
									OR
									(TABLE_SCHEMA,TABLE_NAME) in (
											 select 
												UPPER(TRIM(SF_SCHEMA)),
												UPPER(TRIM(SF_TABLE_NAME))
												from P_LEW_MART_PIT.T_CNTL_HOUSEKEEPING_PARAM
													where current_date between VALID_FROM_DT and VALID_TO_DT
													and REJECT_FG=0
													and DELETED_FG=0
												union all
											 select 'P_LEW_MART_PIT', 'T_CNTL_PROCESSING_PARAM'
												union all 
											 select 'P_LEW_MART_PIT','T_CNTL_PROCESSING_PARAM_NORMALIZED'
												)
							);
				`;
				// Variable Substitution
						
				sqlStmt = sqlStmt.replace(/#HOUSKEEPINGARCHIVEMODE#/g,PHOUSKEEPINGARCHIVEMODE);
				
				
				// Retrieve next Template
				try{
					var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
				} catch (ERROR){
					msg = "StartComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
						
					throw new Error(msg);
					return msg ;			
				}
				
				  while ( res.next())  {
				
				  // STEP 2.1 replace parameters    

					  strOut=sqlStmtHousekeeping;

					  SF_SCHEMA = res.getColumnValue(1);
					  SF_TABLE_NAME = res.getColumnValue(2);
					  
					  strOut=strOut.replace(/#SF_SCHEMA#/g,SF_SCHEMA);
					  strOut=strOut.replace(/#SF_TABLE_NAME#/g,SF_TABLE_NAME);
					  
					  // replace parameters
	
		  

					// STEP 2.2 execute script			  
				
				// Logging
				
				sqlStmtStartComponentLoggingTmp = sqlStmtStartComponentLogging;
				sqlStmtStartComponentLoggingTmp=sqlStmtStartComponentLoggingTmp.replace(/#SF_SCHEMA#/g,SF_SCHEMA);
				sqlStmtStartComponentLoggingTmp=sqlStmtStartComponentLoggingTmp.replace(/\${SCHEMA}/g,"P_LEW_MART_PIT");
				sqlStmtStartComponentLoggingTmp=sqlStmtStartComponentLoggingTmp.replace(/#SF_TABLE_NAME#/g,SF_TABLE_NAME);
				sqlStmtStartComponentLoggingTmp=sqlStmtStartComponentLoggingTmp.replace(/#SQL#/g,strOut.replace(/\'/g,"''''")); 
				
				try{
					snowflake.createStatement( { sqlText: sqlStmtStartComponentLoggingTmp } ).execute();
				} catch (ERROR){
					msg = "StartComponentLogging: [" + sqlStmtStartComponentLoggingTmp + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
					throw new Error(msg);
					return msg ;			
				}
				
				try{
					snowflake.createStatement( { sqlText: strOut } ).execute();
				} catch (ERROR){
					msg = "StartComponentLogging: [" + strOut + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
					throw new Error(msg);
					return msg ;			
				}

				// Logging

				sqlStmtEndComponentLoggingTmp = sqlStmtEndComponentLogging;
				sqlStmtEndComponentLoggingTmp=sqlStmtEndComponentLoggingTmp.replace(/#SF_SCHEMA#/g,SF_SCHEMA);
				sqlStmtEndComponentLoggingTmp=sqlStmtEndComponentLoggingTmp.replace(/\${SCHEMA}/g,"P_LEW_MART_PIT");
				sqlStmtEndComponentLoggingTmp=sqlStmtEndComponentLoggingTmp.replace(/#SF_TABLE_NAME#/g,SF_TABLE_NAME);
				sqlStmtEndComponentLoggingTmp=sqlStmtEndComponentLoggingTmp.replace(/#SQL#/g,strOut.replace(/\'/g,"''''")); 		
				
				try{
					snowflake.createStatement( { sqlText: sqlStmtEndComponentLoggingTmp } ).execute();
				} catch (ERROR){
					msg = "StartComponentLogging: [" + sqlStmtEndComponentLoggingTmp + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
						
					throw new Error(msg);
					return msg ;			
				}
				
				}
	}
  
  return strOut;
	
  $$
;