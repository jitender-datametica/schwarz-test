/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_agg_merge
#-------------------------------------------------------------------------------
# Describtion: 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-06-05 Nikolai Toknov    Initial version
#  1.1	2022-06-27 Nikolai Toknov	 Drop column A_THEME_GRP_FG
#  1.2	2022-07-07 Nikolai Toknov	 Rename A_THEME_FG to A_THEME_GRP_FG
#  1.3  2022-07-14 Nikolai Toknov	 Added sorting of expressions, so that the script is generated the same way. 
#  1.4  2022-08-05 Nikolai Toknov	 Optimization of procedure execution (eliminating complex logic if primary KPIs are used)
#  1.5  2022-08-18 Nikolai Toknov	 Add replace for #SRC_TABLE_NAME#
#  2.0  2022-11-23 Nikolai Toknov	 Fix issue if KPI_NAME = column name for update statment. 
#  2.1	2023-03-14 Nikolai Toknov 	 Update structure. INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz)
#  2.2  2023-07-19 Nikolai Toknov	 Update scripts after snowflake 2023_04 Bundle https://docs.snowflake.com/en/release-notes/bcr-bundles/2023_04/bcr-1057  
#  2.3  2023-09-13 Andreas Kurz 	 Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									 added THEME_GRP_NAT_CAT_FG
#  2.4  2024-09-03 Nikolai Toknov	 Add A_ACTION_SUBTYPE_FG
#  2.5  2024-09-09 Nikolai Toknov	 Change tamplates name to template_T_A_update
#  2.6  2024-11-18 Nikolai Toknov	 Drop A_ACTION_SUBTYPE_FG
#-------------------------------------------------------------------------------
*/


