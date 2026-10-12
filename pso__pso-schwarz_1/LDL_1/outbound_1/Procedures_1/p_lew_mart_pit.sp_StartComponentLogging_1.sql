/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_StartComponentLogging
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
USE SCHEMA 		P_LEW_MART_PIT_1;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;
*/

/* 
---------------------------------------------------------------------
PROCEDURE	:	sp_StartComponentLogging(pApplicationName STRING, pModuleName STRING, pComponentName STRING, pRunClusteringDesc STRING, pQueryTag STRING)
Input		:   
				pLoadID				STRING --> ETL Load ID YYYYMMDDHHMMSSNNN * 100 + CLIENT_ID [All 99]
				pApplicationName 	STRING 
				pModuleName         STRING
				pComponentName      STRING
				pRunClusteringDesc 	STRING --> [0] running in sequence 
				pQueryTag           STRING
				pPITLogging			FLOAT  --> 0 - no logging, 1 - Start/End-Logging, 2 - Start/End-ModuleLogging, 3 - Start/End-ComponentLogging
				
Return		:	Error + Error Msg
Convert		:	None    
Description	: 	Initialize Logging 
Example		:	Call sp_StartComponentLogging('PITonCloud','Performance', '[0]', 'Start Logging');
				CALL sp_StartComponentLogging(${LOAD_ID},'PITonCloud','Performance', '[0]',f_QueryTag('ETL Logging','PITonCloud',NULL),'${SCHEMA}');
------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_startcomponentlogging (IN pLoadID STRING, IN pApplicationName STRING, IN pModuleName STRING, IN pComponentName STRING, IN pRunClusteringDesc STRING, IN pQueryTag STRING, IN pSchema STRING, IN pPITLogging FLOAT64, OUT out_param STRING)
BEGIN
    DECLARE strruncluster STRING DEFAULT '[0]';
    DECLARE SQLCODE BIGNUMERIC DEFAULT 0;
    DECLARE SQLSTATE STRING DEFAULT '00000';
    DECLARE msg STRING DEFAULT '';
    DECLARE sqlstmt STRING DEFAULT '';
    DECLARE sqlbegintransaction STRING DEFAULT 'BEGIN TRANSACTION;';
    DECLARE sqlcommit STRING DEFAULT 'COMMIT;';
    DECLARE strschema STRING DEFAULT 'p_lew_mart_pit_1';
    DECLARE strloadid STRING DEFAULT '-2';
    DECLARE intlogginglevel FLOAT64 DEFAULT 3;
    
    DECLARE run_ts STRING;
    DECLARE run_day_id STRING;
    DECLARE run_id_seq STRING;
    DECLARE res ARRAY<JSON>;

    -- CHECK INPUT pPITLogging 
    IF PPITLOGGING IS NULL THEN
        BEGIN
            SET PPITLOGGING = intlogginglevel;
        END;
    ELSE
        BEGIN
            SET intlogginglevel = PPITLOGGING;
        END;
    END IF;

    --v2.0
    IF intlogginglevel >= 3 THEN
        BEGIN
            -- CHECK INPUT pParamValueChar 
            IF PLOADID = '' OR PLOADID IS NULL THEN
                BEGIN
                    SET PLOADID = strloadid;
                END;
            ELSE
                BEGIN
                    SET strloadid = UPPER(PLOADID);
                END;
            END IF;

            -- CHECK INPUT runcluster 
            IF PRUNCLUSTERINGDESC = '' OR PRUNCLUSTERINGDESC IS NULL THEN
                BEGIN
                    SET PRUNCLUSTERINGDESC = strruncluster;
                END;
            ELSE
                BEGIN
                    SET strruncluster = UPPER(PRUNCLUSTERINGDESC);
                END;
            END IF;

            SET strruncluster = REGEXP_REPLACE(strruncluster, r'\[(.*)\]', r'\1');

            -- CHECK INPUT pSchema 
            IF PSCHEMA = '' OR PSCHEMA IS NULL THEN
                BEGIN
                    SET PSCHEMA = strschema;
                END;
            ELSE
                BEGIN
                    SET strschema = LOWER(PSCHEMA);
                END;
            END IF;

            SET sqlstmt = '';
            SET sqlstmt = '''		
                SELECT
                      FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%E3S', rs.run_ts) AS run_ts
                    , FORMAT_DATE('%Y-%m-%d', rs.run_day_id) AS run_day_id
                    , CAST(rs.run_id_seq AS STRING) AS run_id_seq
                FROM 
                p_lew_mart_pit.t_cntl_etl_logging_run_seq_1 rs_1
                INNER JOIN
                (
                    SELECT 
                        COALESCE(MAX(run_id_seq),0) AS run_id_seq 
                    FROM p_lew_mart_pit.t_cntl_etl_logging_run_seq_1
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
            SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', strschema);
            SET sqlstmt = REPLACE(sqlstmt, '#PLOADID#', strloadid);		

            -- Retrieve next Seq RunID
            BEGIN
                EXECUTE IMMEDIATE sqlbegintransaction;
                EXECUTE IMMEDIATE CONCAT('SELECT ARRAY_AGG(JSON_ARRAY(run_ts, run_day_id, run_id_seq)) FROM (', sqlstmt, ')') INTO res;
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('StartComponentLogging: [', sqlstmt, '] FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;
            END;

            SET run_ts = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[0]');
            SET run_day_id = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[1]');
            SET run_id_seq = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[2]');

            SET sqlstmt = '';
            SET sqlstmt = '''		
                INSERT INTO p_lew_mart_pit.t_cntl_etl_logging_1
                    (
                          run_id_seq
                        , run_ts
                        , run_day_id					  
                        , run_clustering_desc
                        , application_name
                        , module_name
                        , component_name
                        , query_tag
                        , component_level_fg
                        , load_id	
                        , multi_client_run_lst
                        , dwh_created_ts
                        , client_id
                        , component_start_fg	
                        , start_run_ts						
                    ) 
                SELECT
                          #RUNIDSEQ#
                        , CAST(SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%E3S', '#RUNTS#') AS DATETIME)
                        , SAFE.PARSE_DATE('%Y-%m-%d', '#RUNDAYID#')		  
                        , CONCAT('[', '#RUNCLUSTER#', ']') AS run_clustering_desc
                        , '#PAPPLICATIONNAME#'
                        , '#PMODULENAME#'
                        , '#PCOMPONENTNAME#'
                        , '#PQUERYTAG#'
                        , 1
                        , COALESCE(SAFE_CAST('#PLOADID#' AS INT64), -2)
                        , SPLIT('#RUNCLUSTER#', ',') AS multi_client_run_lst
                        , CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_ts
                        , CASE 
                            WHEN ARRAY_LENGTH(SPLIT('#RUNCLUSTER#', ',')) = 1 AND '#RUNCLUSTER#' != '0' 
                            THEN COALESCE(SAFE_CAST('#RUNCLUSTER#' AS INT64), -2)
                            ELSE -2
                          END AS client_id	
                        , 1 AS component_start_fg
                        , CAST(CURRENT_TIMESTAMP() AS DATETIME) AS start_run_ts							
            ''';

            -- Variable Substitution
            SET sqlstmt = REPLACE(sqlstmt, '#RUNIDSEQ#', run_id_seq);
            SET sqlstmt = REPLACE(sqlstmt, '#RUNTS#', run_ts);
            SET sqlstmt = REPLACE(sqlstmt, '#RUNDAYID#', run_day_id);
            SET sqlstmt = REPLACE(sqlstmt, '#PAPPLICATIONNAME#', UPPER(PAPPLICATIONNAME));
            SET sqlstmt = REPLACE(sqlstmt, '#RUNCLUSTER#', UPPER(strruncluster));
            SET sqlstmt = REPLACE(sqlstmt, '#PMODULENAME#', UPPER(PMODULENAME));
            SET sqlstmt = REPLACE(sqlstmt, '#PCOMPONENTNAME#', UPPER(PCOMPONENTNAME));		
            SET sqlstmt = REPLACE(sqlstmt, '#PQUERYTAG#', UPPER(PQUERYTAG));
            SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', strschema);	
            SET sqlstmt = REPLACE(sqlstmt, '#PLOADID#', strloadid);		

            BEGIN
                EXECUTE IMMEDIATE sqlstmt;
                EXECUTE IMMEDIATE sqlcommit;
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('StartComponentLogging: [', sqlstmt, ']  FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;
            END;

            SET OUT_PARAM = run_ts;
        END;
    END IF;
END;


-- End of sp_StartComponentLogging (including f_QueryTag param)
