/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_agg_insert
#-------------------------------------------------------------------------------
# Describtion: 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  4.0	2024-09-20 Nikolai Toknov	Add deleted flag 
#  4.1	2024-09-20 Nikolai Toknov	Add #SRC_WO_MSTR_COLUMN_NAME#
#  4.2	2024-09-20 Nikolai Toknov	Add _GID columns
#  4.3  2025-02-10 Nikolai Toknov	Add CHK_LKP_LDESCR_EXP
#  4.4	2025-04-10 Nikolai Toknov	Changed algorithm for period to period comparison 
#-------------------------------------------------------------------------------
*/

/* 
The logic of the procedure is:
1) getting a template from the T_CNTL_DIM_A_SQL_TEMPLATES table based on the incoming pASqlTemplateName parameter  
2) Creating values for rule-based field substitution variables:
	2.1) If a function value is specified in the T_CNTL_DIM_A_COLUMNS.T_CNTL_DIM_A_COLUMNS.FORMULA_NAME column, a formula is generated based on the expression in T_CNTL_DIM_CALC_FORMULA. As part of this, variable substitution is used #COLUMN_NAME#, #SRC_COLUMN_NAME#, #SRC_WO_MSTR_COLUMN_NAME#,
	#SRC_RLTD_COLUMN_NAME#, #CHK_LKP_EXP#,#PREPORTINGLINESIDS#, #PALEVELID#. 
	2.2) If a column is in the corresponding T_A-table and has an attribute label (A_COLUMN_TYPE='ATT'), then the values from it are taken.
	2.3) For the remaining columns, the LKP tables required to fill the columns are selected.  For this purpose for each lookup table (Table_name like 'LKP%') the columns labeled T_CNTL_DIM_A_COLUMNS.A_COLUMN_TYPE='KEY' for joins
	and labeled T_CNTL_DIM_A_COLUMNS.A_COLUMN_TYPE='ATT' for attributes are used.  
	If there are more than two or more lookups for attribute allocation, the priority according to the name is used. 
	A lookup is only selected if all key-columns from the source T_A-table exist in the lookup table definition. 
	To join lookup-tables, a template from the T_CNTL_DIM_A_SQL_TEMPLATES table called A_SQL_TEMPLATE_NAME = 'lkp_joins' is used. 
	2.4) If the table contains columns for week-to-week comparison (%RLTD%-columns), then a template from the T_CNTL_DIM_A_SQL_TEMPLATES table called A_SQL_TEMPLATE_NAME = 'rltd_agg'  is used to connect to the relevant table for the previous weeks. 
3) Multiple substitution operations are executed and the result is written to the T_CNTL_AGG_SQL_TEXT table.  
Scope:  
The procedure is used to generate SQL scripts for populating T_AGG-tables based on T_A tables and additional calculation of comparative KPIs. 

---------------------------------------------------------------------
PROCEDURE	:	sp_agg_insert(pAggTableName STRING , pATableSchema STRING, pASqlTemplateName STRING, pReportingLineSIDs	STRING, pALevelId DOUBLE, pSortOrderNr DOUBLE )
Input		:  	pAggTableName 		STRING -- Table name
				pATableSchema 		STRING -- Name of scheme
				pASqlTemplateName 	STRING -- Name of the template from the table T_CNTL_DIM_A_SQL_TEMPLATES
				pReportingLineSIDs	STRING -- Comma separated list of ReportingLineSIDs from table T_CNTL_DIM_A_REPORTING_LINE
				pALevelId 			DOUBLE -- Aggregation level number (A_LEVEL_ID) from table T_CNTL_DIM_A_LEVEL 
				pSortOrderNr 		DOUBLE -- Sequence number with which the generated script will be written to the T_CNTL_AGG_SQL_TEXT table. Affects the order of SQL statements in the final script. 				
Return		:	Error + Error Msg  / Complemented teplate with variables for debagging
Resutl		:	Row of the transformed and completed template in table T_CNTL_AGG_SQL_TEXT
Convert		:	None    
Description	: 	
Example		:	CALL sp_agg_insert('T_AGG_REGION_THEME_ALL','P_LEW_MART_PIT','template_T_AGG_insert', '33,34', 18, 1833);
------------------------------------------------------------------------
*/

        CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_agg_insert (
      pAggTableName      	STRING 
    , pATableSchema         STRING 
	, pASqlTemplateName		STRING
	, pReportingLineSIDs	STRING	
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
		var strSchema = "P_LEW_MART_PIT";
		var strTemplate = "agg_merge";
		var strOut = "";
        var strRltdAggTemplate = "";
				
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
		
///////////////////////////////////////////// MAIN TEMPLATE
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
	
        strMainTemplate = "";
        strMainTemplate = res.getColumnValue(1);

        strOut=strMainTemplate;
///////////////////////////////////////////// INSERT EXP

		sqlStmt = "";
		sqlStmt = `		
 select 
              LISTAGG(AGG_COLUMN_NAME,',') WITHIN GROUP (ORDER BY AGG_COLUMN_SORT_ORDER,AGG_COLUMN_NAME) AS LIST_AGG_A_COLUMN_NAME,
              REGEXP_REPLACE(LISTAGG(SEL_EXP,',') WITHIN GROUP (ORDER BY AGG_COLUMN_SORT_ORDER,AGG_COLUMN_NAME,SEL_EXP) 
                        , '/\\\\*\\\\[(LKP:('||LISTAGG (DISTINCT LKP_TABLE_NAME,'|')||')|RL:('||REPLACE('#PREPORTINGLINESIDS#',',','|')||')|L:(#PALEVELID#)|T_AGG_TABLE:('||MAX(AGG_TABLE_NAME)||'))\\\\](.*?)\\\\*\\\\/', '\\\\6 --debug: \\\\1') 
                                                                AS LIST_SEL_EXP,
              LISTAGG (DISTINCT LKP_TABLE_NAME,''',''') WITHIN GROUP (ORDER BY LKP_TABLE_NAME) AS LIST_LKP_TABLE_NAME,
			  MAX(A_TABLE_NAME) AS A_TABLE_NAME ,
              MAX(RLTD_FG) AS RLTD_FG 
              from (    
        select
        row_number () over (partition by rlc.A_COLUMN_NAME order by lkp.A_TABLE_NAME) rn_col ,
        IFF( rlc.FORMULA_NAME like '%DELTA%',10000,0) + IFF( rlc.FORMULA_NAME is not NULL,1000,0) + rlc.COLUMN_SORT_ORDER AGG_COLUMN_SORT_ORDER,
        --rl.A_REPORTING_LINE_SID AGG_REPORTING_LINE_SID,
        rlc.A_TABLE_SCHEMA AGG_TABLE_SCHEMA,
        rlc.A_TABLE_NAME AGG_TABLE_NAME,
        IFF (rn_col >1, '-- for debug: ','')||rlc.A_COLUMN_NAME||CHAR(13)||CHAR(9)||CHAR(9) AGG_COLUMN_NAME,
        l.A_LEVEL_ID,
        mt.A_TABLE_SCHEMA,
        mt.A_TABLE_NAME,
        mt.A_COLUMN_NAME,
        lkp.A_TABLE_SCHEMA LKP_TABLE_SCHEMA,
        lkp.A_TABLE_NAME LKP_TABLE_NAME,
        lkp.A_COLUMN_NAME LKP_COLUMN_NAME,
        null,        
        -- columns for select
        IFF( rlc.FORMULA_NAME is not NULL
            ,replace(replace(replace(replace(
              frm.FORMULA_SQL, '#SRC_COLUMN_NAME#',replace (replace (replace(rlc.A_COLUMN_NAME,'_DELTA_RLTD',''),'_RLTD',''),'_PCT','')),
                                '#COLUMN_NAME#',rlc.A_COLUMN_NAME),
								'#SRC_WO_MSTR_COLUMN_NAME#',replace(rlc.A_COLUMN_NAME,'_MSTR','')),
                                '#SRC_RLTD_COLUMN_NAME#' ,replace (replace (rlc.A_COLUMN_NAME,'_DELTA',''),'_PCT','')) 
            ,IFF(mt.A_TABLE_NAME is null and lkp.A_TABLE_NAME is null, 'NULL',
                IFF (rn_col >1, '-- for debug: ','')||  
                IFF (mt.A_TABLE_NAME is not null,'agg', lower(lkp.A_TABLE_NAME))||'.'
                  ||IFF (mt.A_TABLE_NAME is not null, mt.A_COLUMN_NAME, lkp.A_COLUMN_NAME)
                ) 
            )
              ||' as _'||rlc.A_COLUMN_NAME||CHAR(13)||CHAR(9)||CHAR(9) AS SEL_EXP,
        IFF(rlc.FORMULA_NAME is not NULL 
            and rlc.A_COLUMN_NAME like '%RLTD%' and rlc.A_COLUMN_NAME not like 'RLTD%' and rlc.A_COLUMN_NAME !='NEAREST_RLTD_ADV_WEEK_FG'
            ,1,0) as RLTD_FG
        
        from T_CNTL_DIM_A_COLUMNS rlc
        -- link to t_a table
       --- join T_CNTL_DIM_REPORTING_LINE2LEVEL_REL rl2l
        -- on rl2l.A_REPORTING_LINE_SID=rl.A_REPORTING_LINE_SID
        join T_CNTL_DIM_A_LEVEL l
        on  TRUE --l.A_LEVEL_ID = rl2l.A_LEVEL_ID
		 and l.A_LEVEL_ID=#PALEVELID#
        left join T_CNTL_DIM_A_COLUMNS mt
        on mt.A_TABLE_NAME= l.A_TABLE_NAME
        and mt.A_TABLE_SCHEMA=l.A_TABLE_SCHEMA
        and mt.A_COLUMN_NAME=rlc.A_COLUMN_NAME
        and mt.A_COLUMN_TYPE='ATT'
        and rlc.FORMULA_NAME is NULL
		and mt.DELETED_FG=0
        -- LKP
        left join T_CNTL_DIM_A_COLUMNS lkp
        on lkp.A_TABLE_NAME like 'LKP_%'
        and lkp.A_COLUMN_NAME=rlc.A_COLUMN_NAME
        and mt.A_COLUMN_NAME is null
        and lkp.A_COLUMN_TYPE='ATT'
        and rlc.FORMULA_NAME is NULL
		and lkp.DELETED_FG=0
        and lkp.A_TABLE_NAME not in (select distinct lkp.A_TABLE_NAME 
												from T_CNTL_DIM_A_COLUMNS lkp
												left join T_CNTL_DIM_A_COLUMNS mt
												on mt.A_COLUMN_NAME=lkp.A_COLUMN_NAME
												and mt.A_COLUMN_TYPE='ATT'
												and mt.DELETED_FG=0
												and (mt.A_TABLE_SCHEMA,mt.A_TABLE_NAME)
														in (select l.A_TABLE_SCHEMA, l.A_TABLE_NAME 
															from T_CNTL_DIM_A_LEVEL l
															where l.A_LEVEL_ID=#PALEVELID#)

										where lkp.DELETED_FG=0
										and lkp.A_TABLE_NAME like 'LKP%'
										and lkp.A_COLUMN_TYPE='KEY'
										and mt.A_COLUMN_NAME is null
										-- exception
										and lkp.A_TABLE_NAME||'.'||lkp.A_COLUMN_NAME!='LKP_NAN.DAT_VALID_FROM'
										and lkp.A_TABLE_NAME||'.'||lkp.A_COLUMN_NAME!='LKP_ITEM.DAY_DT'
										and lkp.A_TABLE_NAME||'.'||lkp.A_COLUMN_NAME!='LKP_RLTD_ADV_WEEK.RLTD_ADV_WEEK_ID'
										and (lkp.A_TABLE_NAME||'.'||lkp.A_COLUMN_NAME!='LKP_ADV_PERIOD.ADV_PERIOD_ID' OR ('#PREPORTINGLINESIDS#' not like '%13%' AND '#PREPORTINGLINESIDS#' not like '%14%' AND '#PREPORTINGLINESIDS#' not like '%15%' ))
									)
        -- Formula
        left join T_CNTL_DIM_CALC_FORMULA frm
        on frm.FORMULA_NAME=rlc.FORMULA_NAME
              
        where (rlc.A_TABLE_SCHEMA, rlc.A_TABLE_NAME) in (select rl.A_TABLE_SCHEMA, rl.A_TABLE_NAME from  T_CNTL_DIM_A_REPORTING_LINE rl where rl.A_REPORTING_LINE_SID in (#PREPORTINGLINESIDS#))
                -- WA Defined at table level
			    -- and rlc.A_COLUMN_NAME not like '%/_GID' escape '/'
			and rlc.A_COLUMN_TYPE='ATT'
			and rlc.DELETED_FG=0
        order by mt.A_TABLE_SCHEMA,  rlc.A_COLUMN_NAME
         ) 
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
		sqlStmt = sqlStmt.replace(/#PREPORTINGLINESIDS#/g,PREPORTINGLINESIDS);
		sqlStmt = sqlStmt.replace(/#PALEVELID#/g,PALEVELID);

		
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
	
        LIST_AGG_A_COLUMN_NAME = res.getColumnValue(1); 
        LIST_SEL_EXP = res.getColumnValue(2);
        LIST_LKP_TABLE_NAME = res.getColumnValue(3);
		A_TABLE_NAME = res.getColumnValue(4);
        RLTD_FG = res.getColumnValue(5);

///////////////////////////////////////////// LKP_JOINS TEMPLATE           

        sqlStmt = "";
		sqlStmt = `		
			SELECT
				  tmp.A_SQL_TEMPLATE
			FROM
			(
				SELECT 
					CHR(13) || A_SQL_TEMPLATE  AS A_SQL_TEMPLATE
				FROM #PSCHEMA#.T_CNTL_DIM_A_SQL_TEMPLATES 
				WHERE TRUE 
					AND DELETED_FG=0 
					AND LOWER(TRIM(A_SQL_TEMPLATE_NAME)) = 'lkp_joins'
				GROUP BY 1
			) tmp
			
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
		
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
	
        strLkpTemplate = "";
        strLkpTemplate = res.getColumnValue(1);

              
///////////////////////////////////////////// LKP_JOIN             
         
        sqlStmt = "";
		sqlStmt = `		
			  select KPI_SOURCE_TABLE_NAME AS LKP_TABLE_NAME
              , A_SCRIPT_FROM_CLAUSE_SQL AS A_SCRIPT_FROM_CLAUSE_SQL
              , LISTAGG(LKP_JOIN, ' AND ') WITHIN GROUP (ORDER BY LKP_JOIN)  AS LKP_JOIN_EXP
              from (     
                 select KPI_SOURCE_TABLE_NAME, 
                A_SCRIPT_FROM_CLAUSE_SQL, 
              CHAR(13)||CHAR(9)|| CHAR(9)||
                IFF (UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_NAN.DAT_VALID_FROM'
                     ,'lkp_item.DAT_VALID_FROM'
                  ,IFF(UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_ITEM.DAY_DT'
                   , 'lkp_adv_period.ADV_PERIOD_START_DT'
				      ,IFF(UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME) in ('LKP_RLTD_ADV_WEEK.RLTD_ADV_WEEK_ID','LKP_RLTD_ADV_PERIOD.RLTD_ADV_WEEK_ID')
                        , 'lkp_rltd.RLTD_ADV_WEEK_ID'
                            ,IFF( UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME) in ('LKP_RLTD_ADV_PERIOD.RLTD_ADV_PERIOD_START_DAY_ID','LKP_RLTD_ADV_PERIOD.RLTD_ADV_PERIOD_END_DAY_ID','LKP_RLTD_ADV_PERIOD.RLTD_ADV_PERIOD_LENGTH_IN_DAYS')
                                ,'lkp_adv_period.'||REPLACE(lkp.A_COLUMN_NAME,'RLTD_','')
              
                                ,IFF( UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_ADV_PERIOD.ADV_PERIOD_ID' AND ('#PREPORTINGLINESIDS#' like '%13%' OR '#PREPORTINGLINESIDS#' like '%14%' OR '#PREPORTINGLINESIDS#' like '%15%') 
                                    ,'((agg.ADV_WEEK_ID * 100::INTEGER) + 99::INTEGER)'
                                        ,IFF( UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_REPORTING_LINES.CLIENT_ID' and '#AGG_TABLE_NAME#'='P_LEW_FE_MSTR_PIT.T_AGG_REGION_THEME_ALL'
						                    , IFF ( 'LKP_THEME_GRP_NAT' in ('#LIST_LKP_TABLE_NAME#'),'LKP_THEME_GRP_NAT'
							                	,IFF ( 'LKP_THEME_GRP_NAT_CAT' in ('#LIST_LKP_TABLE_NAME#'),'LKP_THEME_GRP_NAT_CAT'
									        ,'LKP_THEME_GRP_INT'
								            )
								        )||'.REPORTING_LINE_SID=lkp_reporting_lines.REPORTING_LINE_SID AND agg.CLIENT_ID'
						                    ,'agg.'||COALESCE(mt.A_COLUMN_NAME,'')
                    )
                    )
					)
					)
                    )
                )
                ||'='||lower(KPI_SOURCE_TABLE_NAME)||'.'||lkp.A_COLUMN_NAME AS LKP_JOIN
             from  T_CNTL_DIM_KPI_SOURCE_TABLE src
              join  T_CNTL_DIM_A_COLUMNS lkp
              on  lkp.A_TABLE_NAME= src.KPI_SOURCE_TABLE_NAME
              and lkp.A_TABLE_SCHEMA=src.KPI_SOURCE_TABLE_SCHEMA
              and lkp.A_COLUMN_TYPE='KEY'
			  and lkp.DELETED_FG=0
              LEFT join T_CNTL_DIM_A_LEVEL l
                 on l.A_LEVEL_ID = #PALEVELID#
                LEFT JOIN  T_CNTL_DIM_A_COLUMNS mt
                ON lkp.A_COLUMN_NAME=mt.A_COLUMN_NAME
                AND l.A_TABLE_NAME= mt.A_TABLE_NAME
				AND mt.DELETED_FG=0
             where src.KPI_SOURCE_TABLE_NAME in ('#LIST_LKP_TABLE_NAME#')
             OR ( '#PREPORTINGLINESIDS#' like '%12%' 
                  AND 
                  src.KPI_SOURCE_TABLE_NAME ='LKP_RLTD_ADV_PERIOD'
                )
           )
           group by 1,2
           order by DECODE (LKP_TABLE_NAME,'LKP_ADV_PERIOD',0,'LKP_ITEM',1,'LKP_REPORTING_LINES',997,'LKP_RLTD',998,'LKP_RLTD_ADV_WEEK',999,'LKP_RLTD_ADV_PERIOD',1000, 100),LKP_TABLE_NAME
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
        sqlStmt = sqlStmt.replace(/#LIST_LKP_TABLE_NAME#/g,LIST_LKP_TABLE_NAME);
		sqlStmt = sqlStmt.replace(/#PALEVELID#/g,PALEVELID);
        sqlStmt = sqlStmt.replace(/#AGG_TABLE_NAME#/g,''.concat('P_LEW_FE_MSTR_PIT.',PAGGTABLENAME));
        sqlStmt = sqlStmt.replace(/#PREPORTINGLINESIDS#/g,PREPORTINGLINESIDS);
		
        // Retrieve next Template
        try{
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            msg = "StartComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			
        }

        while ( res.next())  {
              strOut=strOut.replace(/#LKP_JOINS#/g,strLkpTemplate);
              
              LKP_TABLE_NAME = res.getColumnValue(1);
              A_SCRIPT_FROM_CLAUSE_SQL = res.getColumnValue(2);
              // WA TEST REJECT
              // A_SCRIPT_FROM_CLAUSE_SQL = A_SCRIPT_FROM_CLAUSE_SQL.replace(/\${CLIENT_ID}/g,"0"); 
              LKP_JOIN_EXP = res.getColumnValue(3); 
              
              strOut=strOut.replace(/#LKP_TABLE_NAME#/g,LKP_TABLE_NAME);
              strOut=strOut.replace(/#A_SCRIPT_FROM_CLAUSE_SQL#/g,A_SCRIPT_FROM_CLAUSE_SQL);
              strOut=strOut.replace(/#LKP_JOIN_EXP#/g,LKP_JOIN_EXP);          
     
       }

/////////////////////////////////////////// RLTD_FG
if (RLTD_FG === 1) { 

      sqlStmt = "";
		sqlStmt = `		
			SELECT
				  tmp.A_SQL_TEMPLATE
			FROM
			(
				SELECT 
					CHR(13) || A_SQL_TEMPLATE  AS A_SQL_TEMPLATE
				FROM #PSCHEMA#.T_CNTL_DIM_A_SQL_TEMPLATES 
				WHERE TRUE 
					AND DELETED_FG=0 
					AND LOWER(TRIM(A_SQL_TEMPLATE_NAME)) = 'rltd_agg'
				GROUP BY 1
			) tmp
			
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
		
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
	

        strRltdAggTemplate = res.getColumnValue(1);

              
        	sqlStmt = "";
		sqlStmt = `	select CHAR(9)||CHAR(9)||'AND '||LISTAGG ( 
                        DECODE(A_COLUMN_NAME ,'ADV_WEEK_ID', 'LKP_RLTD.RLTD_ADV_WEEK_ID'
                                              ,'ADV_PERIOD_ID','LKP_RLTD_ADV_PERIOD.RLTD_ADV_PERIOD_ID'
                            ,' agg.'||A_COLUMN_NAME)
                        ||'='||'rltd_agg.'||A_COLUMN_NAME||CHAR(13)||CHAR(9)||CHAR(9), ' AND ')  WITHIN GROUP (ORDER BY A_COLUMN_NAME)  AS RLTD_JOIN_EXP
                from (
                SELECT distinct FG_NAME,FG_VALUES FROM T_CNTL_DIM_A_LEVEL
				UNPIVOT(FG_VALUES FOR FG_NAME IN (A_ADV_WEEK_FG,A_ADV_PERIOD_FG,A_ITEM_FG,A_ITEM_NAN_FG,A_ITEM_WGI_FG,A_ITEM_UWG_FG,A_COUNTRY_FG,A_WAREHOUSE_FG,A_THEME_GRP_INT_FG,A_THEME_GRP_NAT_FG,A_MEDIUM_FG,A_MEDIUM_GRP_FG,A_ACTION_TYPE_FG))
				where A_LEVEL_ID in (#PALEVELID#)
				and DELETED_FG=0
				and FG_VALUES in (0,1)
)as ag_fg
			  join 
			  T_CNTL_DIM_A_FLAGS fg
			  ON TRUE
			  AND fg.DELETED_FG=0
			  AND fg.A_FG_NAME=ag_fg.FG_NAME
              and fg.A_TYPE='MAIN'
		`;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
		sqlStmt = sqlStmt.replace(/#PREPORTINGLINESIDS#/g,PREPORTINGLINESIDS);
		sqlStmt = sqlStmt.replace(/#PALEVELID#/g,PALEVELID);

		
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
	
        RLTD_JOIN_EXP = res.getColumnValue(1); 
        
              
        strRltdAggTemplate = strRltdAggTemplate.replace(/#RLTD_JOIN_EXP#/g,RLTD_JOIN_EXP);
        // WA TEST REJECT
       // strRltdAggTemplate = strRltdAggTemplate.replace(/\${CLIENT_ID}/g,"0"); 

}
              
///////////////////////////////////////////// A_TABLE_NAME_KEYS       

        sqlStmt = "";
		sqlStmt = `		
			SELECT  LISTAGG(FG_NAME,', ') WITHIN GROUP (ORDER BY FG_NAME) as A_TABLE_NAME_KEYS
                FROM T_CNTL_DIM_A_LEVEL
				UNPIVOT(FG_VALUES FOR FG_NAME IN (A_ADV_WEEK_FG,A_ADV_PERIOD_FG,A_ITEM_FG,A_ITEM_NAN_FG,A_ITEM_WGI_FG,A_ITEM_UWG_FG,A_COUNTRY_FG,A_WAREHOUSE_FG,A_THEME_GRP_INT_FG,A_THEME_GRP_NAT_FG,A_MEDIUM_FG,A_MEDIUM_GRP_FG,A_ACTION_TYPE_FG))
				where true 
				and A_LEVEL_ID IN (#PALEVELID#)
				and DELETED_FG=0
				and FG_VALUES in (1)
	    `;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
        sqlStmt = sqlStmt.replace(/#PALEVELID#/g,PALEVELID);
		
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
	

        A_TABLE_NAME_KEYS = res.getColumnValue(1);
              
///////////////////////////////////////////// REPORTING_LINE_DESCRS       

        sqlStmt = "";
		sqlStmt = `		
			SELECT    LISTAGG(REPORTING_LINE_DESCR,',') WITHIN GROUP (ORDER BY REPORTING_LINE_DESCR)  AS REPORTING_LINE_DESCRS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
		FROM P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_REPORTING_LINES 
        where REPORTING_LINE_SID in (#PREPORTINGLINESIDS#)
	    `;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
        sqlStmt = sqlStmt.replace(/#PREPORTINGLINESIDS#/g,PREPORTINGLINESIDS);
		
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
	

        REPORTING_LINE_DESCRS = res.getColumnValue(1);
              
              
                            
///////////////////////////////////////////// CHK_LKP       

        sqlStmt = "";
		sqlStmt = `		
		select LISTAGG(DISTINCT CHK_LKP, ' OR ') WITHIN GROUP (ORDER BY CHK_LKP)  AS CHK_LKP_EXP,
				LISTAGG(CHK_LKP_LDESCR, '||')   WITHIN GROUP (ORDER BY CHK_LKP)   AS CHK_LKP_LDESCR_EXP
       
              from (
                 select KPI_SOURCE_TABLE_NAME, 
                max (KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME) ||' IS NULL ' ||CHAR(13)||CHAR(9)||CHAR(9)||CHAR(9) CHK_LKP,
                 CHAR(13)||CHAR(9)||CHAR(9)||'IFF ('||CHK_LKP||','''||KPI_SOURCE_TABLE_NAME||': '
               ||LISTAGG (KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME|| IFF (lkp.A_COLUMN_NAME like '%ID', '=''||COALESCE(to_char(', '=''''''||COALESCE(to_char(')||
						--lkp.A_COLUMN_NAME
					IFF (UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_NAN.DAT_VALID_FROM'
                     ,'lkp_item.DAT_VALID_FROM'
                  ,IFF(UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_ITEM.DAY_DT'
                   , 'lkp_adv_period.ADV_PERIOD_START_DT'
				      ,IFF(UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_RLTD_ADV_WEEK.RLTD_ADV_WEEK_ID'
                        , 'lkp_rltd.RLTD_ADV_WEEK_ID'
                        ,IFF( UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_ADV_PERIOD.ADV_PERIOD_ID' AND ('#PREPORTINGLINESIDS#' like '%13%' OR '#PREPORTINGLINESIDS#' like '%14%' OR '#PREPORTINGLINESIDS#' like '%15%') 
                            ,'((agg.ADV_WEEK_ID * 100::INTEGER) + 99::INTEGER)'
				   ,IFF( UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_REPORTING_LINES.CLIENT_ID' and '#AGG_TABLE_NAME#'='P_LEW_FE_MSTR_PIT.T_AGG_REGION_THEME_ALL'
						, IFF ( 'LKP_THEME_GRP_NAT' in ('#LIST_LKP_TABLE_NAME#'),'LKP_THEME_GRP_NAT'
								,IFF ( 'LKP_THEME_GRP_NAT_CAT' in ('#LIST_LKP_TABLE_NAME#'),'LKP_THEME_GRP_NAT_CAT'
									,'LKP_THEME_GRP_INT'
								)
								)||'.REPORTING_LINE_SID=lkp_reporting_lines.REPORTING_LINE_SID AND agg.CLIENT_ID'
						,'agg.'||COALESCE(mt.A_COLUMN_NAME,'')
                    )
					)
					)
                    )
                )
						
						||'),''NULL in '||
                        
                        		--lkp.A_COLUMN_NAME
					IFF (UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_NAN.DAT_VALID_FROM'
                     ,'lkp_item.DAT_VALID_FROM'
                  ,IFF(UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_ITEM.DAY_DT'
                   , 'lkp_adv_period.ADV_PERIOD_START_DT'
				      ,IFF(UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_RLTD_ADV_WEEK.RLTD_ADV_WEEK_ID'
                        , 'lkp_rltd.RLTD_ADV_WEEK_ID'
                        ,IFF( UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_ADV_PERIOD.ADV_PERIOD_ID' AND ('#PREPORTINGLINESIDS#' like '%13%' OR '#PREPORTINGLINESIDS#' like '%14%' OR '#PREPORTINGLINESIDS#' like '%15%') 
                            ,'((agg.ADV_WEEK_ID * 100::INTEGER) + 99::INTEGER)'
				   ,IFF( UPPER(KPI_SOURCE_TABLE_NAME||'.'||lkp.A_COLUMN_NAME)='LKP_REPORTING_LINES.CLIENT_ID' and '#AGG_TABLE_NAME#'='P_LEW_FE_MSTR_PIT.T_AGG_REGION_THEME_ALL'
						, IFF ( 'LKP_THEME_GRP_NAT' in ('#LIST_LKP_TABLE_NAME#'),'LKP_THEME_GRP_NAT'
								,IFF ( 'LKP_THEME_GRP_NAT_CAT' in ('#LIST_LKP_TABLE_NAME#'),'LKP_THEME_GRP_NAT_CAT'
									,'LKP_THEME_GRP_INT'
								)
								)||'.REPORTING_LINE_SID=lkp_reporting_lines.REPORTING_LINE_SID AND agg.CLIENT_ID'
						,'agg.'||COALESCE(mt.A_COLUMN_NAME,'')
                    )
					)
					)
                    )
                )
                        
                        ||' '')'||IFF (lkp.A_COLUMN_NAME like '%ID', '||''','||'''''''),' AND ') WITHIN GROUP (ORDER BY mt.COLUMN_SORT_ORDER, lkp.A_COLUMN_NAME) 

               ||'''||CHAR(13)'
               ||CHAR(13)||CHAR(9)||CHAR(9)||CHAR(9)||','''')' as  CHK_LKP_LDESCR
			   from  T_CNTL_DIM_KPI_SOURCE_TABLE src
              join  T_CNTL_DIM_A_COLUMNS lkp
              on  lkp.A_TABLE_NAME= src.KPI_SOURCE_TABLE_NAME
              and lkp.A_TABLE_SCHEMA=src.KPI_SOURCE_TABLE_SCHEMA
              and lkp.A_COLUMN_TYPE='KEY'
			  and lkp.DELETED_FG=0
              LEFT join T_CNTL_DIM_A_LEVEL l
                 on l.A_LEVEL_ID = #PALEVELID#
                LEFT JOIN  T_CNTL_DIM_A_COLUMNS mt
                ON lkp.A_COLUMN_NAME=mt.A_COLUMN_NAME
                AND l.A_TABLE_NAME= mt.A_TABLE_NAME
				AND mt.DELETED_FG=0
             where src.KPI_SOURCE_TABLE_NAME in ('#LIST_LKP_TABLE_NAME#') 
			 GROUP BY 1
          )
          
	    `;
		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
        sqlStmt = sqlStmt.replace(/#LIST_LKP_TABLE_NAME#/g,LIST_LKP_TABLE_NAME);
		sqlStmt = sqlStmt.replace(/#PALEVELID#/g,PALEVELID);
        sqlStmt = sqlStmt.replace(/#AGG_TABLE_NAME#/g,''.concat('P_LEW_FE_MSTR_PIT.',PAGGTABLENAME));
        sqlStmt = sqlStmt.replace(/#PREPORTINGLINESIDS#/g,PREPORTINGLINESIDS);
		
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
	

        CHK_LKP_EXP = res.getColumnValue(1);
        CHK_LKP_LDESCR_EXP =   res.getColumnValue(2);    
////////////////////////////////////////////////
////////////////////////////////////////////////


/////////////////////////////////////////////////
              strOut = strOut.replace(/-- #RLTD_AGG#/g,strRltdAggTemplate); 
              strOut = strOut.replace(/#LIST_AGG_A_COLUMN_NAME#/g,LIST_AGG_A_COLUMN_NAME);
              strOut = strOut.replace(/#LIST_SEL_EXP#/g,LIST_SEL_EXP);
              strOut = strOut.replace(/-- #LKP_JOINS#/g,'');
			  strOut = strOut.replace(/#A_TABLE_NAME#/g,A_TABLE_NAME);
			  strOut = strOut.replace(/#AGG_TABLE_NAME#/g,''.concat('P_LEW_FE_MSTR_PIT.',PAGGTABLENAME));
              strOut = strOut.replace(/#PREPORTINGLINESIDS#/g,PREPORTINGLINESIDS);
              strOut = strOut.replace(/,-- for debug/g,'-- for debug');
              strOut = strOut.replace(/#PALEVELID#/g,PALEVELID);
              strOut = strOut.replace(/#LIST_LKP_TABLE_NAME#/g,LIST_LKP_TABLE_NAME);
              strOut = strOut.replace(/#PREPORTINGLINEDESCRS#/g,REPORTING_LINE_DESCRS);
              strOut = strOut.replace(/#A_TABLE_NAME_KEYS#/g,A_TABLE_NAME_KEYS);
              strOut = strOut.replace(/#CHK_LKP_EXP#/g,CHK_LKP_EXP);
			  strOut = strOut.replace(/#CHK_LKP_LDESCR_EXP#/g,CHK_LKP_LDESCR_EXP);
              
              

  //////////////////////////            
 /////////// WA ////////////
 ///////////////////////////
  // 		strOut = strOut.replace(/\${CLIENT_ID}/g,"0"); 
 //////////////////////////            
 /////////// WA ////////////
 ///////////////////////////

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
					, '#pAggTableName#'							
					, '#PSCHEMA#'							    
					, #SORTORDER#					
					, CURRENT_TIMESTAMP 						
				)
		`;
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#pAggTableName#/g,PAGGTABLENAME.toUpperCase());
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
		sqlStmt = sqlStmt.replace(/#SORTORDER#/g,dSortOrder);				

		
		strOut = strOut.replace(/'/g,"''");	
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
              
              
              

///////////////////////////////////////////////////////              
		///// WA
		strOut = strOut.replace(/\${CLIENT_ID}/g,"0"); 

              
		return strOut;
$$
;