/* 
The logic of the procedure is:
1) getting a template from the T_CNTL_DIM_A_SQL_TEMPLATES table based on the incoming pASqlTemplateName parameter  
2) The variables to be inserted into template are generated based on information about columns and KPIs (table T_CNTL_DIM_A_COLUMNS), 
	information about aggrevation levels (table T_CNTL_DIM_A_LEVEL ) and correspondence of flags to columns (table T_CNTL_DIM_A_FLAGS). 
	If the USE_ONLY_AGG_FG parameter is specified for the source in the T_CNTL_DIM_KPI_SOURCE_TABLE.CUSTOM_CONFIG table, 
	other flags from the table are ignored (this is necessary to calculate several KPIs. For example 
			TOTAL_RECEIPT_CNT       Bons Gesamt (Anz.)
			TOTAL_TURNOVER_NET_VAL  Umsatz Gesamt
				)
3) In case Template "template_T_A_update" (calculation of secondary KPIs) is used
	an additional algorithm is included to generate a correct sequence of calculating secondary KPIs 
	based on KPI dependencies (parsing of T_CNTL_DIM_CALC_CALC_KPIS.KPI_SQL expressions).

Scope:  
The procedure is used to generate SQL scripts for calculating primary and secondary KPIs to populate T_A_tables.

---------------------------------------------------------------------
PROCEDURE	:	sp_agg_merge(pATableName STRING , pATableSchema STRING, pASqlTemplateName STRING, pALevelId DOUBLE, pSrcTableName STRING, pSortOrderNr DOUBLE )
Input		:  	pATableName 		STRING -- Table name
				pATableSchema 		STRING -- Name of scheme
				pASqlTemplateName 	STRING -- Name of the template from the table T_CNTL_DIM_A_SQL_TEMPLATES
				pALevelId 			DOUBLE -- Aggregation level number (A_LEVEL_ID) from table T_CNTL_DIM_A_LEVEL 
				pSrcTableName 		STRING -- Source names for KPI calculation from table T_CNTL_DIM_KPI_SOURCE_TABLE
				pSortOrderNr 		DOUBLE -- Sequence number with which the generated script will be written to the T_CNTL_AGG_SQL_TEXT table. Affects the order of SQL statements in the final script. 				
Return		:	Error + Error Msg  / Complemented teplate with variables for debagging
Resutl		:	Row of the transformed and completed template in table T_CNTL_AGG_SQL_TEXT
Convert		:	None    
Description	: 	
Example		:	CALL sp_agg_merge('T_A_ADV_WEEK_MEDIUM_1','P_LEW_MART_PIT_1','template_T_A_merge', 21, 'T_F_STORE_DAY__T_F_STORE_ADV_PERIOD',10);
				CALL sp_agg_merge('T_A_ADV_WEEK_MEDIUM_1','P_LEW_MART_PIT_1','template_T_A_update', 21, '_ITSELF_',90);
------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_agg_merge (
      pATableName      		STRING 
    , pATableSchema         STRING 
	, pASqlTemplateName		STRING
    , pALevelId	 			DOUBLE
    , pSrcTableName			STRING
	, pSortOrderNr			DOUBLE 
)
  RETURNS STRING
  LANGUAGE javascript
  STRICT
  AS
  $$

		var strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "";
		var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;";
		var strSchema = "P_LEW_MART_PIT_1";
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
		
		
///////////////////////////  Check custom config
		sqlStmt = "";
		sqlStmt = `		
				select COALESCE(ARRAY_TO_STRING(
				  PARSE_JSON(
					JSON_EXTRACT_PATH_TEXT(
					  PARSE_JSON(CUSTOM_CONFIG)
					  ,'USE_ONLY_AGG_FG') )
				  ,''','''),'ALL')
				from #PSCHEMA#.T_CNTL_DIM_KPI_SOURCE_TABLE
				where KPI_SOURCE_TABLE_NAME='#PSRCTABLENAME#'
					AND KPI_SOURCE_TABLE_SCHEMA='#PSCHEMA#'				
		`;
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
		sqlStmt = sqlStmt.replace(/#PSRCTABLENAME#/g,PSRCTABLENAME);
		
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
	
        USE_ONLY_AGG_FG=res.getColumnValue(1);	

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

		///////////////////////////// JOIN COLUMNS
		
		sqlStmt = "";
		sqlStmt = `		
			select LISTAGG(AGG_EXP,',') WITHIN GROUP (ORDER BY A_FG_NAME,A_TYPE,AGG_EXP) ,
				   LISTAGG(AGG_INSERT_EXP,',') WITHIN GROUP (ORDER BY A_FG_NAME,A_TYPE,AGG_INSERT_EXP),
				   LISTAGG(JOIN_EXP, '') WITHIN GROUP (ORDER BY A_FG_NAME,A_TYPE,JOIN_EXP),
                   LISTAGG(AGG_COLUMNS_LIST, ',') WITHIN GROUP (ORDER BY A_FG_NAME,A_TYPE,AGG_COLUMNS_LIST),
                   LISTAGG(AGG_GROUP_BY_LIST,',') WITHIN GROUP (ORDER BY A_FG_NAME,A_TYPE,AGG_GROUP_BY_LIST),
				   LISTAGG(FLAG_LIST,',') WITHIN GROUP (ORDER BY A_FG_NAME,A_TYPE,FLAG_LIST)
                   
			from (

			select col.A_COLUMN_NAME,
			col.KPI_NAME,
			ag_col.A_FG_NAME,
			ag_col.A_COLUMN_NAME,
			ag_col.A_TYPE,
            ag_col.A_TOTAL_VALUE,
            ag_col.FG_VALUES,
			IFF(ag_col.FG_VALUES=1 AND A_TYPE='MAIN', A_FG_NAME, NULL ) AS FLAG_LIST,              
			IFF(A_TYPE='MAIN',' AND s.'||ag_col.A_COLUMN_NAME||'=t.'||ag_col.A_COLUMN_NAME||' -- debug:'||A_FG_NAME||CHAR(13)||CHAR(9)||CHAR(9),NULL ) AS JOIN_EXP,
			IFF(A_TYPE='MAIN' OR (A_TYPE='OPTI'AND col.A_COLUMN_NAME IS NOT NULL),IFF(ag_col.FG_VALUES=0,ag_col.A_TOTAL_VALUE||' AS ','COALESCE('||ag_col.A_COLUMN_NAME||','||A_DEFAULT_VALUE||') AS ')||ag_col.A_COLUMN_NAME||' -- debug:'||A_FG_NAME||CHAR(13)||CHAR(9)||CHAR(9),NULL ) AS AGG_EXP,
			IFF(A_TYPE='MAIN' OR (A_TYPE='OPTI'AND col.A_COLUMN_NAME IS NOT NULL),'s.'||ag_col.A_COLUMN_NAME||' -- debug:'||A_FG_NAME||CHAR(13)||CHAR(9)||CHAR(9),NULL ) AS AGG_INSERT_EXP,
            IFF(A_TYPE='MAIN' OR (A_TYPE='OPTI'AND col.A_COLUMN_NAME IS NOT NULL),ag_col.A_COLUMN_NAME||' -- debug:'||A_FG_NAME||CHAR(13)||CHAR(9)||CHAR(9),NULL ) AS AGG_COLUMNS_LIST,
            IFF(ag_col.FG_VALUES=1 AND (A_TYPE='MAIN' OR (A_TYPE='OPTI'AND col.A_COLUMN_NAME IS NOT NULL)),ag_col.A_COLUMN_NAME||' -- debug:'||A_FG_NAME||CHAR(13)||CHAR(9)||CHAR(9),NULL ) AS AGG_GROUP_BY_LIST              

			from 
			  #PSCHEMA#.T_CNTL_DIM_A_COLUMNS col
			  FULL JOIN --------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			  ( select * from 
			-- Agg FGs
			-- add A_THEME_GRP_NAT_CAT_FG
			-- AKU 2023-09-13 added NAT_CAT_FG
			-- NToknov 2024-09-03 Add A_ACTION_SUBTYPE_FG
			-- NToknov 2024-11-18 Drop A_ACTION_SUBTYPE_FG
			  (
				SELECT FG_NAME,FG_VALUES FROM #PSCHEMA#.T_CNTL_DIM_A_LEVEL
				UNPIVOT(FG_VALUES FOR FG_NAME IN (A_ADV_WEEK_FG,A_ADV_PERIOD_FG,A_ITEM_FG,A_ITEM_NAN_FG,A_ITEM_WGI_FG,A_ITEM_UWG_FG,A_COUNTRY_FG,A_WAREHOUSE_FG,A_THEME_GRP_INT_FG,A_THEME_GRP_NAT_FG,A_THEME_GRP_NAT_CAT_FG,A_MEDIUM_FG,A_MEDIUM_GRP_FG,A_ACTION_TYPE_FG))
				where A_TABLE_SCHEMA='#PSCHEMA#'
				and A_TABLE_NAME='#PATABLENAME#'
				and A_LEVEL_ID=#PALEVELID#
				and DELETED_FG=0
				and FG_VALUES in (0,1)
			  ) as ag_fg
			  join 
			  #PSCHEMA#.T_CNTL_DIM_A_FLAGS fg
			  ON TRUE
			  AND fg.DELETED_FG=0
			  AND fg.A_FG_NAME=ag_fg.FG_NAME
			  AND ('ALL' in ('#USE_ONLY_AGG_FG#') OR fg.A_FG_NAME in ('#USE_ONLY_AGG_FG#'))
				) ag_col
			   ON col.A_COLUMN_NAME=ag_col.A_COLUMN_NAME
			  AND col.DELETED_FG=0
			  AND col.A_TABLE_SCHEMA='#PSCHEMA#'
			  and col.A_TABLE_NAME='#PATABLENAME#'
			)  
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PATABLENAME#/g,PATABLENAME.toUpperCase());
		sqlStmt = sqlStmt.replace(/#PALEVELID#/g,PALEVELID);
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
		sqlStmt = sqlStmt.replace(/#USE_ONLY_AGG_FG#/g,USE_ONLY_AGG_FG);
		
        // Retrieve next Template
        try{
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            msg = "StartComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			
        }
        res.next();
		AGG_EXP = res.getColumnValue(1);
		AGG_INSERT_EXP = res.getColumnValue(2);
		JOIN_EXP = res.getColumnValue(3);
		AGG_COLUMNS_LIST = res.getColumnValue(4);
		AGG_GROUP_BY_LIST = res.getColumnValue(5);
		FLAG_LIST = res.getColumnValue(6); // will be replased on the last step
		
		///////////////////////////////////////////
	
	
		///////////////////////////// KPI
			
			sqlStmt = "";
			sqlStmt = `		
				select 
					LISTAGG(KPI_COLUMNS_LIST,',') WITHIN GROUP (ORDER BY KPI_NAME) ,
					LISTAGG(KPI_EXP,',') WITHIN GROUP (ORDER BY KPI_NAME) ,
					LISTAGG(KPI_UPDATE_EXP,',') WITHIN GROUP (ORDER BY KPI_NAME) ,
					LISTAGG(KPI_INSERT_EXP,',') WITHIN GROUP (ORDER BY KPI_NAME) ,
					MAX (A_SCRIPT_FROM_CLAUSE_SQL) as SCRIPT_FROM_CLAUSE_SQL
					from (
					select col.A_COLUMN_NAME||CHAR(13)||CHAR(9)||CHAR(9) as KPI_COLUMNS_LIST,  
						kpi.KPI_NAME,
						kpi.KPI_SQL,
						kpi_src.A_SCRIPT_FROM_CLAUSE_SQL,
						col.A_COLUMN_NAME||CHAR(13)||CHAR(9)||CHAR(9) AS COLUMNS_LIST,
						kpi.KPI_SQL||' AS '||kpi.KPI_NAME||CHAR(13)||CHAR(9)||CHAR(9) AS  KPI_EXP,
						's.'||kpi.KPI_NAME||CHAR(13)||CHAR(9)||CHAR(9) AS  KPI_INSERT_EXP,
						't.'||col.A_COLUMN_NAME||'=s.'||kpi.KPI_NAME||CHAR(13)||CHAR(9)||CHAR(9)  AS KPI_UPDATE_EXP
					from #PSCHEMA#.T_CNTL_DIM_A_COLUMNS col 
					join #PSCHEMA#.T_CNTL_DIM_CALC_KPIS kpi
						on kpi.DELETED_FG=0
						and kpi.KPI_NAME=col.KPI_NAME
					join #PSCHEMA#.T_CNTL_DIM_KPI_SOURCE_TABLE kpi_src
						on kpi_src.DELETED_FG=0
						and kpi_src.KPI_SOURCE_TABLE_NAME=kpi.KPI_SOURCE_TABLE_NAME
						and kpi_src.KPI_SOURCE_TABLE_SCHEMA=kpi.KPI_SOURCE_TABLE_SCHEMA
					where col.DELETED_FG=0
							AND col.A_TABLE_SCHEMA='#PSCHEMA#'
							and col.A_TABLE_NAME='#PATABLENAME#'
							and kpi_src.KPI_SOURCE_TABLE_NAME='#PSRCTABLENAME#'
					  )  
			`;
			
			// Variable Substitution
			sqlStmt = sqlStmt.replace(/#PATABLENAME#/g,PATABLENAME.toUpperCase());
			sqlStmt = sqlStmt.replace(/#PALEVELID#/g,PALEVELID);
			sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
			sqlStmt = sqlStmt.replace(/#PSRCTABLENAME#/g,PSRCTABLENAME);
			
			// Retrieve next Template
			try{
				var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			} catch (ERROR){
				msg = "StartComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
				throw new Error(msg);
				return msg ;			
			}
			res.next();
			KPI_COLUMNS_LIST = res.getColumnValue(1);
			KPI_EXP = res.getColumnValue(2);
			KPI_UPDATE_EXP = res.getColumnValue(3);
			KPI_INSERT_EXP = res.getColumnValue(4);
			SCRIPT_FROM_CLAUSE_SQL = res.getColumnValue(5);

			
			///////////////////////////// KPI for SELF-merge
			// opimisation
			if (PASQLTEMPLATENAME.toUpperCase() === "template_T_A_update".toUpperCase()) { 
			
				sqlStmt = "";
				sqlStmt = `					
							with col_kpi as (
								select kpi.KPI_NAME, col.A_COLUMN_NAME, kpi.KPI_SQL
												from #PSCHEMA#.T_CNTL_DIM_A_COLUMNS col 
												join #PSCHEMA#.T_CNTL_DIM_CALC_KPIS kpi
													on kpi.DELETED_FG=0
													and kpi.KPI_NAME=col.KPI_NAME
												join #PSCHEMA#.T_CNTL_DIM_KPI_SOURCE_TABLE kpi_src
													on kpi_src.DELETED_FG=0
													and kpi_src.KPI_SOURCE_TABLE_NAME=kpi.KPI_SOURCE_TABLE_NAME
													and kpi_src.KPI_SOURCE_TABLE_SCHEMA=kpi.KPI_SOURCE_TABLE_SCHEMA
												where col.DELETED_FG=0
														AND col.A_TABLE_SCHEMA='#PSCHEMA#'
														and col.A_TABLE_NAME='#PATABLENAME#'
														and kpi_src.KPI_SOURCE_TABLE_NAME='#PSRCTABLENAME#'
											),
							rel_kpi as (select  distinct
												exp.KPI_NAME,
												exp.A_COLUMN_NAME,
												exp.KPI_SQL,
												--f.value AS COL_FROM_EXP,
												col_kpi.A_COLUMN_NAME as PRIOR_A_COLUMN_NAME
										from 
											(select * ,
											 REGEXP_EXTRACT_ALL (KPI_SQL,'([a-zA-Z0-9_$#])+') EXP_COL_ARRAY
											from col_kpi) exp 
										join lateral flatten(input => exp.EXP_COL_ARRAY) f
										-- v2.2
										--   on true
										join col_kpi
											on upper(col_kpi.A_COLUMN_NAME)=upper(f.value)
											-- Add v.2.0
											and upper(col_kpi.A_COLUMN_NAME)<>exp.KPI_NAME
										),
							kpi_hier as ( select 
											  KPI_NAME,
											  A_COLUMN_NAME,
											  KPI_SQL,
											  PRIOR_A_COLUMN_NAME, 
											  level
										   from (
												  select  col_kpi.KPI_NAME,
														  col_kpi.A_COLUMN_NAME,
														  col_kpi.KPI_SQL,
														  rel_kpi.PRIOR_A_COLUMN_NAME
												  from  col_kpi 
													left join rel_kpi
														on col_kpi.A_COLUMN_NAME=rel_kpi.A_COLUMN_NAME )
												  start with PRIOR_A_COLUMN_NAME is null
													CONNECT BY   PRIOR_A_COLUMN_NAME =  PRIOR A_COLUMN_NAME        
												 )


							select 
							   LISTAGG(CALC_EXP,',') WITHIN GROUP (ORDER BY ORDER_NUMBER, KPI_NAME) ,
								LISTAGG(CALC_UPDATE_EXP,',') WITHIN GROUP (ORDER BY ORDER_NUMBER,KPI_NAME) 
								from (select 
										 KPI_NAME,
										 A_COLUMN_NAME,
										 KPI_SQL,
										 MAX(level) ORDER_NUMBER,
										 LISTAGG(PRIOR_A_COLUMN_NAME, ',') PRIOR_A_COLUMNS,
										 f_change_KPI_EXP (KPI_SQL,PRIOR_A_COLUMNS)||' AS _'||A_COLUMN_NAME||CHAR(13)||CHAR(9)||CHAR(9) AS  CALC_EXP,
										 't.'||A_COLUMN_NAME||'=s._'||A_COLUMN_NAME||CHAR(13)||CHAR(9)||CHAR(9)  AS CALC_UPDATE_EXP
									 from kpi_hier
									 group by KPI_NAME,
									A_COLUMN_NAME,
									KPI_SQL
										)

				`;
				
				// Variable Substitution
				sqlStmt = sqlStmt.replace(/#PATABLENAME#/g,PATABLENAME.toUpperCase());
				sqlStmt = sqlStmt.replace(/#PALEVELID#/g,PALEVELID);
				sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
				sqlStmt = sqlStmt.replace(/#PSRCTABLENAME#/g,PSRCTABLENAME);
				
				// Retrieve next Template
				try{
					var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
				} catch (ERROR){
					msg = "StartComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
						
					throw new Error(msg);
					return msg ;			
				}
				res.next();
				CALC_EXP = res.getColumnValue(1);
				CALC_UPDATE_EXP = res.getColumnValue(2);
				
				/// replace

				strOut = strOut.replace(/#CALC_EXP#/g,CALC_EXP);
				strOut = strOut.replace(/#CALC_UPDATE_EXP#/g,CALC_UPDATE_EXP);
				
	
			}
			
			
			//////////////////////// REPLACE 
			///  replace 
			strOut = strOut.replace(/#SCRIPT_FROM_CLAUSE_SQL#/g,SCRIPT_FROM_CLAUSE_SQL);
			strOut = strOut.replace(/#A_TABLE_NAME#/g,PATABLENAME.toUpperCase());
			strOut = strOut.replace(/#A_TABLE_SCHEMA#/g,strSchema);
			strOut = strOut.replace(/#A_LEVEL_ID#/g,PALEVELID);	
			strOut = strOut.replace(/#SRC_TABLE_NAME#/g,PSRCTABLENAME);	
			
			
			/// replace KPI

			strOut = strOut.replace(/#KPI_COLUMNS_LIST#/g,KPI_COLUMNS_LIST);
			strOut = strOut.replace(/#KPI_EXP#/g,KPI_EXP);
			strOut = strOut.replace(/#KPI_UPDATE_EXP#/g,KPI_UPDATE_EXP);
			strOut = strOut.replace(/#KPI_INSERT_EXP#/g,KPI_INSERT_EXP);
			strOut = strOut.replace(/#PSCHEMA#/g,strSchema);
			
			// from AGG step
			strOut = strOut.replace(/#FLAG_LIST#/g,FLAG_LIST);
			strOut = strOut.replace(/#AGG_EXP#/g,AGG_EXP);
			strOut = strOut.replace(/#AGG_INSERT_EXP#/g,AGG_INSERT_EXP);
			strOut = strOut.replace(/#JOIN_EXP#/g,JOIN_EXP);
			strOut = strOut.replace(/#AGG_COLUMNS_LIST#/g,AGG_COLUMNS_LIST);
			strOut = strOut.replace(/#AGG_GROUP_BY_LIST#/g,AGG_GROUP_BY_LIST);
			
			// replace
			strOut = strOut.replace(/#PATABLENAME#/g,PATABLENAME.toUpperCase());
			strOut = strOut.replace(/#PALEVELID#/g,PALEVELID);
		

			///////////////////////////////////////////

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
		sqlStmt = sqlStmt.replace(/#SORTORDER#/g,dSortOrder);		
		sqlStmt = sqlStmt.replace(/#SORTORDER#/g,0);		

		
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
		strOut = strOut.replace(/\${START_DT_BASE_METRIC_NF_FA}/g,"5");
		strOut = strOut.replace(/\${END_DT_BASE_METRIC_NF_FA}/g,"6");
		
		return strOut;
$$
; -- End of sp_agg_merge 
