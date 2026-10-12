/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_EndComponentLogging
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
--USE DATABASE 	LDL_CLONE_PIT;
--USE DATABASE 	LDL_CLONE_PIT_R51501;
USE DATABASE 	LDL_CLONE_PIT_QS;
USE SCHEMA 		P_LEW_MART_PIT;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;
*/

/* ---------------------------------------------------------------------
PROCEDURE	:	sp_EndComponentLogging(pApplicationName STRING, pModuleName STRING, pComponentName STRING, pRunClusteringDesc STRING, pSchema STRING, pRecordProcessedNr	STRING)
Input		:   pApplicationName 	STRING 
				pModuleName         STRING
				pComponentName      STRING
				pRunClusteringDesc 	STRING --> [0] running in sequence 
				pSchema				STRING
				pRecordProcessedNr	STRING --> number of recoreds written
				pPITLogging			FLOAT  --> 0 - no logging, 1 - Start/End-Logging, 2 - Start/End-ModuleLogging, 3 - Start/End-ComponentLogging
				
Return		:	Error + Error Msg
Convert		:	None    
Description	: 	Initialize Logging 
Example		:	Call sp_EndComponentLogging('PITonCloud','Performance', 'Comp1', '[0]', to_char(&__rowcount));
				CALL sp_EndComponentLogging('PITonCloud','Performance', 'Comp1', '[0]',to_char(100));
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_endcomponentlogging (
    IN PAPPLICATIONNAME STRING, 
    IN PMODULENAME STRING, 
    IN PCOMPONENTNAME STRING,
    IN PRUNCLUSTERINGDESC STRING, 
    IN PSCHEMA STRING,  
    IN PRECORDPROCESSEDNR STRING,
    IN PPITLOGGING FLOAT64,
    OUT OUT_PARAM STRING
)
BEGIN
    DECLARE strruncluster STRING DEFAULT '[0]';
    DECLARE sqlcode FLOAT64 DEFAULT 0;
    DECLARE sqlstate STRING DEFAULT '00000';
    DECLARE msg STRING DEFAULT '';
    DECLARE sqlstmt STRING DEFAULT '';
    DECLARE sqlbegintransaction STRING DEFAULT 'BEGIN TRANSACTION;';
    DECLARE sqlcommit STRING DEFAULT 'COMMIT;';
    DECLARE strschema STRING DEFAULT 'P_LEW_MART_PIT';
    DECLARE intlogginglevel FLOAT64 DEFAULT 3;
    DECLARE res ARRAY<JSON>;
    DECLARE val_run_ts STRING;
    DECLARE val_run_day_id STRING;
    DECLARE val_run_id_seq STRING;
    DECLARE val_load_id STRING;

    IF PPITLOGGING IS NULL THEN
        BEGIN
            SET PPITLOGGING = intlogginglevel;
        END;
    ELSE
        BEGIN
            SET intlogginglevel = PPITLOGGING;
        END;
    END IF;
        
    IF intlogginglevel >= 3 THEN
        BEGIN
        
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
        
            IF PSCHEMA = '' OR PSCHEMA IS NULL THEN
                BEGIN
                    SET PSCHEMA = strschema;
                END;
            ELSE
                BEGIN
                    SET strschema = UPPER(PSCHEMA);
                END;
            END IF;

            SET sqlstmt = '';
            SET sqlstmt = '''		
                    SELECT
                          FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%E3S', rs.run_ts) AS run_ts
                        , CAST(rs.run_day_id AS STRING) 				AS run_day_id
                        , CAST(rs.run_id_seq AS STRING)										AS run_id_seq
                        , CAST(rs.load_id AS STRING)								AS load_id
                    FROM 
                    `#PSCHEMA#`.t_cntl_etl_logging_run_seq rs
                    INNER JOIN
                    (
                        SELECT 
                            COALESCE(MAX(run_id_seq),0) AS run_id_seq 
                        FROM `#PSCHEMA#`.t_cntl_etl_logging_run_seq
                        WHERE TRUE	
                            AND run_clustering_desc 	= CONCAT('[', '#RUNCLUSTER#', ']')
                            AND application_name 		= '#PAPPLICATIONNAME#'
                    ) rsm
                    ON TRUE
                        AND rs.run_id_seq = rsm.run_id_seq
            ''';
            
            SET sqlstmt = REPLACE(sqlstmt, '#PAPPLICATIONNAME#', UPPER(PAPPLICATIONNAME));
            SET sqlstmt = REPLACE(sqlstmt, '#RUNCLUSTER#', UPPER(strruncluster));
            SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', LOWER(strschema));
    
            BEGIN
                EXECUTE IMMEDIATE sqlbegintransaction;
                EXECUTE IMMEDIATE format("""
                SELECT ARRAY_AGG(JSON_ARRAY(%s, %s, %s, %s))
                FROM (%s)
                """, 'run_ts', 'run_day_id', 'run_id_seq', 'load_id', sqlstmt) INTO res ;
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('EndComponentLogging: [', sqlstmt, ']  FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;			
            END;

            SET val_run_ts = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[0]');
            SET val_run_day_id = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[1]');
            SET val_run_id_seq = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[2]');
            SET val_load_id = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[3]');
            
            SET sqlstmt = '';
            SET sqlstmt = '''			
                INSERT INTO `#PSCHEMA#`.t_cntl_etl_logging 
                    (
                          run_id_seq
                        , run_ts
                        , run_day_id					  
                        , run_clustering_desc
                        , application_name
                        , module_name
                        , component_name
                        , component_level_fg
                        , load_id	
                        , multi_client_run_lst
                        , dwh_created_ts
                        , client_id
                        , component_end_fg	
                        , end_run_ts
                        , record_processed_nr
                    ) 
                SELECT
                          CAST(#RUNIDSEQ# AS INT64)														AS run_id_seq
                        , SAFE.PARSE_DATETIME('%Y-%m-%d %H:%M:%E3S', '#RUNTS#')			AS run_ts
                        , SAFE_CAST('#RUNDAYID#' AS DATE)							AS run_day_id		  
                        , CONCAT('[', '#RUNCLUSTER#', ']') 										AS run_clustering_desc
                        , '#PAPPLICATIONNAME#'												AS application_name
                        , '#PMODULENAME#'													AS module_name
                        , '#PCOMPONENTNAME#'												AS component_name
                        , CAST(1 AS INT64)														AS component_level_fg
                        , CAST(COALESCE(SAFE_CAST('#PLOADID#' AS FLOAT64), -2) AS INT64)					AS load_id	
                        , SPLIT('#RUNCLUSTER#', ',')								AS multi_client_run_lst
                        , CAST(CURRENT_TIMESTAMP() AS DATETIME) 												AS dwh_created_ts
                        , IF(
                            (SELECT COUNT(1) FROM UNNEST(SPLIT('#RUNCLUSTER#', ',')) AS el WHERE el = '0') = 0 AND ARRAY_LENGTH(SPLIT('#RUNCLUSTER#', ',')) = 1
                            ,CAST(COALESCE(SAFE_CAST('#RUNCLUSTER#' AS FLOAT64),-2) AS INT64)
                            ,-2
                            )																AS client_id	
                        , CAST(1 AS INT64)														AS component_end_fg
                        , CAST(CURRENT_TIMESTAMP() AS DATETIME)												AS end_run_ts
                        , COALESCE(SAFE_CAST('#PRECORDPROCESSEDNR#' AS INT64),-1)				AS record_processed_nr
            ''';
            
            SET sqlstmt = REPLACE(sqlstmt, '#RUNIDSEQ#', COALESCE(val_run_id_seq, 'NULL'));
            SET sqlstmt = REPLACE(sqlstmt, '#RUNTS#', COALESCE(val_run_ts, ''));
            SET sqlstmt = REPLACE(sqlstmt, '#RUNDAYID#', COALESCE(val_run_day_id, ''));
            SET sqlstmt = REPLACE(sqlstmt, '#PLOADID#', COALESCE(val_load_id, ''));					
            
            SET sqlstmt = REPLACE(sqlstmt, '#PAPPLICATIONNAME#', UPPER(PAPPLICATIONNAME));
            SET sqlstmt = REPLACE(sqlstmt, '#RUNCLUSTER#', UPPER(strruncluster));
            SET sqlstmt = REPLACE(sqlstmt, '#PMODULENAME#', UPPER(PMODULENAME));
            SET sqlstmt = REPLACE(sqlstmt, '#PCOMPONENTNAME#', UPPER(PCOMPONENTNAME));		
            SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', LOWER(strschema));
            SET sqlstmt = REPLACE(sqlstmt, '#PRECORDPROCESSEDNR#', COALESCE(PRECORDPROCESSEDNR, ''));				

            BEGIN
                EXECUTE IMMEDIATE sqlstmt;
                EXECUTE IMMEDIATE sqlcommit;				
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('EndComponentLogging: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;			
            END;

            SET OUT_PARAM = val_run_id_seq;
        END;
    END IF;
END;
/* --- EOF - END OF FILE --- */













