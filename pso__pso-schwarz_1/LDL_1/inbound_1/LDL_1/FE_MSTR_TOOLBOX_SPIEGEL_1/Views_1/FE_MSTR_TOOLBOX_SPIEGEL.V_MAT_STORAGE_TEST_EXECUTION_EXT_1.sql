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

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_STORAGE_TEST_EXECUTION_EXT_1(
 client_id
,storage_test_exec_sid
,storage_test_exec_name
,end_week
,display_end_week
,dur_week_cnt
,min_training_day_cnt
,spread_pct
,test_name
,test_week_duration
,test_status
,filter_display_end_week
) AS 
SELECT DISTINCT
 ex.client_id
,ex.storage_test_exec_sid
,ex.storage_test_exec_name
,ex.end_week
--,cal.cy_week_prev_1w         AS display_end_week --end_week -1 =display_end_week
,'KW'||  ' ' || SUBSTRING(cal.cy_week_prev_1w,5) || ' ' || SUBSTRING(cal.cy_week_prev_1w,1,4)        AS display_end_week --end_week -1 =display_end_week
,ex.dur_week_cnt
,ex.min_training_day_cnt
,ex.spread_pct
,ct.src_country_lidl_cd || '_'|| ex.storage_test_exec_name || '_'|| 'KW'|| SUBSTRING(cal.cy_week_prev_1w,5) || '_' || SUBSTRING(cal.cy_week_prev_1w,1,4) AS test_name
,dur.test_week_duration
,CASE WHEN max_end <= cal.cy_week_prev_1w THEN 'abgeschlossen' ELSE 'laufend' END AS test_status
,'KW'|| SUBSTRING(cal.cy_week_prev_1w,5) || '_' || SUBSTRING(cal.cy_week_prev_1w,1,4) AS filter_display_end_week
FROM P_LEW_CORE.T_STORAGE_TEST_EXECUTION_1  ex
INNER JOIN P_LEW_CORE_AC.v_cal_week_1 cal 
        ON ex.end_week = cal.cy_week
INNER JOIN P_LEW_CORE.T_COUNTRY_1 ct
       ON ex.client_id = ct.country_sid
INNER JOIN 
         (SELECT storage_test_exec_sid
		 , max_end
         , CASE WHEN  min_start = max_start AND min_end = max_end THEN  -1 * (a.cy_week_seq - (mcal.cy_week_seq + 1))  || ' Wochen'
            ELSE 'Individuell festgelegt je Filiale, siehe Filial-Ergebnisse' END                             AS test_week_duration
         FROM 
         (SELECT storage_test_exec_sid
         --,orig_store_nr
         ,analysis_start_week
         ,analysis_end_week
         ,cy_week_seq
         , MIN(analysis_start_week) OVER (PARTITION BY storage_test_exec_sid) AS min_start
         , MIN(analysis_end_week)   OVER (PARTITION BY storage_test_exec_sid) AS min_end
         , MAX(analysis_start_week) OVER (PARTITION BY storage_test_exec_sid) AS max_start
         , MAX(analysis_end_week)   OVER (PARTITION BY storage_test_exec_sid) AS max_end
         FROM FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_PARAMETER_1 a
         INNER JOIN P_LEW_CORE_AC.v_cal_week_1 cal 
         ON a.analysis_start_week = cal.cy_week
         GROUP BY 1,2,3,4
         )a
        LEFT JOIN P_LEW_CORE_AC.v_cal_week_1 mcal 
        ON a.max_end = mcal.cy_week
        )dur
	  ON ex.storage_test_exec_sid = dur.storage_test_exec_sid
;