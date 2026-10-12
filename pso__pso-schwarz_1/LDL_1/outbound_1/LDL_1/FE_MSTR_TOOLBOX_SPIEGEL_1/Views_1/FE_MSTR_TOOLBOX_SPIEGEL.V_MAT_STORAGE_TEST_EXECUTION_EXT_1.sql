/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_EXECUTION_EXT_1
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version 
#----------------------------------------------------------------------------
*/


-- ,orig_store_nr
 CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_storage_test_execution_ext_1 (client_id,
storage_test_exec_sid, storage_test_exec_name, end_week, display_end_week, dur_week_cnt, min_training_day_cnt,
spread_pct, test_name, test_week_duration, test_status, filter_display_end_week) AS -- end_week -1 =display_end_week

SELECT DISTINCT EX.client_id,
 EX.storage_test_exec_sid,
 EX.storage_test_exec_name,
 EX.end_week -- ,cal.cy_week_prev_1w         AS display_end_week --end_week -1 =display_end_week
,
     'KW' || ' ' || SUBSTR(SUBSTR(CAST(CAL.cy_week_prev_1w AS STRING), 1, 39), 5) || ' ' || SUBSTR(SUBSTR(CAST(CAL.cy_week_prev_1w AS STRING)
    , 1, 39), 1, 4) AS display_end_week,
 EX.dur_week_cnt,
 EX.min_training_day_cnt,
 EX.spread_pct,
        CT.src_country_lidl_cd || '_' || EX.storage_test_exec_name || '_' || 'KW' || SUBSTR(SUBSTR(CAST(CAL.cy_week_prev_1w AS STRING)
      , 1, 39), 5) || '_' || SUBSTR(SUBSTR(CAST(CAL.cy_week_prev_1w AS STRING), 1, 39), 1, 4) AS test_name,
 dur.test_week_duration,
  CASE
  WHEN CAST(dur.max_end AS FLOAT64) <= CAL.cy_week_prev_1w
  THEN 'abgeschlossen'
  ELSE 'laufend'
  END AS test_status,
    'KW' || SUBSTR(SUBSTR(CAST(CAL.cy_week_prev_1w AS STRING), 1, 39), 5) || '_' || SUBSTR(SUBSTR(CAST(CAL.cy_week_prev_1w AS STRING)
    , 1, 39), 1, 4) AS filter_display_end_week
FROM ldl_p_lew_core.t_storage_test_execution_1 AS EX
 INNER JOIN ldl_p_lew_core_ac.v_cal_week_1 AS CAL ON EX.end_week = CAL.cy_week
 INNER JOIN ldl_p_lew_core.t_country_1 AS CT ON EX.client_id = CT.country_sid
 INNER JOIN (SELECT a.storage_test_exec_sid,
   a.max_end,
    CASE
    WHEN a.min_start = a.max_start AND a.min_end = a.max_end
    THEN CAST(- 1 * (a.cy_week_seq - (MCAL.cy_week_seq + 1)) AS STRING) || ' Wochen'
    ELSE 'Individuell festgelegt je Filiale, siehe Filial-Ergebnisse'
    END AS test_week_duration
  FROM (SELECT A.storage_test_exec_sid,
     A.analysis_start_week,
     A.analysis_end_week,
     CAL0.cy_week_seq,
     MIN(A.analysis_start_week) OVER (PARTITION BY CAST(A.storage_test_exec_sid AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS min_start,
     MIN(A.analysis_end_week) OVER (PARTITION BY CAST(A.storage_test_exec_sid AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS min_end,
     MAX(A.analysis_start_week) OVER (PARTITION BY CAST(A.storage_test_exec_sid AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_start,
     MAX(A.analysis_end_week) OVER (PARTITION BY CAST(A.storage_test_exec_sid AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_end
    FROM ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_parameter_1 AS A
     INNER JOIN ldl_p_lew_core_ac.v_cal_week_1 AS CAL0 ON CAST(A.analysis_start_week AS FLOAT64) = CAL0.cy_week
    GROUP BY A.storage_test_exec_sid,
     A.analysis_start_week,
     A.analysis_end_week,
     CAL0.cy_week_seq) AS a
   LEFT JOIN ldl_p_lew_core_ac.v_cal_week_1 AS MCAL ON CAST(a.max_end AS FLOAT64) = MCAL.cy_week) AS dur ON EX.storage_test_exec_sid
   = dur.storage_test_exec_sid;