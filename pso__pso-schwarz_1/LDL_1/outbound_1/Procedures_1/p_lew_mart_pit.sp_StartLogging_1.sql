/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_StartLogging
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1	2023-05-24 Andreas Kurz		Changed return Value to RUNIDSEQ
#									and chenged logic of retrieving RUNIDSEQ upfront
#  1.2  2023-06-28 Andreas Kurz		Changed retrieving RUNSEQID upfront to combine from
#									seq and logging
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
PROCEDURE	:	sp_StartLogging(pLoadID	STRING, pApplicationName STRING, pRunClusteringDesc STRING, pQueryTag STRING, pSchema STRING)
Input		:   
				pLoadID				STRING --> ETL Load ID YYYYMMDDHHMMSSNNN * 100 + CLIENT_ID [All 99]
				pApplicationName 	STRING 
				pRunClusteringDesc 	STRING --> [0] running in sequence
				pQueryTag 			STRING
				pPITLogging			FLOAT  --> 0 - no logging, 1 - Start/End-Logging, 2 - Start/End-ModuleLogging, 3 - Start/End-ComponentLogging
				
Return		:	Error + Error Msg
Convert		:	None    
Description	: 	Initialize Logging 
Example		:	CALL sp_StartLogging('123','PITonCloud','[0]',f_QueryTag('ETL Logging','PITonCloud',NULL),'P_LEW_MART_PIT_1', 1);
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_startlogging (
    IN PLOADID STRING,
    IN PAPPLICATIONNAME STRING,
    IN PRUNCLUSTERINGDESC STRING,
    IN PQUERYTAG STRING,
    IN PSCHEMA STRING,
    IN PPITLOGGING FLOAT64,
    OUT OUT_PARAM STRING
)
BEGIN
    DECLARE strruncluster STRING DEFAULT '[0]';
    DECLARE SQLCODE INT64 DEFAULT 0;
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
    IF intlogginglevel >= 1 THEN
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
                      FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%E3S', CURRENT_TIMESTAMP()) AS run_ts
                    , FORMAT_DATE('%Y-%m-%d', CURRENT_DATE("Europe/Berlin")) AS run_day_id
                    , CAST(GREATEST(logs.run_id_seq, log.run_id_seq) AS STRING) AS run_id_seq
                FROM
                (
                    SELECT
                        COALESCE(logs.run_id_seq,0)+1 AS run_id_seq
                    FROM 
                    (
                        SELECT 
                            MAX(run_id_seq) AS run_id_seq 
                        FROM #PSCHEMA#.t_cntl_etl_logging_run_seq_1
                        WHERE TRUE	
                            --AND run_clustering_desc 	= '#RUNCLUSTER#' 
                            --AND application_name 		= '#PAPPLICATIONNAME#'
                            AND deleted_fg 				= 0
                    ) logs
                ) logs				
                CROSS JOIN				
                (
                    SELECT
                        COALESCE(log.run_id_seq,0)+1 AS run_id_seq
                    FROM 
                    (
                        SELECT 
                            MAX(run_id_seq) AS run_id_seq 
                        FROM #PSCHEMA#.t_cntl_etl_logging_1
                        WHERE TRUE	
                            --AND run_clustering_desc 	= '#RUNCLUSTER#' 
                            --AND application_name 		= '#PAPPLICATIONNAME#'
                            AND deleted_fg 				= 0
                    ) log	
                ) log		
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
                SET msg = CONCAT('P_STARTPROCESSING: [', sqlstmt, '] FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;
            END;
			-- res.getColumnValue(1) = RUN_ID_SEQ
            SET run_ts = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[0]');
            SET run_day_id = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[1]');
            SET run_id_seq = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(0)], '$[2]');

            SET sqlstmt = '';
            SET sqlstmt = '''
                          INSERT INTO #PSCHEMA#.t_cntl_etl_logging_1
                    ( 
                          run_id_seq
                        , run_ts
                        , run_day_id
                        , run_clustering_desc
                        , application_name
                        , module_name
                        , component_name
                        , query_tag
                        , start_processing_fg
                        , load_id
                        , multi_client_run_lst
                        , dwh_created_ts
                        , client_id
                        , start_run_ts
                    ) 
                SELECT 
                      #RUNIDSEQ#
                    , CAST(SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%E3S', '#RUNTS#') AS DATETIME) 
                    , SAFE.PARSE_DATE('%Y-%m-%d', '#RUNDAYID#')
                    , CONCAT('[', '#RUNCLUSTER#', ']') AS run_clustering_desc
                    , 'SALES_INGESTION'
                    , '>>>Start Logging<<<'
                    , '>>>Start Logging<<<'
                    , '#QUERYTAG#'
                    , 1
                    , COALESCE(SAFE_CAST('#PLOADID#' AS INT64),-2) AS load_id
                    , SPLIT('#RUNCLUSTER#', ',') AS multi_client_run_lst
                    , CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_ts
                    , CASE 
                        WHEN ARRAY_LENGTH(SPLIT('#RUNCLUSTER#', ',')) = 1 AND '#RUNCLUSTER#' != '0'
                        THEN COALESCE(SAFE_CAST('#RUNCLUSTER#' AS INT64),-2)
                        ELSE -2
                      END AS client_id
                    , CAST(CURRENT_TIMESTAMP() AS DATETIME) AS start_run_ts

            ''';

            -- Variable Substitution
            SET sqlstmt = REPLACE(sqlstmt, '#RUNIDSEQ#', run_id_seq);
            SET sqlstmt = REPLACE(sqlstmt, '#RUNTS#', run_ts);
            SET sqlstmt = REPLACE(sqlstmt, '#RUNDAYID#', run_day_id);	

            SET sqlstmt = REPLACE(sqlstmt, '#PAPPLICATIONNAME#', UPPER(PAPPLICATIONNAME));
            SET sqlstmt = REPLACE(sqlstmt, '#RUNCLUSTER#', UPPER(strruncluster));
            SET sqlstmt = REPLACE(sqlstmt, '#QUERYTAG#', UPPER(PQUERYTAG));
            SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', strschema);
            SET sqlstmt = REPLACE(sqlstmt, '#PLOADID#', strloadid);		
          select sqlstmt;
            BEGIN
                EXECUTE IMMEDIATE sqlstmt;
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('P_STARTPROCESSING: [', sqlstmt, '] FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;
            END;

            SET sqlstmt = '';
            SET sqlstmt = '''
                INSERT INTO #PSCHEMA#.t_cntl_etl_logging_run_seq_1
                    (
                          run_id_seq
                        , run_ts 
                        , run_day_id
                        , run_clustering_desc
                        , application_name
                        , load_id
                        , multi_client_run_lst
                        , dwh_created_ts
                        , client_id	
                        , start_dt_pit_data 						
                        , end_dt_pit_data 						
                        , next_run_dt_reagg 						
                        , cnt_data_history_pit_in_adv_weeks		
                        , cnt_data_history_pit_in_days			
                        , cnt_intermediate_period_in_adv_weeks	
                        , cnt_intermediate_period_in_days		
                        , start_dt_intermediate					
                        , end_dt_intermediate 					
                        , start_adv_week_intermediate			
                        , end_adv_week_intermediate				
                        , cnt_reagg_period_in_adv_weeks			
                        , cnt_reagg_period_in_days				
                        , start_dt_reagg 						
                        , end_dt_reagg 							
                        , start_adv_week_reagg					
                        , end_adv_week_reagg						
                        , cnt_baseline_adv_week					
                        , loc_time_gaps_opening_days				
                        , loc_time_gaps_closing_days				
                        , wh_buying_price_add_period_in_days		
                        , loc_store_sales_net_val_gt		
                        , loc_store_sales_qty_gt					
                        , adp_time_gap_in_days					
                        , ctr_adv_week_start_weekday_id			
                        , ctr_store_nbr							
                        , ctr_ex_elvis_country_fg				
                        , start_dt_base_metric_nf_fa 			
                        , end_dt_base_metric_nf_fa 				
                        , start_dt_deliv_qty 					
                        , end_dt_deliv_qty 						
                        , start_dt_stc_real_qty 					
                        , end_dt_stc_real_qty 					
                        , exec_pit_daily_run_fg					
                        , exec_pit_weekly_run_fg					
                        , exec_pit_dq_run_fg						
                        , exec_pit_manual_run_fg 				
                        , exec_pit_manual_country_lst 			
                        , exec_pit_run_weekly_weekday			
                        , exec_pit_cnt_initial_adv_weeks			
                        , exec_pit_ab_parallel_execution	
                        , exec_pit_sf_credit_timerange_in_days
                        , default_pit_manual_run_fg
                        , pit_max_data_history_in_days
                        , pit_max_data_history_in_adv_week	
                        , exec_client_fg					
                )
                SELECT
                      rseq.run_id_seq
                    , rseq.run_ts
                    , rseq.run_day_id
                    , rseq.run_clustering_desc
                    , rseq.application_name
                    , rseq.load_id
                    , rseq.multi_client_run_lst
                    , rseq.dwh_created_ts
                    , rseq.client_id	
                    
                    -- Current Parameters
                    , COALESCE(pa.start_dt_pit_data 					, SAFE.PARSE_DATE('%Y-%m-%d', '8888-12-31') ) 	AS 	start_dt_pit_data 					
                    , COALESCE(pa.end_dt_pit_data 						, SAFE.PARSE_DATE('%Y-%m-%d', '8888-12-31') ) 	AS  end_dt_pit_data 						
                    , COALESCE(pa.next_run_dt_reagg 					, SAFE.PARSE_DATE('%Y-%m-%d', '8888-12-31') ) 	AS 	next_run_dt_reagg 					
                    , COALESCE(pa.cnt_data_history_pit_in_adv_weeks		, -1) 			AS  cnt_data_history_pit_in_adv_weeks		
                    , COALESCE(pa.cnt_data_history_pit_in_days			, -1) 			AS  cnt_data_history_pit_in_days			
                    , COALESCE(pa.cnt_intermediate_period_in_adv_weeks	, -1) 			AS  cnt_intermediate_period_in_adv_weeks
                    , COALESCE(pa.cnt_intermediate_period_in_days		, -1) 			AS  cnt_intermediate_period_in_days		
                    , COALESCE(pa.start_dt_intermediate					, SAFE.PARSE_DATE('%Y-%m-%d', '8888-12-31') ) 	AS  start_dt_intermediate					
                    , COALESCE(pa.end_dt_intermediate 					, SAFE.PARSE_DATE('%Y-%m-%d', '8888-12-31') ) 	AS  end_dt_intermediate 					
                    , COALESCE(pa.start_adv_week_intermediate			, -1) 			AS  start_adv_week_intermediate			
                    , COALESCE(pa.end_adv_week_intermediate				, -1) 			AS  end_adv_week_intermediate				
                    , COALESCE(pa.cnt_reagg_period_in_adv_weeks			, -1) 			AS  cnt_reagg_period_in_adv_weeks			
                    , COALESCE(pa.cnt_reagg_period_in_days				, -1) 			AS  cnt_reagg_period_in_days				
                    , COALESCE(pa.start_dt_reagg 						, SAFE.PARSE_DATE('%Y-%m-%d', '8888-12-31') ) 	AS  start_dt_reagg 						
                    , COALESCE(pa.end_dt_reagg 							, SAFE.PARSE_DATE('%Y-%m-%d', '8888-12-31') ) 	AS  end_dt_reagg 							
                    , COALESCE(pa.start_adv_week_reagg					, -1) 			AS  start_adv_week_reagg					
                    , COALESCE(pa.end_adv_week_reagg					, -1) 			AS 	end_adv_week_reagg					
                    , COALESCE(pa.cnt_baseline_adv_week					, -1) 			AS  cnt_baseline_adv_week					
                    , COALESCE(pa.loc_time_gaps_opening_days			, -1) 			AS 	loc_time_gaps_opening_days			
                    , COALESCE(pa.loc_time_gaps_closing_days			, -1) 			AS 	loc_time_gaps_closing_days			
                    , COALESCE(pa.wh_buying_price_add_period_in_days	, -1) 			AS 	wh_buying_price_add_period_in_days	
                    , CAST(COALESCE(pa.loc_store_sales_net_val_gt			, -1) AS NUMERIC)			AS 	loc_store_sales_net_val_gt			
                    , CAST(COALESCE(pa.loc_store_sales_qty_gt				, -1) AS NUMERIC)			AS 	loc_store_sales_qty_gt				
                    , COALESCE(pa.adp_time_gap_in_days					, -1) 			AS  adp_time_gap_in_days					
                    , COALESCE(pa.ctr_adv_week_start_weekday_id			, -1) 			AS  ctr_adv_week_start_weekday_id			
                    , CAST(COALESCE(pa.ctr_store_nbr							, -1) AS NUMERIC) 		    AS  ctr_store_nbr							
                    , COALESCE(pa.ctr_ex_elvis_country_fg				, -1) 		    AS  ctr_ex_elvis_country_fg				
                    , COALESCE(pa.start_dt_base_metric_nf_fa 			, -1) 			AS  start_dt_base_metric_nf_fa 			
                    , COALESCE(pa.end_dt_base_metric_nf_fa 				, -1) 			AS  end_dt_base_metric_nf_fa 				
                    , COALESCE(pa.start_dt_deliv_qty 					, -1) 			AS  start_dt_deliv_qty 					
                    , COALESCE(pa.end_dt_deliv_qty 						, -1) 			AS  end_dt_deliv_qty 						
                    , COALESCE(pa.start_dt_stc_real_qty 				, -1) 			AS 	start_dt_stc_real_qty 				
                    , COALESCE(pa.end_dt_stc_real_qty 					, -1) 			AS  end_dt_stc_real_qty 					
                    , COALESCE(pa.exec_pit_daily_run_fg					, -1) 		    AS  exec_pit_daily_run_fg					
                    , COALESCE(pa.exec_pit_weekly_run_fg				, -1) 		    AS 	exec_pit_weekly_run_fg				
                    , COALESCE(pa.exec_pit_dq_run_fg					, -1) 		    AS 	exec_pit_dq_run_fg					
                    , COALESCE(pa.exec_pit_manual_run_fg 				, -1) 		    AS  exec_pit_manual_run_fg 				
                    , COALESCE(pa.exec_pit_manual_country_lst 			, NULL) 		AS  exec_pit_manual_country_lst 			
                    , COALESCE(pa.exec_pit_run_weekly_weekday			, -1) 			AS  exec_pit_run_weekly_weekday			
                    , COALESCE(pa.exec_pit_cnt_initial_adv_weeks		, -1) 			AS 	exec_pit_cnt_initial_adv_weeks		
                    , COALESCE(pa.exec_pit_ab_parallel_execution	    , -1) 			AS  exec_pit_ab_parallel_execution	  
                    , COALESCE(pa.exec_pit_sf_credit_timerange_in_days  , -1) 			AS  exec_pit_sf_credit_timerange_in_days
                    , COALESCE(pa.default_pit_manual_run_fg             , -1) 		    AS  default_pit_manual_run_fg           
                    , COALESCE(pa.pit_max_data_history_in_days          , -1) 			AS  pit_max_data_history_in_days        
                    , COALESCE(pa.pit_max_data_history_in_adv_week	    , -1) 			AS  pit_max_data_history_in_adv_week	  
                    , COALESCE(pa.exec_client_fg                        , -1)			AS  exec_client_fg                      
                FROM 
                -- Run Sequence
                (
                    SELECT 
                          #RUNIDSEQ# 														AS run_id_seq
                        , COALESCE(SAFE.PARSE_DATETIME('%Y-%m-%d %H:%M:%E3S', '#RUNTS#'), CURRENT_DATE("Europe/Berlin")TIME()) 			AS run_ts			
                        , COALESCE(SAFE.PARSE_DATE('%Y-%m-%d', '#RUNDAYID#'), CURRENT_DATE("Europe/Berlin"))							AS run_day_id
                        , CONCAT('[', '#RUNCLUSTER#', ']') 										AS run_clustering_desc
                        , '#PAPPLICATIONNAME#'												AS application_name
                        , COALESCE(SAFE_CAST('#PLOADID#' AS INT64),-2)					AS load_id
                        , SPLIT('#RUNCLUSTER#', ',')	AS multi_client_run_lst
                        , CAST(CURRENT_TIMESTAMP() AS DATETIME)												AS dwh_created_ts
                        , CASE 
                            WHEN ARRAY_LENGTH(SPLIT('#RUNCLUSTER#', ',')) = 1 AND '#RUNCLUSTER#' != '0'
                            THEN COALESCE(SAFE_CAST('#RUNCLUSTER#' AS INT64),-2)
                            ELSE -2
                          END																AS client_id
                ) rseq
                
                -- Current Prameter Setting
                LEFT JOIN
                (
                SELECT
                      pa.client_id
                    , pa.start_dt_pit_data 						
                    , pa.end_dt_pit_data 						
                    , pa.next_run_dt_reagg 						
                    , pa.cnt_data_history_pit_in_adv_weeks		
                    , pa.cnt_data_history_pit_in_days			
                    , pa.cnt_intermediate_period_in_adv_weeks	
                    , pa.cnt_intermediate_period_in_days		
                    , pa.start_dt_intermediate					
                    , pa.end_dt_intermediate 					
                    , pa.start_adv_week_intermediate			
                    , pa.end_adv_week_intermediate				
                    , pa.cnt_reagg_period_in_adv_weeks			
                    , pa.cnt_reagg_period_in_days				
                    , pa.start_dt_reagg 						
                    , pa.end_dt_reagg 							
                    , pa.start_adv_week_reagg					
                    , pa.end_adv_week_reagg						
                    , pa.cnt_baseline_adv_week					
                    , pa.loc_time_gaps_opening_days				
                    , pa.loc_time_gaps_closing_days				
                    , pa.wh_buying_price_add_period_in_days		
                    , pa.loc_store_sales_net_val_gt				
                    , pa.loc_store_sales_qty_gt					
                    , pa.adp_time_gap_in_days					
                    , pa.ctr_adv_week_start_weekday_id			
                    , pa.ctr_store_nbr							
                    , pa.ctr_ex_elvis_country_fg				
                    , pa.start_dt_base_metric_nf_fa 			
                    , pa.end_dt_base_metric_nf_fa 				
                    , pa.start_dt_deliv_qty 					
                    , pa.end_dt_deliv_qty 						
                    , pa.start_dt_stc_real_qty 					
                    , pa.end_dt_stc_real_qty 					
                    , pa.exec_pit_daily_run_fg					
                    , pa.exec_pit_weekly_run_fg					
                    , pa.exec_pit_dq_run_fg						
                    , pa.exec_pit_manual_run_fg 				
                    , pa.exec_pit_manual_country_lst 			
                    , pa.exec_pit_run_weekly_weekday			
                    , pa.exec_pit_cnt_initial_adv_weeks			
                    , pa.exec_pit_ab_parallel_execution	
                    , pa.exec_pit_sf_credit_timerange_in_days
                    , pa.default_pit_manual_run_fg
                    , pa.pit_max_data_history_in_days
                    , pa.pit_max_data_history_in_adv_week
                    , CASE WHEN 	
                            (
                                TRUE
                                AND pa.exec_pit_daily_run_fg 											= 1 
                                AND EXTRACT(DAYOFWEEK FROM SAFE.PARSE_DATE('%Y-%m-%d', '#RUNDAYID#')) 	= pa.exec_pit_run_weekly_weekday
                                AND SAFE.PARSE_DATE('%Y-%m-%d', '#RUNDAYID#')								= pa.next_run_dt_reagg
                            )
                            OR
                            (
                                TRUE
                                AND pa.exec_pit_weekly_run_fg 											= 1 
                                AND EXTRACT(DAYOFWEEK FROM SAFE.PARSE_DATE('%Y-%m-%d', '#RUNDAYID#')) 	= pa.exec_pit_run_weekly_weekday
                            )
                        THEN 1
                        ELSE 0
                        END											AS exec_client_fg	
                FROM p_lew_mart_pit.t_cntl_processing_param_normalized_1 pa
                WHERE TRUE
                ) pa
                ON TRUE
                    AND pa.client_id = rseq.client_id							
            ''';
            SELECT sqlstmt;
            -- Variable Substitution
            SET sqlstmt = REPLACE(sqlstmt, '#RUNIDSEQ#', run_id_seq);
            SET sqlstmt = REPLACE(sqlstmt, '#RUNTS#', run_ts);
            SET sqlstmt = REPLACE(sqlstmt, '#RUNDAYID#', run_day_id);
            
            SET sqlstmt = REPLACE(sqlstmt, '#PAPPLICATIONNAME#', UPPER(PAPPLICATIONNAME));
            SET sqlstmt = REPLACE(sqlstmt, '#RUNCLUSTER#', UPPER(strruncluster));
            SET sqlstmt = REPLACE(sqlstmt, '#QUERYTAG#', UPPER(PQUERYTAG));
            SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', strschema);	
            SET sqlstmt = REPLACE(sqlstmt, '#PLOADID#', strloadid);			
            
            BEGIN
                EXECUTE IMMEDIATE sqlstmt;
                EXECUTE IMMEDIATE sqlcommit;
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('P_STARTPROCESSING: [', sqlstmt, '] FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;
            END;

            SET OUT_PARAM = run_id_seq;
        END;
    END IF;
END;

 -- End of sp_StartLogging:p_lew_mart_pit.t_cntl_etl_logging_1
-- LOAD_ID :: 2022091215000000001
--CALL sp_StartLogging('${LOAD_ID}', 'PITonCloud','[12]',f_QueryTag('Initialize Logging','PITonCloud','[12]'),'P_LEW_MART_PIT_1')
--SELECT * FROM LDL_PRODUCTION.P_LEW_MART_PIT.V_CNTL_ETL_LOGGING_1 lg WHERE TRUE AND MOVING_RUN_ID_FROM_CURRENT = 0 ORDER BY RUN_ID_SEQ, RUN_TS;
--SELECT * FROM v_cntl_etl_logging_run_seq_1 WHERE TRUE AND MOVING_RUN_ID_FROM_CURRENT = 0 ORDER BY RUN_ID_SEQ, RUN_TS;
-- Check QH: SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));
