/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for fe_mstr_toolbox_spiegel.v_mat_storage_test_result_parameter
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version 
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_storage_test_result_parameter
AS 
WITH locp AS
 (SELECT 
     ex.storage_test_exec_sid 
    ,str.orig_store_nr  
    ,str.store_desc
    ,ex.end_week
    ,cal.cy_week_prev_1w
    ,MAX(pa.d_analysis_start_week )             AS analysis_start_week
    ,MAX(pa.d_analysis_end_week )               AS analysis_end_week
    ,MAX(pa.d_sales_area        )               AS sales_area       
    ,MAX(pa.d_top_measure_1     )               AS top_measure_1  
    ,MAX(pa.d_top_measure_2     )               AS top_measure_2  
    ,MAX(pa.d_top_measure_3     )               AS top_measure_3  
    ,MAX(pa.d_top_measure_4     )               AS top_measure_4  
    ,MAX(pa.d_top_measure_5     )               AS top_measure_5  
    ,MAX(pa.d_reconstruction_week)              AS reconstruction_week
    ,MAX(pa.d_excluded_week)                    AS excluded_week      

FROM ldl_p_lew_core.t_storage_test_execution ex
INNER JOIN ldl_p_lew_core_ac.v_cal_week cal 
        -- Cast added here for safety
        ON CAST(ex.end_week AS INT64) = CAST(cal.cy_week AS INT64)
INNER JOIN (
        SELECT tr.storage_test_exec_sid 
              ,grp.storage_test_result_grp_sid
              ,MAX(CASE WHEN storage_test_param_type_cd = 'Analysis_Start_Week' THEN param_txt END) AS d_analysis_start_week
              ,MAX(CASE WHEN storage_test_param_type_cd = 'Analysis_End_Week'   THEN param_txt END) AS d_analysis_end_week
              ,MAX(CASE WHEN storage_test_param_type_cd = 'Sales_Area'          THEN param_txt END) AS d_sales_area
              ,MAX(CASE WHEN storage_test_param_type_cd = 'Top_Measure_1'       THEN param_txt END) AS d_top_measure_1
              ,MAX(CASE WHEN storage_test_param_type_cd = 'Top_Measure_2'       THEN param_txt END) AS d_top_measure_2
              ,MAX(CASE WHEN storage_test_param_type_cd = 'Top_Measure_3'       THEN param_txt END) AS d_top_measure_3
              ,MAX(CASE WHEN storage_test_param_type_cd = 'Top_Measure_4'       THEN param_txt END) AS d_top_measure_4
              ,MAX(CASE WHEN storage_test_param_type_cd = 'Top_Measure_5'       THEN param_txt END) AS d_top_measure_5
              ,MAX(CASE WHEN storage_test_param_type_cd = 'Reconstruction_Week' THEN test_week END) AS d_reconstruction_week
              ,MAX(CASE WHEN storage_test_param_type_cd = 'Excluded_Week'       THEN test_week END) AS d_excluded_week
        FROM ldl_p_lew_core.t_storage_test_parameter tr
        INNER JOIN ldl_p_lew_core.t_storage_test_result_group grp  
                ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
        WHERE storage_test_param_type_cd IN (
            'Analysis_Start_Week', 'Analysis_End_Week', 'Sales_Area', 'Top_Measure_1', 
            'Top_Measure_2', 'Top_Measure_3', 'Top_Measure_4', 'Top_Measure_5', 
            'Reconstruction_Week', 'Excluded_Week'
        )
        AND UPPER(storage_test_result_grp_type_cd) = 'STORE'
        GROUP BY 1, 2
) pa
ON ex.storage_test_exec_sid = pa.storage_test_exec_sid
INNER JOIN (
      SELECT tr.storage_test_exec_sid
            ,grp.storage_test_result_grp_sid
            ,loc.src_orig_store_nr AS orig_store_nr
            ,loc.loc_name          AS store_desc
      FROM ldl_p_lew_core.t_storage_test_result tr
      INNER JOIN ldl_p_lew_core.t_storage_test_result_group grp
              ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid 
      INNER JOIN ldl_p_lew_core.t_storage_test_execution ext
              ON tr.storage_test_exec_sid = ext.storage_test_exec_sid
      INNER JOIN ldl_p_lew_core.t_location  loc 
              ON ext.client_id = loc.client_id
             AND loc.loc_sid = grp.loc_sid_store
      WHERE UPPER(storage_test_result_grp_type_cd) = UPPER('Store')
      GROUP BY 1,2,3,4
) str
ON pa.storage_test_exec_sid = str.storage_test_exec_sid
AND pa.storage_test_result_grp_sid = str.storage_test_result_grp_sid
GROUP BY 
     ex.storage_test_exec_sid 
    ,str.orig_store_nr  
    ,str.store_desc
    ,ex.end_week
    ,cal.cy_week_prev_1w
)
SELECT  
     storage_test_exec_sid 
    ,orig_store_nr
    ,store_desc
    ,end_week 
    ,'KW'||  ' ' || SUBSTR(CAST(end_week AS STRING),5) || ' ' || SUBSTR(CAST(end_week AS STRING),1,4) AS end_week_display
    ,analysis_start_week
    ,'KW'||  ' ' || SUBSTR(CAST(analysis_start_week AS STRING),5) || ' ' || SUBSTR(CAST(analysis_start_week AS STRING),1,4) AS analysis_start_week_display
    ,analysis_end_week
    ,'KW'||  ' ' || SUBSTR(CAST(analysis_end_week AS STRING),5) || ' ' || SUBSTR(CAST(analysis_end_week AS STRING),1,4) AS analysis_end_week_display
    ,CASE WHEN LOWER(CAST(sales_area AS STRING)) <> 'null' THEN CAST(sales_area AS STRING) || 'm²' 
          WHEN LOWER(CAST(sales_area AS STRING)) = 'null' THEN '--' 
          ELSE CAST(sales_area AS STRING) END AS sales_area
    ,CASE WHEN top_measure_1 IS NULL THEN '--' ELSE CAST(top_measure_1 AS STRING) END AS top_measure_1
    ,CASE WHEN top_measure_2 IS NULL THEN '--' ELSE CAST(top_measure_2 AS STRING) END AS top_measure_2
    ,CASE WHEN top_measure_3 IS NULL THEN '--' ELSE CAST(top_measure_3 AS STRING) END AS top_measure_3
    ,CASE WHEN top_measure_4 IS NULL THEN '--' ELSE CAST(top_measure_4 AS STRING) END AS top_measure_4
    ,CASE WHEN top_measure_5 IS NULL THEN '--' ELSE CAST(top_measure_5 AS STRING) END AS top_measure_5
    ,reconstruction_week
    ,excluded_week
    ,CASE WHEN excluded_week IS NULL 
          THEN 'Keine' ELSE 'KW'||  ' ' || SUBSTR(CAST(excluded_week AS STRING),5) || ' ' || SUBSTR(CAST(excluded_week AS STRING),1,4) 
          END AS excluded_week_header
    ,test_week_cnt
    ,reconstruction_week_status
    ,'KW'||  ' ' || SUBSTR(CAST(kw_aggregate_until AS STRING),5) || ' ' || SUBSTR(CAST(kw_aggregate_until AS STRING),1,4) AS kw_aggregate_until

