/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_StartModuleLogging
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  2.0  2023-06-02 Nikolai Toknov  add parameter pPITLogging
#  2.1	2023-08-14 Andreas Kurz	   changed update to insert
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_QS;
USE SCHEMA 		P_LEW_MART_PIT_2;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;
*/

/* ---------------------------------------------------------------------
PROCEDURE	:	sp_StartModuleLogging(pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pQueryTag STRING)
Input		:  
				pLoadID				STRING --> ETL Load ID YYYYMMDDHHMMSSNNN * 100 + CLIENT_ID [All 99]
				pApplicationName 	STRING 
				pModuleName         STRING
				pRunClusteringDesc 	STRING --> [0] running in sequence 
				pQueryTag           STRING
				pPITLogging			FLOAT  --> 0 - no logging, 1 - Start/End-Logging, 2 - Start/End-ModuleLogging, 3 - Start/End-ComponentLogging
				
Return		:	Error + Error Msg
Convert		:	None    
Description	: 	Initialize Logging 
Example		:	Call sp_StartModuleLogging(${LOAD_ID},'PITonCloud','Performance', '[0]', 'Start Logging');
				CALL sp_StartModuleLogging(${LOAD_ID},'PITonCloud','Performance', '[0]',f_QueryTag('ETL Logging','PITonCloud',NULL));
				CALL sp_StartModuleLogging(${LOAD_ID},'PITonCloud','T_AGG_REGION_MEDIUM_ALL_2', '[${CLIENT_ID}]',f_QueryTag('T_AGG_REGION_MEDIUM_ALL_2','PITonCloud','[${CLIENT_ID}]'),'${SCHEMA}');
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_startmodulelogging (
      IN PLOADID                STRING      
	, IN PAPPLICATIONNAME       STRING 
    , IN PMODULENAME            STRING       
    , IN PRUNCLUSTERINGDESC     STRING    
    , IN PQUERYTAG              STRING
	, IN PSCHEMA                STRING
	, IN PPITLOGGING            FLOAT64	
    , OUT OUT_PARAM             STRING
)
BEGIN
    DECLARE strruncluster STRING DEFAULT '[0]';
    DECLARE msg STRING DEFAULT '';
    DECLARE sqlstmt STRING DEFAULT '';
    DECLARE sqlbegintransaction STRING DEFAULT 'BEGIN TRANSACTION;';
    DECLARE sqlcommit STRING DEFAULT 'COMMIT;';
    DECLARE strschema STRING DEFAULT 'p_lew_mart_pit_2';
    DECLARE strloadid STRING DEFAULT '-2';
    DECLARE intlogginglevel FLOAT64 DEFAULT 3;
    DECLARE res ARRAY<JSON>;
    DECLARE var_run_ts STRING;
    DECLARE var_run_day_id STRING;
    DECLARE var_run_id_seq STRING;

    -- CHECK INPUT pPITLogging 
    IF PPITLOGGING IS NULL THEN
        SET PPITLOGGING = intlogginglevel;
    ELSE
        SET intlogginglevel = PPITLOGGING;
    END IF;
        
    -- v2.0
    IF intlogginglevel >= 2 THEN
    
        -- CHECK INPUT pParamValueChar 
        IF PLOADID = '' OR PLOADID IS NULL THEN
            SET PLOADID = strloadid;
        ELSE
            SET strloadid = UPPER(PLOADID);
        END IF;

        -- CHECK INPUT runcluster 
        IF PRUNCLUSTERINGDESC = '' OR PRUNCLUSTERINGDESC IS NULL THEN
            SET PRUNCLUSTERINGDESC = strruncluster;
        ELSE
            SET strruncluster = UPPER(PRUNCLUSTERINGDESC);
        END IF;
        
        SET strruncluster = REGEXP_REPLACE(strruncluster, r'\[(.*)\]', r'\1');
    
        -- CHECK INPUT pSchema 
        IF PSCHEMA = '' OR PSCHEMA IS NULL THEN
            SET PSCHEMA = strschema;
        ELSE
            SET strschema = UPPER(PSCHEMA);
        END IF;
        
        SET sqlstmt = '';
        SET sqlstmt = '''	
                SELECT
                      FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%E3S', rs.run_ts) 	AS run_ts
                    , FORMAT_DATE('%Y-%m-%d', rs.run_day_id) 				AS run_day_id
                    , CAST(rs.run_id_seq AS STRING)                         AS run_id_seq
                FROM 
                    `#PSCHEMA#.t_cntl_etl_logging_run_seq_2` rs_2
                INNER JOIN
                (
                    SELECT 
                        COALESCE(MAX(run_id_seq),0) AS run_id_seq 
                    FROM `#PSCHEMA#.t_cntl_etl_logging_run_seq_2`
                    WHERE TRUE	
                        AND run_clustering_desc 	= CONCAT('[', '#RUNCLUSTER#', ']') 
                        AND application_name 		= '#PAPPLICATIONNAME#'
                ) rsm
                ON TRUE
                    AND rs.run_id_seq = rsm.run_id_seq
        ''';
        
        -- Variable Substitution
        SET sqlstmt = REPLACE(sqlstmt, '#PAPPLICATIONNAME#', UPPER(PAPPLICATIONNAME));
        SET sqlstmt = REPLACE(sqlstmt, '#RUNCLUSTER#', UPPER(strruncluster));
        SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', LOWER(strschema));
        SET sqlstmt = REPLACE(sqlstmt, '#PLOADID#', strloadid);
        
        -- Retrieve next Seq RunID
        BEGIN
            EXECUTE IMMEDIATE sqlbegintransaction;
            EXECUTE IMMEDIATE format("""
                SELECT ARRAY_AGG(JSON_OBJECT('run_ts', run_ts, 'run_day_id', run_day_id, 'run_id_seq', run_id_seq))
                FROM (%s)
            """, sqlstmt) INTO res;
        EXECUTE IMMEDIATE sqlcommit;
        EXCEPTION WHEN ERROR THEN
            SET msg = CONCAT('StartModuleLogging: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
                
            RAISE USING MESSAGE = msg;
        END;

        -- res.getColumnValue(1) = RUN_ID_SEQ
        SET var_run_ts = JSON_VALUE(res[SAFE_OFFSET(0)], '$.run_ts');
        SET var_run_day_id = JSON_VALUE(res[SAFE_OFFSET(0)], '$.run_day_id');
        SET var_run_id_seq = JSON_VALUE(res[SAFE_OFFSET(0)], '$.run_id_seq');
        
        SET sqlstmt = '';
        SET sqlstmt = '''		
            INSERT INTO `#PSCHEMA#.t_cntl_etl_logging_2` 
                (
                      run_id_seq
                    , run_ts
                    , run_day_id
                    , run_clustering_desc
                    , application_name
                    , module_name
                    , component_name
                    , query_tag
                    , module_level_fg
                    , load_id
                    , multi_client_run_lst
                    , dwh_created_ts
                    , client_id	
                    , module_start_fg	
                    , start_run_ts
                ) 
            SELECT
                      #RUNIDSEQ#                                                        AS run_id_seq
                    , SAFE_CAST('#RUNTS#' AS DATETIME)                                 AS run_ts
                    , SAFE_CAST('#RUNDAYID#' AS DATE)                                   AS run_day_id
                    , CONCAT('[', '#RUNCLUSTER#', ']') 									AS run_clustering_desc
                    , '#PAPPLICATIONNAME#'                                              AS application_name
                    , '#PMODULENAME#'                                                   AS module_name
                    , '#PMODULENAME#'                                                   AS component_name
                    , '#PQUERYTAG#'                                                     AS query_tag
                    , 1                                                                 AS module_level_fg
                    , COALESCE(SAFE_CAST('#PLOADID#' AS INT64), -2)                     AS load_id
                    
                    , SPLIT('#RUNCLUSTER#', ',')								        AS multi_client_run_lst
                    , CURRENT_DATE("Europe/Berlin")TIME() 												AS dwh_created_ts
                    , IF(
                        '0' NOT IN UNNEST(SPLIT('#RUNCLUSTER#', ',')) AND ARRAY_LENGTH(SPLIT('#RUNCLUSTER#', ',')) = 1
                        , COALESCE(SAFE_CAST('#RUNCLUSTER#' AS INT64), -2)
                        , -2
                        )																AS client_id
                    , 1														            AS module_start_fg
                    , CURRENT_DATE("Europe/Berlin")TIME()												AS start_run_ts
        ''';
                
        -- Variable Substitution
        SET sqlstmt = REPLACE(sqlstmt, '#RUNIDSEQ#', COALESCE(var_run_id_seq, '0'));
        SET sqlstmt = REPLACE(sqlstmt, '#RUNTS#', COALESCE(var_run_ts, '1970-01-01 00:00:00.000'));
        SET sqlstmt = REPLACE(sqlstmt, '#RUNDAYID#', COALESCE(var_run_day_id, '1970-01-01'));		
        
        SET sqlstmt = REPLACE(sqlstmt, '#PAPPLICATIONNAME#', UPPER(PAPPLICATIONNAME));
        SET sqlstmt = REPLACE(sqlstmt, '#RUNCLUSTER#', UPPER(strruncluster));
        SET sqlstmt = REPLACE(sqlstmt, '#PMODULENAME#', UPPER(PMODULENAME));
        SET sqlstmt = REPLACE(sqlstmt, '#PQUERYTAG#', UPPER(PQUERYTAG));
        SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', LOWER(strschema));		
        SET sqlstmt = REPLACE(sqlstmt, '#PLOADID#', strloadid);
        
        BEGIN
            EXECUTE IMMEDIATE sqlbegintransaction;
            EXECUTE IMMEDIATE sqlstmt;
            EXECUTE IMMEDIATE sqlcommit;			
        EXCEPTION WHEN ERROR THEN
            SET msg = CONCAT('StartModuleLogging: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
                
            RAISE USING MESSAGE = msg;
        END;
        
        SET OUT_PARAM = var_run_id_seq;		
    END IF;		
END;
--CALL p_lew_mart_pit.sp_startmodulelogging('202209180002447612','PITonCloud','T_DIM_ITEM_HIER_2', '[12]',p_lew_mart_pit.f_querytag('T_DIM_ITEM_HIER_2','PITonCloud','[12]'),'p_lew_mart_pit_2',NULL, OUT_PARAM)
--SELECT * FROM t_cntl_etl_logging_run_seq_2
-- Check QH: SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));
--CALL p_lew_mart_pit.sp_startlogging('-1','PITonCloud','[0]',p_lew_mart_pit.f_querytag('Initialize Logging','PITonCloud','[0]'),'p_lew_mart_pit_2',NULL, OUT_PARAM);
--CALL p_lew_mart_pit.sp_startmodulelogging('-1','PITonCloud','Cube Refresh', '[0]',p_lew_mart_pit.f_querytag('Cube Refresh','PITonCloud','[0]'),'p_lew_mart_pit_2',NULL, OUT_PARAM);