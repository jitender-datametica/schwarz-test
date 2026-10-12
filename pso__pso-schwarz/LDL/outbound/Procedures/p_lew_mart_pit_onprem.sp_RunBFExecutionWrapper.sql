CREATE OR REPLACE PROCEDURE ldl_p_lew_mart_pit_onprem.sp_runbfexecutionwrapper (
    pclientid FLOAT64
  , pschema STRING
  , papplicationname STRING
  , pmodulename STRING
  , prunclusteringdesc STRING
  , pmaxruns FLOAT64
  , pschemacoreac STRING
  , pschemabilac STRING
)
BEGIN
-- ---------------------------------------------------------------------
-- PROCEDURE	:	sp_RunBFExecutionWrapper(pClient DOUBLE, pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pMaxRuns DOUBLE, pSchemaCoreAC STRING, pSchemaBilAC STRING)
-- Input		:   pClientId 				DOUBLE --> -1 ::= All Clients
-- 				pSchema 				STRING
-- 				pApplicationName 		STRING
-- 				pModuleName 			STRING 		
--     			pRunClusteringDesc    	STRING --> [0] running in sequence
--     			pMaxRuns				DOUBLE
-- Return		:	Error + Error Msg or in success case number of processed Tables
-- Convert		:	None    
-- Description	: 	Initialize Performance, there is a max Runs (:= 600) to prevent endless loops
-- 				57 Weeks (12 weeks * 26 Pit Countries := 116) 
--                 Logging is also enables  but must be enabled! 
-- Example		:	Call sp_RunBFExecutionWrapper('P_LEW_MART_PIT_ONPREM');
-- ------------------------------------------------------------------------
-- # History:
-- #  1.0  2021-07-01 Andreas Kurz    Initial version
-- 

  DECLARE _rowcnt INT64 DEFAULT 0;
  DECLARE icnt INT64 DEFAULT 0;
  DECLARE imaxruns INT64 DEFAULT 600;
  DECLARE strruncluster STRING DEFAULT '[0]';
  DECLARE strschemacoreac STRING DEFAULT 'ldl_p_lew_core_ac';
  DECLARE strschemabilac STRING DEFAULT 'ldl_p_lew_bil_ac';
  DECLARE sqlstmt STRING DEFAULT '';
  DECLARE out_p STRING;
  
  IF (pmaxruns IS NULL OR IS_NAN(pmaxruns)) THEN 
      SET pmaxruns = CAST(imaxruns AS FLOAT64); 
  ELSE
      SET imaxruns = CAST(pmaxruns AS INT64);
  END IF;
  
  IF (pclientid IS NULL OR IS_NAN(pclientid)) THEN 
      RAISE USING MESSAGE = 'Missing Client ID or not a number';
  END IF;       
  
  -- CHECK INPUT runcluster 
  IF (prunclusteringdesc IS NULL OR prunclusteringdesc = '') THEN 
      SET prunclusteringdesc = strruncluster; 
  ELSE
      SET strruncluster = UPPER(prunclusteringdesc);
  END IF;   

  -- CHECK INPUT pSchemaCoreAC 
  IF (pschemacoreac IS NULL OR pschemacoreac = '') THEN 
      SET pschemacoreac = strschemacoreac; 
  ELSE
      SET strschemacoreac = UPPER(pschemacoreac);
  END IF;           

  -- CHECK INPUT pSchemaBilAC 
  IF (pschemabilac IS NULL OR pschemabilac = '') THEN 
      SET pschemabilac = strschemabilac; 
  ELSE
      SET strschemabilac = UPPER(pschemabilac);
  END IF;   
  
  SET sqlstmt = """
          SELECT 
              fin.client_id
              , fin.execseqnum
              , fin.max_execseqnum
              , fin.start_adv_week_reagg  --4 
              , fin.end_adv_week_reagg   --5
              , CAST(fin.cal_dt_from AS STRING) AS cal_dt_from  --6
              , CAST(fin.cal_dt_to AS STRING)   AS cal_dt_to  --7
              , fin.adv_week_id_from  --8
              , fin.adv_week_id_to  --9
              , CONCAT('Exec Call: Client [' 
                  , CAST(fin.client_id AS STRING) 
                  , '] Step:' 
                  , CAST(fin.execseqnum AS STRING) 
                  , '/' , CAST(fin.max_execseqnum AS STRING) 
                  , ' EJR Date From:<' 
                  , CAST(fin.cal_dt_from AS STRING)  
                  , '>-<' 
                  , CAST(fin.cal_dt_to AS STRING) 
                  , '>-<' 
                  , CAST(fin.adv_week_id_to AS STRING) 
                  , '>' 
                  , ' on Schema CORE_AC: #PSCHEMACOREAC# and BIL_AC: #PSCHEMABILAC#')
                  AS  log_display_descr
           FROM ( 
              -- Outer layer: Apply the Window function safely AFTER the Group By is complete
              SELECT 
                  grp.client_id
                  , grp.execseqnum
                  , MAX(grp.execseqnum) OVER (PARTITION BY grp.client_id) AS max_execseqnum       
                  , grp.start_adv_week_reagg
                  , grp.end_adv_week_reagg
                  , grp.cal_dt_from
                  , grp.cal_dt_to
                  , grp.adv_week_id_from
                  , grp.adv_week_id_to
              FROM (
                  -- Inner layer: Calculate the Group By aggregations
                  SELECT
                      client_id
                      , CAST(FLOOR(qry_seq1_num)+1 AS INT64) AS execseqnum
                      , MIN(start_adv_week_reagg)   AS start_adv_week_reagg
                      , MAX(end_adv_week_reagg)     AS end_adv_week_reagg
                      , MIN(cal_dt)                 AS cal_dt_from
                      , MAX(cal_dt)                 AS cal_dt_to
                      , MIN(last_dt_of_adv_week_id) AS adv_week_id_from
                      , MAX(last_dt_of_adv_week_id) AS adv_week_id_to
                  FROM
                      (
                      SELECT
                            client_id
                          , cal_dt
                          , start_adv_week_reagg
                          , end_adv_week_reagg
                          , last_dt_of_adv_week_id
                          , COUNT(*) OVER (PARTITION BY client_id) AS num_days
                          , ((FLOOR(COUNT(*) OVER (PARTITION BY client_id) / CAST((nbr_of_adv_weeks_ejr*7) AS FLOAT64)) + 1) * ROW_NUMBER() OVER (PARTITION BY client_id ORDER BY cal_dt) - 1) / (COUNT(*) OVER (PARTITION BY client_id) + 1)
                                      AS qry_seq1_num                
                  
                      FROM
                          (
                          SELECT
                                awk.client_id
                              , cal.cal_dt
                              , MIN(pa.start_adv_week_reagg) AS start_adv_week_reagg
                              , MAX(pa.end_adv_week_reagg)   AS end_adv_week_reagg
                              , MAX(pa.nbr_of_adv_weeks_ejr) AS nbr_of_adv_weeks_ejr                    
                              , MAX(CASE WHEN cal.cal_dt = DATE_ADD(awk.adv_week_end_dt, INTERVAL CAST(pa.end_dt_base_metric_nf_fa AS INT64) DAY) THEN awk.adv_week_id END) AS last_dt_of_adv_week_id
                          FROM (
                                      SELECT client_id, adv_week_id, adv_week_start_dt, adv_week_end_dt, dwh_updated 
                                      FROM  #PSCHEMA#.t_advert_week
                                      WHERE TRUE AND (  #PCLIENTID#  = -1 OR client_id =  #PCLIENTID#  )
                                      GROUP BY 1,2,3,4,5 
                                      
                                      QUALIFY ROW_NUMBER() OVER(PARTITION BY client_id, adv_week_id ORDER BY dwh_updated DESC) = 1
                                  ) AS awk
                      
                          INNER JOIN #PSCHEMA#.t_pit_scope_country_param_normalized AS pa
                                  ON  awk.client_id = pa.client_id
                              AND awk.adv_week_id BETWEEN pa.start_adv_week_reagg AND pa.end_adv_week_reagg
                      
                          INNER JOIN #PSCHEMACOREAC#.v_cal_calendarday AS cal
                                  ON  cal.cal_dt BETWEEN DATE_ADD(awk.adv_week_start_dt, INTERVAL CAST(pa.start_dt_base_metric_nf_fa AS INT64) DAY)
                                                     AND DATE_ADD(awk.adv_week_end_dt, INTERVAL CAST(pa.end_dt_base_metric_nf_fa AS INT64) DAY)
                          GROUP BY 1,2
                          ) AS a
                      WHERE TRUE AND (  #PCLIENTID#  = -1 OR a.client_id =  #PCLIENTID#  ) ORDER BY a.cal_dt 
                      ) AS b
                  GROUP BY client_id, execseqnum
              ) AS grp
          ) fin
          ORDER BY fin.client_id, fin.execseqnum
      """;
      
  -- Variable Substitution
  SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', LOWER(pschema));
  SET sqlstmt = REPLACE(sqlstmt, '#PCLIENTID#', CAST(pclientid AS STRING));
  SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMACOREAC#', LOWER(strschemacoreac));        
  SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMABILAC#', LOWER(strschemabilac));  

  -- Retrieve from all uses tables
  BEGIN
      EXECUTE IMMEDIATE 'CREATE TEMP TABLE _temp_results AS ' || sqlstmt;
  EXCEPTION WHEN ERROR THEN
      RAISE USING MESSAGE = CONCAT('P_RUNBFEXECTUTIONWRAPPER: [', sqlstmt, '] MESSAGE: ', @@error.message);
  END;

  -- Loop all results
  SET _rowcnt = (SELECT COUNT(*) FROM _temp_results);
  
  FOR res IN (SELECT * FROM _temp_results)
  DO
      IF icnt < imaxruns THEN
  
         BEGIN
             CALL ldl_p_lew_mart_pit_onprem.sp_startcomponentlogging(
                 papplicationname, 
                 pmodulename, 
                 res.
                 log_display_descr, 
                 strruncluster, 
                 ldl_p_lew_mart_pit_onprem.querytag(papplicationname, pmodulename, NULL),out_p
             );
         EXCEPTION WHEN ERROR THEN
             RAISE USING MESSAGE = CONCAT('P_RUNBFEXECTUTIONWRAPPER_LogStart MESSAGE: ', @@error.message);
         END;

         BEGIN
             CALL p_lew_mart_pit_onprem.sp_runbfexecutionextract(
                 res.client_id, 
                 LOWER(pschema), 
                 CAST(res.cal_dt_from AS STRING), 
                 CAST(res.cal_dt_to AS STRING), 
                 res.start_adv_week_reagg, 
                 res.end_adv_week_reagg, 
                 UPPER(papplicationname), 
                 UPPER(pmodulename), 
                 strruncluster, 
                 LOWER(strschemacoreac), 
                 LOWER(strschemabilac),
                 out_p
             );
         EXCEPTION WHEN ERROR THEN
             RAISE USING MESSAGE = CONCAT('P_RUNSEARCHOPTIMIZATION_Extract MESSAGE: ', @@error.message);
         END;

         BEGIN
             CALL p_lew_mart_pit_onprem.sp_runbfexecutionupdate(
                 res.client_id, 
                 LOWER(pschema), 
                 res.adv_week_id_from, 
                 res.adv_week_id_to,
                 out_p
             );
         EXCEPTION WHEN ERROR THEN
             RAISE USING MESSAGE = CONCAT('P_RUNSEARCHOPTIMIZATION_Extract MESSAGE: ', @@error.message);
         END;
          
         BEGIN
             CALL ldl_p_lew_mart_pit_onprem.sp_endcomponentlogging(
                 papplicationname, 
                 pmodulename, 
                 res.log_display_descr, 
                 strruncluster, 
                 1,
                 out_p
             );
         EXCEPTION WHEN ERROR THEN
             RAISE USING MESSAGE = CONCAT('P_RUNBFEXECTUTIONWRAPPER_LogEnd MESSAGE: ', @@error.message);
         END;
          
         SET icnt = icnt + 1;
          
      END IF;
  END FOR;
  
  DROP TABLE IF EXISTS _temp_results;

  SELECT CAST(_rowcnt AS STRING) AS result;            
END;