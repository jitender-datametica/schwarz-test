/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_PARAMETER_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version 
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_STORAGE_TEST_RESULT_PARAMETER_2
(
     storage_test_exec_sid 
    ,orig_store_nr
	,store_desc
    ,end_week 
	,end_week_display
    ,analysis_start_week
	,analysis_start_week_display
    ,analysis_end_week
	,analysis_end_week_display
    ,sales_area
    ,top_measure_1
    ,top_measure_2
    ,top_measure_3
    ,top_measure_4
    ,top_measure_5
    ,reconstruction_week
    ,excluded_week
	,excluded_week_header
	,test_week_cnt
	,reconstruction_week_status
	,kw_aggregate_until
)
AS 
WITH locp
 AS
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
    

FROM P_LEW_CORE.T_STORAGE_TEST_EXECUTION_2 ex
INNER JOIN P_LEW_CORE_AC.v_cal_week_2 cal 
        ON ex.end_week = cal.cy_week
INNER JOIN (

                    SELECT   storage_test_exec_sid 
                            , storage_test_result_grp_sid
                            ,MAX($3 )  AS d_analysis_start_week
                            ,MAX($4 )  AS d_analysis_end_week
                            ,MAX($5 )  AS d_sales_area
                            ,MAX($6 )  AS d_top_measure_1
                            ,MAX($7 )  AS d_top_measure_2
                            ,MAX($8 )  AS d_top_measure_3
                            ,MAX($9 )  AS d_top_measure_4
                            ,MAX($10 ) AS d_top_measure_5
                            ,MAX($11)  AS d_reconstruction_week
                            ,MAX($12)  AS d_excluded_week
                            FROM
                    ( SELECT storage_test_exec_sid 
                    ,grp.storage_test_result_grp_sid
                    ,storage_test_param_type_cd
                    ,storage_test_param_type_cd AS storage_test_param_type_cd1
                    ,param_txt
                    ,test_week
                    FROM P_LEW_CORE.t_storage_test_parameter_2 tr
                    INNER JOIN p_lew_core.t_storage_test_result_group_2 grp  
                      ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
                    WHERE storage_test_param_type_cd IN ('Analysis_Start_Week' , 'Analysis_End_Week' , 'Sales_Area' , 'Top_Measure_1'
                    , 'Top_Measure_2' , 'Top_Measure_3' , 'Top_Measure_4', 'Top_Measure_5', 'Reconstruction_Week', 'Excluded_Week')
                    AND UPPER(storage_test_result_grp_type_cd) = UPPER( 'Store')
                    GROUP BY 1,2,3,4,5,6
                    ) AS src
                    PIVOT (
    MAX (param_txt) 
    FOR storage_test_param_type_cd IN ('Analysis_Start_Week' , 'Analysis_End_Week' , 'Sales_Area' , 'Top_Measure_1'
, 'Top_Measure_2' , 'Top_Measure_3' , 'Top_Measure_4', 'Top_Measure_5')
) AS pvt1
PIVOT (
    MAX (test_week) 
    FOR storage_test_param_type_cd1 IN ('Reconstruction_Week', 'Excluded_Week')
) AS pvt1
                    
                    GROUP BY 1,2
                    
            ) pa
ON ex.storage_test_exec_sid = pa.storage_test_exec_sid
INNER JOIN (SELECT 
            tr.storage_test_exec_sid
            ,grp.storage_test_result_grp_sid
            ,loc.src_orig_store_nr AS orig_store_nr
            ,loc.loc_name          AS store_desc
                  FROM   p_lew_core.t_storage_test_result_2 tr
            INNER JOIN p_lew_core.t_storage_test_result_group_2 grp
                    ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid 
            INNER JOIN p_lew_core.t_storage_test_execution_2 ext
                    ON tr.storage_test_exec_sid = ext.storage_test_exec_sid
            INNER JOIN p_lew_core.t_location_2  loc 
                    ON ext.client_id = loc.client_id
                   AND  loc.loc_sid = grp.loc_sid_store
      WHERE  UPPER(storage_test_result_grp_type_cd) = UPPER( 'Store')
      GROUP BY 1,2,3,4) str
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
    ,'KW'||  ' ' || SUBSTRING(end_week,5) || ' ' || SUBSTRING(end_week,1,4)                       AS end_week_display
    ,analysis_start_week
    ,'KW'||  ' ' || SUBSTRING(analysis_start_week,5) || ' ' || SUBSTRING(analysis_start_week,1,4) AS analysis_start_week_display
    ,analysis_end_week
    ,'KW'||  ' ' || SUBSTRING(analysis_end_week,5) || ' ' || SUBSTRING(analysis_end_week,1,4)     AS analysis_end_week_display
    ,CASE WHEN LOWER(sales_area) <> LOWER('null') THEN sales_area || 'm²' 
          WHEN LOWER(sales_area) = LOWER('null') THEN '--' 
          ELSE sales_area  END                                                                     AS sales_area
    ,CASE WHEN top_measure_1 IS NULL THEN '--' ELSE top_measure_1 END AS top_measure_1
    ,CASE WHEN top_measure_2 IS NULL THEN '--' ELSE top_measure_2 END AS top_measure_2
    ,CASE WHEN top_measure_3 IS NULL THEN '--' ELSE top_measure_3 END AS top_measure_3
    ,CASE WHEN top_measure_4 IS NULL THEN '--' ELSE top_measure_4 END AS top_measure_4
    ,CASE WHEN top_measure_5 IS NULL THEN '--' ELSE top_measure_5 END AS top_measure_5
    ,reconstruction_week
    ,excluded_week
    ,CASE WHEN excluded_week IS NULL 
          THEN 'Keine' ELSE  'KW'||  ' ' || SUBSTRING(excluded_week,5) || ' ' || SUBSTRING(excluded_week,1,4) 
          END                                                                                                 AS excluded_week_header
    ,test_week_cnt
    ,reconstruction_week_status
    ,'KW'||  ' ' || SUBSTRING(kw_aggregate_until,5) || ' ' || SUBSTRING(kw_aggregate_until,1,4) AS kw_aggregate_until

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
	,cala.cy_week_seq
    , CASE WHEN analysis_end_week <= cal.cy_week_prev_1w THEN 1 ELSE 0 END open_fg
    , (cal.cy_week_seq - cala.cy_week_seq)::NUMBER(18,0) AS week_cnt
    , CASE WHEN open_fg = 0 THEN  week_cnt || ' ' || 'Testwoche(n)' ELSE 'abgeschlossen' END AS test_week_cnt
    , CASE WHEN  reconstruction_week IS NULL THEN 1 ELSE 0 END AS reconstruction_week_fg
    , CASE WHEN reconstruction_week_fg=1 
	       THEN 'Kein Umbau' ELSE 'KW'||  ' ' || SUBSTRING(reconstruction_week,5) || ' ' || SUBSTRING(reconstruction_week,1,4) 
		   END                                                                                                                   AS reconstruction_week_status
     ,CASE WHEN test_week_cnt = 'abgeschlossen' THEN analysis_end_week::NUMBER(18,0) ELSE  cal.cy_week_prev_1w::NUMBER(18,0) END AS kw_aggregate_until	
FROM locp
LEFT JOIN P_LEW_CORE_AC.v_cal_week_2 cal 
        ON locp.end_week = cal.cy_week
LEFT JOIN P_LEW_CORE_AC.v_cal_week_2 cala 
        ON locp.analysis_start_week = cala.cy_week
)pa

;