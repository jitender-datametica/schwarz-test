/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_EndLogging
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2023-01-24 Andreas Kurz		Corrected sqlBeginTransaction which was missing
#  2.0  2023-06-02 Nikolai Toknov   add parameter pPITLogging
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

/* ---------------------------------------------------------------------
PROCEDURE	:	sp_EndLogging(pApplicationName STRING, pRunClusteringDesc STRING)
Input		:   pApplicationName 	STRING 
				pRunClusteringDesc 	STRING --> [0] running in sequence
				pPITLogging			FLOAT  --> 0 - no logging, 1 - Start/End-Logging, 2 - Start/End-ModuleLogging, 3 - Start/End-ComponentLogging
								
Return		:	Error + Error Msg | Success Nbr of rows (modules and or compenents) of this run
Convert		:	None    
Description	: 	Initialize Logging 
Example		:	CALL sp_StartLogging('PITonCloud','[0]',f_QueryTag('ETL Logging','PITonCloud',NULL),1);
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_endlogging (
      IN PAPPLICATIONNAME      STRING 
    , IN PRUNCLUSTERINGDESC    STRING    
	, IN PSCHEMA				STRING
	, IN PPITLOGGING			FLOAT64
    , OUT OUT_PARAM            STRING	
)
BEGIN
    DECLARE strruncluster STRING DEFAULT '[0]';
    DECLARE msg STRING DEFAULT '';
    DECLARE sqlstmt STRING DEFAULT '';
    DECLARE sqlbegintransaction STRING DEFAULT 'BEGIN TRANSACTION;';
    DECLARE sqlcommit STRING DEFAULT 'COMMIT;';
    DECLARE strschema STRING DEFAULT 'p_lew_mart_pit_1';
    DECLARE intlogginglevel FLOAT64 DEFAULT 3;
    DECLARE res ARRAY<JSON>;
    DECLARE var_run_ts STRING;
    DECLARE var_run_day_id STRING;
    DECLARE var_run_id_seq STRING;
    DECLARE var_load_id STRING;

    -- CHECK INPUT pPITLogging 
    IF PPITLOGGING IS NULL THEN
        SET PPITLOGGING = intlogginglevel;
    ELSE
        SET intlogginglevel = PPITLOGGING;
    END IF;
        
    -- v2.0
    IF intlogginglevel >= 1 THEN
    
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
                      FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S.E3S', rs.run_ts) 	AS run_ts
                    , FORMAT_DATE('%Y-%m-%d', rs.run_day_id) 				AS run_day_id
                    , CAST(rs.run_id_seq AS STRING)							AS run_id_seq
                    , CAST(rs.load_id AS STRING)							AS load_id
                FROM 
                `#PSCHEMA#.t_cntl_etl_logging_run_seq_1` rs_1
                INNER JOIN
                (
                    SELECT 
                        COALESCE(MAX(run_id_seq),0) AS run_id_seq 
                    FROM `#PSCHEMA#.t_cntl_etl_logging_run_seq_1`
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

        
        -- Retrieve next Seq RunID
        BEGIN
            EXECUTE IMMEDIATE sqlbegintransaction;
            EXECUTE IMMEDIATE format("""
                SELECT ARRAY_AGG(JSON_OBJECT('run_ts', run_ts, 'run_day_id', run_day_id, 'run_id_seq', run_id_seq, 'load_id', load_id))
                FROM (%s)
            """, sqlstmt) INTO res;
           EXECUTE IMMEDIATE sqlcommit;
        EXCEPTION WHEN ERROR THEN
            SET msg = CONCAT('EndComponentLogging: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
                
            RAISE USING MESSAGE = msg;
        END;

        -- res.getColumnValue(1) = RUN_ID_SEQ
        SET var_run_ts = JSON_VALUE(res[SAFE_OFFSET(0)], '$.run_ts');
        SET var_run_day_id = JSON_VALUE(res[SAFE_OFFSET(0)], '$.run_day_id');
        SET var_run_id_seq = JSON_VALUE(res[SAFE_OFFSET(0)], '$.run_id_seq');
        SET var_load_id = JSON_VALUE(res[SAFE_OFFSET(0)], '$.load_id');
        
        SET sqlstmt = '';
        SET sqlstmt = '''
            INSERT INTO `#PSCHEMA#.t_cntl_etl_logging_1` 
                ( 
                      run_id_seq
                    , run_ts
                    , run_day_id
                    , run_clustering_desc
                    , application_name
                    , module_name
                    , component_name
                    , end_processing_fg
                    , load_id
                    , multi_client_run_lst
                    , dwh_created_ts
                    , client_id
                    , completed_run_fg
                    , end_run_ts
                ) 
            SELECT 
                  #RUNIDSEQ#														AS run_id_seq
                , SAFE_CAST('#RUNTS#' AS DATETIME)                                 AS run_ts
                , SAFE_CAST('#RUNDAYID#' AS DATE)                                   AS run_day_id
                , CONCAT('[', '#RUNCLUSTER#', ']') 									AS run_clustering_desc
                , '#PAPPLICATIONNAME#'                                              AS application_name
                , '>>>End Logging<<<'                                               AS module_name
                , '>>>End Logging<<<'                                               AS component_name
                , 1														            AS end_processing_fg
                , COALESCE(SAFE_CAST('#PLOADID#' AS INT64),-2)					    AS load_id 
                , SPLIT('#RUNCLUSTER#', ',')								        AS multi_client_run_lst
                , CURRENT_DATE("Europe/Berlin")TIME() 												AS dwh_created_ts
                , IF(
                    '0' NOT IN UNNEST(SPLIT('#RUNCLUSTER#', ',')) AND ARRAY_LENGTH(SPLIT('#RUNCLUSTER#', ',')) = 1
                    , COALESCE(SAFE_CAST('#RUNCLUSTER#' AS INT64), -2)
                    , -2
                  )																    AS client_id
                , 1														            AS completed_run_fg
                , CURRENT_DATE("Europe/Berlin")TIME()												AS end_run_ts
        ''';
        
        -- Variable Substitution
        SET sqlstmt = REPLACE(sqlstmt, '#RUNIDSEQ#', COALESCE(var_run_id_seq, '0'));
        SET sqlstmt = REPLACE(sqlstmt, '#RUNTS#', COALESCE(var_run_ts, '1970-01-01 00:00:00.000'));
        SET sqlstmt = REPLACE(sqlstmt, '#RUNDAYID#', COALESCE(var_run_day_id, '1970-01-01'));
        SET sqlstmt = REPLACE(sqlstmt, '#PLOADID#', COALESCE(var_load_id, '-2'));					
        
        SET sqlstmt = REPLACE(sqlstmt, '#PAPPLICATIONNAME#', UPPER(PAPPLICATIONNAME));
        SET sqlstmt = REPLACE(sqlstmt, '#RUNCLUSTER#', UPPER(strruncluster));
        SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', LOWER(strschema));	

    
        BEGIN	
            EXECUTE IMMEDIATE sqlbegintransaction;
            EXECUTE IMMEDIATE sqlstmt;
            EXECUTE IMMEDIATE sqlcommit;
        EXCEPTION WHEN ERROR THEN
            SET msg = CONCAT('P_ENDPROCESSING: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
                
            RAISE USING MESSAGE = msg;
        END;
        
        -- res.next();
        -- return RUN_ID_SEQ
        SET OUT_PARAM = var_run_id_seq;	
    END IF;
END;