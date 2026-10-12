/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_agg_wa_template
#-------------------------------------------------------------------------------
# Describtion: 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0	2022-06-13 Nikolai Toknov	Initial version 
#-------------------------------------------------------------------------------
*/

/* 
The logic of the procedure is:
1) getting a template from the T_CNTL_DIM_A_SQL_TEMPLATES table based on the incoming pASqlTemplateName parameter  
2) making substitution for the #AGG_TABLE_NAME# variables

Scope:  
The procedure is used for simple templates where only a few variable substitutions need to be made. 
It is mainly used to generate the start and end of the scripts. 

---------------------------------------------------------------------
PROCEDURE	:	sp_agg_wa_template(pAggTableName STRING, pATableSchema STRING, pASqlTemplateName STRING, pSortOrderNr STRING)
Input		:   pAggTableName 		STRING  -- Table name
				pATableSchema       STRING  -- Name of scheme
				pASqlTemplateName   STRING  -- Name of the template from the table T_CNTL_DIM_A_SQL_TEMPLATES
				pSortOrderNr        DOUBLE	-- Sequence number with which the generated script will be written to the T_CNTL_AGG_SQL_TEXT table. Affects the order of SQL statements in the final script. 			
Return		:	Error + Error Msg / Complemented teplate with variables for debagging
Resutl		:	Row of the transformed and completed template in table T_CNTL_AGG_SQL_TEXT
Convert		:	None    
Description	:   
Example		:	Call sp_agg_wa_template('T_AGG_REGION_CENTRAL_NAN','P_LEW_MART_PIT','template_T_AGG_header', 1); 
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_agg_wa_template (
      pAggTableName      	STRING 
    , pATableSchema         STRING 
	, pASqlTemplateName		STRING
	, pSortOrderNr			DOUBLE 
)
  RETURNS STRING
  LANGUAGE javascript
  STRICT
  AS
  $$

		var strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "";
		var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;";
		var strSchema = "P_LEW_MART_PIT";
		var strTemplate = "agg_merge";
		var strOut = "";
				
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
		


/////////////////////////////////////////////
		sqlStmt = "";
		sqlStmt = `		
			SELECT
				  tmp.A_SQL_TEMPLATE
			FROM
			(
				SELECT 
					CHR(13) || A_SQL_TEMPLATE || CHR(13) || CHR(13) AS A_SQL_TEMPLATE
				FROM #PSCHEMA#.T_CNTL_DIM_A_SQL_TEMPLATES 
				WHERE TRUE 
					AND DELETED_FG=0 
					AND LOWER(TRIM(A_SQL_TEMPLATE_NAME)) = '#PTEMPLATE#'
				GROUP BY 1
			) tmp
			
		`;
		
		// Variable Substitution
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

		
			
			//////////////////////// REPLACE 
			  strOut = strOut.replace(/#AGG_TABLE_NAME#/g,''.concat('P_LEW_FE_MSTR_PIT.',PAGGTABLENAME));		

			///////////////////////////////////////////

		sqlStmt = "";
		sqlStmt = `
			INSERT INTO #PSCHEMA#.T_CNTL_AGG_SQL_TEXT 
			(
				  SQL_TEXT
				, A_TABLE_NAME
				, A_SCHEMA_NAME
				, SORT_ORDER_NR
				, DWH_CREATED_TS
			)
			VALUES 
				( 
					  '#SQL_TEXT#' 								
					, '#PAGGTABLENAME#'							
					, '#PSCHEMA#'							    
					, #SORTORDER#					
					, CURRENT_TIMESTAMP 						
				)
		`;
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PAGGTABLENAME#/g,PAGGTABLENAME.toUpperCase());
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
		sqlStmt = sqlStmt.replace(/#SORTORDER#/g,dSortOrder);				

		
		strOut = strOut.replace(/'/g,"''");	//'
		sqlStmt = sqlStmt.replace(/#SQL_TEXT#/g,strOut);
		
        // Retrieve next Template
        try{
            snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            msg = "StartComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			
        }
		strOut = strOut.replace(/''/g,"'");
		///// WA
		strOut = strOut.replace(/\${CLIENT_ID}/g,"1"); 
		strOut = strOut.replace(/\${EXEC_PIT_MANUAL_RUN_FG}/g,"1");
		strOut = strOut.replace(/\${START_DT_PIT_DATA}/g,"2022-01-01");
		strOut = strOut.replace(/\${END_DT_PIT_DATA}/g,"2022-02-01");
		strOut = strOut.replace(/\${START_ADV_WEEK_REAGG}/g,"202201");
		strOut = strOut.replace(/\${END_ADV_WEEK_REAGG}/g,"202205");
		
		return strOut;
$$
; -- End of sp_agg_wa_template 
