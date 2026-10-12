    /*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_HousekeepingCleanTables
#-------------------------------------------------------------------------------
# Describtion: 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-05-14 Nikolai Toknov       Initial version
#  1.0  2024-06-14 Nikolai Toknov       Optimization 
#  1.1  2025-06-11 Nikolai Toknov       Rename GetPrevParamsValue -> f_GetPrevParamsValue
#-------------------------------------------------------------------------------
*/

/* TO DO: update description
---------------------------------------------------------------------
PROCEDURE   :   sp_HousekeepingCleanTables(pSchema STRING, pTableName STRING )
Input       :   pClientId               DOUBLE 
                pAdwWeekCnt             DOUBLE 
                pHouskeepingMode        STRING  #Method for processing old records. Options: UPDATE, DELETE, NONE (there will be no changing of old rows)
                pApplicationName        STRING  #HOUSEKEEPING
                pPITLoggingLevel        DOUBLE  #0 - no logging, 1 - Start/End-Logging, 2 - Start/End-ModuleLogging, 3 - Start/End-ComponentLogging
                pLoadID                 DOUBLE      
Return      :   Error + Error Msg or in success case name of backuped table
Convert     :   None    
Description :   
Example     :   Call ldl_p_lew_mart_pit.sp_HousekeepingCleanTables(1,500,'UPDATE','HOUSEKEEPING',3,0);
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE ldl_p_lew_mart_pit.sp_housekeepingcleantables (
    pclientid FLOAT64
  , padwweekcnt FLOAT64
  , phouskeepingmode STRING
  , papplicationname STRING
  , ppitlogginglevel FLOAT64
  , ploadid FLOAT64
)
BEGIN
  DECLARE sqlstmthousekeeping STRING DEFAULT '';
  DECLARE strout STRING DEFAULT '';
  DECLARE strhouskeepingmode STRING DEFAULT '';
  DECLARE v_log_msg STRING DEFAULT '';
  DECLARE out_p STRING;
  DECLARE v_start_adv_week_id STRING;
  DECLARE v_adp_time_gap_in_days STRING;
  DECLARE v_end_dt_deliv_qty STRING;
  DECLARE v_start_dt_deliv_qty STRING;
  DECLARE v_start_dt_stc_real_qty STRING;
  DECLARE v_start_dt_base_metric_nf_fa STRING;
  DECLARE v_end_dt_base_metric_nf_fa STRING;
  DECLARE v_start_dt_pit_data STRING;
  DECLARE v_start_adv_week_id_prev STRING;

  IF (phouskeepingmode IS NULL OR phouskeepingmode = '') THEN 
      SET sqlstmthousekeeping = 'SELECT NULL'; 
  ELSE
      SET strhouskeepingmode = UPPER(phouskeepingmode);
      IF (strhouskeepingmode = 'UPDATE') THEN
          SET sqlstmthousekeeping = 'UPDATE #SF_SCHEMA#.#SF_TABLE_NAME# SET deleted_fg=1, dwh_updated_ts=CURRENT_TIMESTAMP() WHERE TRUE AND deleted_fg=0 AND #HOUSEKEEPING_PARAM#';
      ELSEIF (strhouskeepingmode = 'DELETE') THEN
          SET sqlstmthousekeeping = 'DELETE FROM #SF_SCHEMA#.#SF_TABLE_NAME# WHERE TRUE AND #HOUSEKEEPING_PARAM#';
      END IF;          
  END IF;
  
  IF (strhouskeepingmode = 'UPDATE' OR strhouskeepingmode = 'DELETE') THEN
  
      BEGIN
          SET (
              v_start_adv_week_id, 
              v_adp_time_gap_in_days, 
              v_end_dt_deliv_qty, 
              v_start_dt_deliv_qty, 
              v_start_dt_stc_real_qty, 
              v_start_dt_base_metric_nf_fa, 
              v_end_dt_base_metric_nf_fa, 
              v_start_dt_pit_data, 
              v_start_adv_week_id_prev
          ) = (
              SELECT AS STRUCT
                  CAST(ldl_p_lew_mart_pit.f_getadvweekid(_start_dt_pit_data, ctry.ctr_adv_week_start_weekday_id) AS STRING),
                  CAST(ldl_p_lew_mart_pit.f_getprevparamsvalue(CAST(pclientid AS INT64), 'adp_time_gap_in_days', 0) AS STRING),
                  CAST(ldl_p_lew_mart_pit.f_getprevparamsvalue(CAST(pclientid AS INT64), 'end_dt_deliv_qty', 0) AS STRING),
                  CAST(ldl_p_lew_mart_pit.f_getprevparamsvalue(CAST(pclientid AS INT64), 'start_dt_deliv_qty', 0) AS STRING),
                  CAST(ldl_p_lew_mart_pit.f_getprevparamsvalue(CAST(pclientid AS INT64), 'start_dt_stc_real_qty', 0) AS STRING),
                  CAST(ldl_p_lew_mart_pit.f_getprevparamsvalue(CAST(pclientid AS INT64), 'start_dt_base_metric_nf_fa', 0) AS STRING),
                  CAST(ldl_p_lew_mart_pit.f_getprevparamsvalue(CAST(pclientid AS INT64), 'end_dt_base_metric_nf_fa', 0) AS STRING),
                  CAST(DATE_ADD(_start_dt_pit_data, INTERVAL 1 DAY) AS STRING),
                  CAST(ldl_p_lew_mart_pit.f_getadvweekid(DATE_SUB(_start_dt_pit_data, INTERVAL 7 DAY), ctry.ctr_adv_week_start_weekday_id) AS STRING)
              FROM (
                  SELECT 
                      client_id,
                      country_iso_cd,
                      country_descr,
                      ctr_adv_week_start_weekday_id,
                      DATE_ADD(CAST(ldl_p_lew_mart_pit.f_getprevparamsvalue(CAST(pclientid AS INT64), 'end_dt_pit_data', 0) AS DATE), INTERVAL CAST(-(padwweekcnt * 7) + 1 AS INT64) DAY) AS _start_dt_pit_data
                  FROM ldl_p_lew_mart_pit.f_gettableadvweekstartdayid()
                  WHERE client_id = pclientid
              ) AS ctry
          );
      EXCEPTION WHEN ERROR THEN
          RAISE USING MESSAGE = CONCAT('Error fetching previous parameters: ', @@error.message);
      END;

      FOR res IN (
          SELECT 
              sf_schema,
              sf_table_name, 
              housekeeping_param
          FROM ldl_p_lew_mart_pit.t_cntl_housekeeping_param_2
          WHERE CURRENT_DATE() BETWEEN valid_from_dt AND valid_to_dt
            AND reject_fg = 0
            AND deleted_fg = 0
          ORDER BY RAND() 
      )
      DO
          SET strout = sqlstmthousekeeping;

          SET strout = REPLACE(strout, '#SF_SCHEMA#', LOWER(res.sf_schema));
          SET strout = REPLACE(strout, '#SF_TABLE_NAME#', LOWER(res.sf_table_name));
          SET strout = REPLACE(strout, '#HOUSEKEEPING_PARAM#', res.housekeeping_param);  
          
          SET strout = REPLACE(strout, '${CLIENT_ID}', CAST(CAST(pclientid AS INT64) AS STRING));
          SET strout = REPLACE(strout, '${START_DT_PIT_DATA}', v_start_dt_pit_data);
          SET strout = REPLACE(strout, '${START_ADV_WEEK_REAGG}', v_start_adv_week_id);            
          SET strout = REPLACE(strout, '${ADP_TIME_GAP_IN_DAYS}', v_adp_time_gap_in_days);
          SET strout = REPLACE(strout, '${END_DT_DELIV_QTY}', v_end_dt_deliv_qty);
          SET strout = REPLACE(strout, '${START_DT_DELIV_QTY}', v_start_dt_deliv_qty);
          SET strout = REPLACE(strout, '${START_DT_STC_REAL_QTY}', v_start_dt_stc_real_qty);
          SET strout = REPLACE(strout, '${START_DT_BASE_METRIC_NF_FA}', v_start_dt_base_metric_nf_fa);
          SET strout = REPLACE(strout, '${END_DT_BASE_METRIC_NF_FA}', v_end_dt_base_metric_nf_fa);
          SET strout = REPLACE(strout, '${START_ADV_WEEK_REAGG_PREV}', v_start_adv_week_id_prev);
          
          SET v_log_msg = CONCAT('Delete Existing Data ', LOWER(res.sf_schema), '.', LOWER(res.sf_table_name), ': ', strout);
          
          BEGIN
              CALL ldl_p_lew_mart_pit.sp_startcomponentlogging(
                  CAST(CAST(ploadid AS INT64) AS STRING),
                  papplicationname,
                  'HOUSEKEEPING',
                  v_log_msg,
                  CONCAT('[', CAST(CAST(pclientid AS INT64) AS STRING), ']'),
                  ldl_p_lew_mart_pit.f_querytag('HOUSEKEEPING', papplicationname, CONCAT('[', CAST(CAST(pclientid AS INT64) AS STRING), ']')),
                  'ldl_p_lew_mart_pit',
                  ppitlogginglevel
              );
          EXCEPTION WHEN ERROR THEN
              RAISE USING MESSAGE = CONCAT('sp_startcomponentlogging failed: ', @@error.message);
          END;
          
          BEGIN
              EXECUTE IMMEDIATE strout;
          EXCEPTION WHEN ERROR THEN
              RAISE USING MESSAGE = CONCAT('Execute DML failed [', strout, ']: ', @@error.message);
          END;

          BEGIN
              CALL ldl_p_lew_mart_pit.sp_endcomponentlogging(
                  papplicationname,
                  'HOUSEKEEPING',
                  v_log_msg,
                  CONCAT('[', CAST(CAST(pclientid AS INT64) AS STRING), ']'),
                  'ldl_p_lew_mart_pit',
                  0,
                  ppitlogginglevel
              );
          EXCEPTION WHEN ERROR THEN
              RAISE USING MESSAGE = CONCAT('sp_endcomponentlogging failed: ', @@error.message);
          END;
          
      END FOR;
      
      BEGIN
          CALL p_lew_mart_pit.sp_updateparam(
              CAST(CAST(pclientid AS INT64) AS STRING),
              'ldl_p_lew_mart_pit',
              'start_dt_pit_data',
              CAST(FORMAT_DATE('%Y%m%d', CAST(v_start_dt_pit_data AS DATE)) AS INT64),
              NULL,
              out_p
          );
      EXCEPTION WHEN ERROR THEN
          RAISE USING MESSAGE = CONCAT('sp_updateparam (start_dt_pit_data) failed: ', @@error.message);
      END;

      BEGIN
          CALL p_lew_mart_pit.sp_updateparam(
              CAST(CAST(pclientid AS INT64) AS STRING),
              'ldl_p_lew_mart_pit',
              'start_adv_week_id',
              CAST(v_start_adv_week_id AS INT64),
              NULL,
              out_p
          );
      EXCEPTION WHEN ERROR THEN
          RAISE USING MESSAGE = CONCAT('sp_updateparam (start_adv_week_id) failed: ', @@error.message);
      END;
  END IF;

  SELECT strout AS result;
    
END;