FROM
(
SELECT 
     storage_test_exec_sid 
    ,orig_store_nr  
    ,store_desc
    ,end_week
    ,locp.cy_week_prev_1w
    ,analysis_start_week
    ,analysis_end_week
    ,sales_area       
    ,top_measure_1  
    ,top_measure_2  
    ,top_measure_3  
    ,top_measure_4  
    ,top_measure_5  
    ,reconstruction_week
    ,excluded_week
    ,cal.cy_week_seq
    ,cala.cy_week_seq AS cala_cy_week_seq
    
    , CASE WHEN CAST(analysis_end_week AS INT64) <= CAST(cal.cy_week_prev_1w AS INT64) THEN 1 ELSE 0 END AS open_fg
    , CAST((cal.cy_week_seq - cala.cy_week_seq) AS INT64) AS week_cnt
    , CASE WHEN (CASE WHEN CAST(analysis_end_week AS INT64) <= CAST(cal.cy_week_prev_1w AS INT64) THEN 1 ELSE 0 END) = 0 
           THEN CAST((cal.cy_week_seq - cala.cy_week_seq) AS STRING) || ' ' || 'Testwoche(n)' 
           ELSE 'abgeschlossen' END AS test_week_cnt
    , CASE WHEN reconstruction_week IS NULL THEN 1 ELSE 0 END AS reconstruction_week_fg
    , CASE WHEN (CASE WHEN reconstruction_week IS NULL THEN 1 ELSE 0 END) = 1 
           THEN 'Kein Umbau' ELSE 'KW'||  ' ' || SUBSTR(CAST(reconstruction_week AS STRING),5) || ' ' || SUBSTR(CAST(reconstruction_week AS STRING),1,4) 
           END AS reconstruction_week_status
     ,CASE WHEN (CASE WHEN (CASE WHEN CAST(analysis_end_week AS INT64) <= CAST(cal.cy_week_prev_1w AS INT64) THEN 1 ELSE 0 END) = 0 
                      THEN CAST((cal.cy_week_seq - cala.cy_week_seq) AS STRING) || ' ' || 'Testwoche(n)' 
                      ELSE 'abgeschlossen' END) = 'abgeschlossen' 
           THEN CAST(analysis_end_week AS INT64) ELSE CAST(locp.cy_week_prev_1w AS INT64) END AS kw_aggregate_until	
FROM locp
LEFT JOIN ldl_p_lew_core_ac.v_cal_week cal 
        ON CAST(locp.end_week AS INT64) = CAST(cal.cy_week AS INT64)
LEFT JOIN ldl_p_lew_core_ac.v_cal_week cala 
        ON CAST(locp.analysis_start_week AS INT64) = CAST(cala.cy_week AS INT64)
)pa
;