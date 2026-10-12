/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_agg_header_or_footer
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  2.0	2022-06-13 Nikolai Toknov	Change script. Remove T_CNTL_DIM_A_CALC_RULES
#-------------------------------------------------------------------------------
*/


/* 
The logic of the procedure is:
1) getting a template from the T_CNTL_DIM_A_SQL_TEMPLATES table based on the incoming pASqlTemplateName parameter  
2) making substitution for the #A_TABLE_NAME#,#A_TABLE_SCHEMA#,#A_LEVEL_ID# variables

Scope:  
The procedure is used for simple templates where only a few variable substitutions need to be made. 
It is mainly used to generate the start and end of the scripts. 

---------------------------------------------------------------------
PROCEDURE	:	sp_agg_header_or_footer(pATableName STRING, pATableSchema STRING, pASqlTemplateName STRING, pALevelId DOUBLE, pSortOrderNr STRING)
Input		:   pATableName 		STRING  -- Table name
				pATableSchema       STRING  -- Name of scheme
				pASqlTemplateName   STRING  -- Name of the template from the table T_CNTL_DIM_A_SQL_TEMPLATES
				pALevelId 			DOUBLE  -- Aggregation level number (A_LEVEL_ID) from table T_CNTL_DIM_A_LEVEL
				pSortOrderNr        DOUBLE	-- Sequence number with which the generated script will be written to the T_CNTL_AGG_SQL_TEXT table. Affects the order of SQL statements in the final script. 			
Return		:	Error + Error Msg / Complemented teplate with variables for debagging
Resutl		:	Row of the transformed and completed template in table T_CNTL_AGG_SQL_TEXT
Convert		:	None    
Description	:   
Example		:	Call sp_agg_header_or_footer('T_A_ADV_WEEK_MEDIUM_2','P_LEW_MART_PIT_2','template_T_A_header', 8, 1); 
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_agg_header_or_footer (
      pATableName      		STRING 
    , pATableSchema         STRING 
	, pASqlTemplateName		STRING
    , pALevelId	 			DOUBLE
    , pSortOrderNr			DOUBLE 
)
  RETURNS STRING
  LANGUAGE javascript
  STRICT
  AS
  $$

		var strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "";
		var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;";
		var strSchema = "P_LEW_MART_PIT_2";
		var strTemplate = "agg_header";
		var strOut = "";
		var dSortOrder = -1;
				
		// CHECK INPUT pSchema 
		if ((PATABLESCHEMA === "") || (typeof(PATABLESCHEMA) === "undefined") || (PATABLESCHEMA.length === 0) || (PATABLESCHEMA === null)) { 
			PATABLESCHEMA = strSchema; 
		} else {
			strSchema = PATABLESCHEMA.toUpperCase();
		}

		// CHECK INPUT pASqlTempalteName 
		if ((PASQLTEMPLATENAME === "") || (typeof(PASQLTEMPLATENAME) === "undefined") || (PASQLTEMPLATENAME.length === 0) || (PASQLTEMPLATENAME === null)) { 
			PASQLTEMPLATENAME = strTemplate; 
		} else {
			strTemplate = PASQLTEMPLATENAME.toUpperCase();
		}

		// CHECK INPUT SortOrderNr 
		if ((PSORTORDERNR < 0) || (PSORTORDERNR === "") || (typeof(PSORTORDERNR) === "undefined") || (PSORTORDERNR.length === 0) || (PSORTORDERNR === null)) { 
			PSORTORDERNR = dSortOrder; 
		} else {
			dSortOrder = PSORTORDERNR;
		}
		
		
		sqlStmt = "";
		sqlStmt = `		
			SELECT 
				CHR(13) || A_SQL_TEMPLATE || CHR(13) || CHR(13) AS A_SQL_TEMPLATE
			FROM #PSCHEMA#.T_CNTL_DIM_A_SQL_TEMPLATES 
			WHERE TRUE 
				AND DELETED_FG=0 
				AND LOWER(TRIM(A_SQL_TEMPLATE_NAME)) = '#PTEMPLATE#'
				/*AND 1::INTEGER = 
					(
						SELECT 
							iff(COUNT(1)>0,1::INTEGER,0::INTEGER) 
						FROM #PSCHEMA#.T_CNTL_DIM_A_CALC_RULES
						WHERE TRUE	
							AND DELETED_FG 		= 0 
							AND A_LEVEL_ID 		= #PALEVELID#
							AND A_TABLE_SCHEMA	= '#PSCHEMA#'
							AND A_TABLE_NAME	= '#PATABLENAME#'
					)*/
			GROUP BY 1
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PATABLENAME#/g,PATABLENAME.toUpperCase());
		sqlStmt = sqlStmt.replace(/#PALEVELID#/g,PALEVELID);
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
		sqlStmt = sqlStmt.replace(/#PTEMPLATE#/g,strTemplate.toLowerCase());
		
        // Retrieve next Template
        try{
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            msg = "StartComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			
        }
        res.next();
        // res.getColumnValue(1) = Template (Header)
	
        strOut = "";
        strOut = res.getColumnValue(1);
       	strOut = strOut.replace(/#A_TABLE_NAME#/g,PATABLENAME.toUpperCase());
		strOut = strOut.replace(/#A_TABLE_SCHEMA#/g,strSchema);
		strOut = strOut.replace(/#A_LEVEL_ID#/g,PALEVELID);	
		strOut = strOut.replace(/'/g,"''");	

	
		sqlStmt = "";
		sqlStmt = `
			INSERT INTO #PSCHEMA#.T_CNTL_AGG_SQL_TEXT 
			(
				  SQL_TEXT
				, A_TABLE_NAME
				, A_SCHEMA_NAME
				, A_LEVEL_ID
				, SORT_ORDER_NR
				, DWH_CREATED_TS
			)
			VALUES 
				( 
					  '#SQL_TEXT#' 								
					, '#PATABLENAME#'							
					, '#PSCHEMA#'							    
					, #PALEVELID#	
					, #SORTORDER#
					, CURRENT_TIMESTAMP 						
				)
		`;
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PATABLENAME#/g,PATABLENAME.toUpperCase());
		sqlStmt = sqlStmt.replace(/#PALEVELID#/g,PALEVELID);
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
		sqlStmt = sqlStmt.replace(/#SQL_TEXT#/g,strOut);
		sqlStmt = sqlStmt.replace(/#SORTORDER#/g,dSortOrder);	
	
        // Retrieve next Template
        try{
            snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            msg = "StartComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			
        }
	
		return strOut;
$$
; -- End of sp_agg_header_or_footer 

