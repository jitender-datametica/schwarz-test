/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_EndModuleLogging
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  2.0  2023-06-02 Nikolai Toknov  add parameter pPITLogging
#  2.1  2023-08-14 Andreas Kurz    changed update to insert
#-------------------------------------------------------------------------------
*/

/*
USE ROLE        R_LDL_D_PIT_ETL;
--USE DATABASE  LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE  LDL_PRODUCTION_CLONE_PIT_R51501;
USE DATABASE    LDL_PRODUCTION_CLONE_PIT_QS;
USE SCHEMA      P_LEW_MART_PIT;
USE WAREHOUSE   WH_LDL_D_PIT_ETL_S;
*/

/* ---------------------------------------------------------------------
PROCEDURE   :   sp_EndModuleLogging(pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pQueryTag STRING)
Input       :   pApplicationName    STRING 
                pModuleName         STRING
                pRunClusteringDesc  STRING --> [0] running in sequence 
                pPITLogging         FLOAT  --> 0 - no logging, 1 - Start/End-Logging, 2 - Start/End-ModuleLogging, 3 - Start/End-ComponentLogging
                                
Return      :   Error + Error Msg
Convert     :   None    
Description :   Initialize Logging 
Example     :   Call sp_EndModuleLogging('PITonCloud','Performance', '[0]', 'Start Logging');
                CALL sp_EndModuleLogging('PITonCloud','Performance', '[0]',f_QueryTag('ETL Logging','PITonCloud',NULL));
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_endmodulelogging (
    IN PAPPLICATIONNAME STRING, 
    IN PMODULENAME STRING, 
    IN PRUNCLUSTERINGDESC STRING, 
    IN PSCHEMA STRING, 
    IN PPITLOGGING FLOAT64,
    OUT OUT_PARAM STRING
)
BEGIN
    DECLARE strruncluster STRING DEFAULT '[0]';
    DECLARE msg STRING DEFAULT '';
    DECLARE sqlstmt STRING DEFAULT '';
    DECLARE strschema STRING DEFAULT 'p_lew_mart_pit';
    DECLARE intlogginglevel FLOAT64 DEFAULT 3;
    DECLARE res ARRAY<JSON>;
    DECLARE sqlbegintransaction STRING DEFAULT 'BEGIN TRANSACTION;';
    DECLARE sqlcommit STRING DEFAULT 'COMMIT TRANSACTION;';
    
    DECLARE v_run_ts STRING;
    DECLARE v_run_day_id STRING;
    DECLARE v_run_id_seq STRING;
    DECLARE v_load_id STRING;

    --CHECK INPUT pPITLogging
    IF PPITLOGGING IS NULL THEN
        BEGIN
            SET PPITLOGGING = intlogginglevel;
        END;
    ELSE
        BEGIN
            SET intlogginglevel = PPITLOGGING;
        END;
    END IF;

    -- v2.0        
    IF intlogginglevel >= 2 THEN
        BEGIN
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
                    SET strschema = UPPER(PSCHEMA);
                END;
            END IF;

            SET sqlstmt = '';
            SET sqlstmt = '''     
                    SELECT
                          FORMAT_DATETIME('%Y-%m-%d %H:%M:%E3S', rs.run_ts)  AS run_ts
                        , CAST(rs.run_day_id AS STRING)                       AS run_day_id
                        , CAST(rs.run_id_seq AS STRING)                       AS run_id_seq
                        , CAST(rs.load_id AS STRING)                          AS load_id
                    FROM 
                    `#PSCHEMA#.t_cntl_etl_logging_run_seq` rs
                    INNER JOIN
                    (
                        SELECT 
                            COALESCE(MAX(run_id_seq),0) AS run_id_seq 
                        FROM `#PSCHEMA#.t_cntl_etl_logging_run_seq`
                        WHERE TRUE  
                            AND run_clustering_desc     = CONCAT('[', '#RUNCLUSTER#', ']')
                            AND application_name        = '#PAPPLICATIONNAME#'
                    ) rsm
                    ON TRUE
                        AND rs.run_id_seq = rsm.run_id_seq
            ''';
            
            -- Variable Substitution
            SET sqlstmt = REPLACE(sqlstmt, '#PAPPLICATIONNAME#', UPPER(PAPPLICATIONNAME));
            SET sqlstmt = REPLACE(sqlstmt, '#RUNCLUSTER#', UPPER(strruncluster));
            SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', LOWER(strschema));
    
            -- Retrieve next Seq RunID
            BEGIN
                EXECUTE IMMEDIATE FORMAT("""
                SELECT ARRAY_AGG(JSON_ARRAY(run_ts, run_day_id, run_id_seq, load_id))
                FROM (%s)
                """, sqlstmt) INTO res;
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('EndComponentLogging: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;
            END;

            IF ARRAY_LENGTH(res) > 0 THEN
                BEGIN
                    SET v_run_ts = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[0]');
                    SET v_run_day_id = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[1]');
                    SET v_run_id_seq = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[2]');
                    SET v_load_id = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[3]');
                END;
            END IF;
            
            SET sqlstmt = '';
            SET sqlstmt = '''
                INSERT INTO `#PSCHEMA#.t_cntl_etl_logging` 
                    (
                          run_id_seq
                        , run_ts
                        , run_day_id
                        , run_clustering_desc
                        , application_name
                        , module_name
                        , component_name
                        , module_level_fg
                        , load_id
                        , multi_client_run_lst
                        , dwh_created_ts
                        , client_id 
                        , module_end_fg 
                        , end_run_ts
                    ) 
                SELECT
                          CAST('#RUNIDSEQ#' AS INT64)                                                  AS run_id_seq
                        , PARSE_DATETIME('%Y-%m-%d %H:%M:%E3S', '#RUNTS#')                            AS run_ts
                        , PARSE_DATE('%Y-%m-%d', '#RUNDAYID#')                                         AS run_day_id
                        , CONCAT('[', '#RUNCLUSTER#', ']')                                             AS run_clustering_desc
                        , '#PAPPLICATIONNAME#'                                                         AS application_name
                        , '#PMODULENAME#'                                                              AS module_name
                        , '#PMODULENAME#'                                                              AS component_name
                        , CAST(1 AS INT64)                                                             AS module_level_fg
                        , CAST(COALESCE(SAFE_CAST('#PLOADID#' AS FLOAT64), -2) AS INT64)               AS load_id
                        , SPLIT('#RUNCLUSTER#', ',')                                                   AS multi_client_run_lst
                        , CAST(CURRENT_TIMESTAMP() AS DATETIME)                                                          AS dwh_created_ts
                        , IF(
                            NOT EXISTS(SELECT 1 FROM UNNEST(SPLIT('#RUNCLUSTER#', ',')) AS x WHERE x = '0') 
                            AND ARRAY_LENGTH(SPLIT('#RUNCLUSTER#', ',')) = 1
                            , CAST(COALESCE(SAFE_CAST('#RUNCLUSTER#' AS FLOAT64), -2) AS INT64)
                            , CAST(-2 AS INT64)
                            )                                                                          AS client_id
                        , CAST(1 AS INT64)                                                             AS module_end_fg
                        , CAST(CURRENT_TIMESTAMP() AS DATETIME)                                                          AS end_run_ts          
            ''';
            -- Variable Substitution
            SET sqlstmt = REPLACE(sqlstmt, '#RUNIDSEQ#', COALESCE(v_run_id_seq, '0'));
            SET sqlstmt = REPLACE(sqlstmt, '#RUNTS#', COALESCE(v_run_ts, '1970-01-01 00:00:00.000'));
            SET sqlstmt = REPLACE(sqlstmt, '#RUNDAYID#', COALESCE(v_run_day_id, '1970-01-01'));
            SET sqlstmt = REPLACE(sqlstmt, '#PLOADID#', COALESCE(v_load_id, '-2'));                  
            
            SET sqlstmt = REPLACE(sqlstmt, '#PAPPLICATIONNAME#', UPPER(PAPPLICATIONNAME));
            SET sqlstmt = REPLACE(sqlstmt, '#RUNCLUSTER#', UPPER(strruncluster));
            SET sqlstmt = REPLACE(sqlstmt, '#PMODULENAME#', UPPER(PMODULENAME));
            SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', LOWER(strschema));  
                    
            BEGIN
                EXECUTE IMMEDIATE sqlbegintransaction;
                EXECUTE IMMEDIATE sqlstmt;
                EXECUTE IMMEDIATE sqlcommit;
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('EndModuleLogging: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;
            END;
            
            SET OUT_PARAM = v_run_id_seq;
        END;
    END IF;               
END;