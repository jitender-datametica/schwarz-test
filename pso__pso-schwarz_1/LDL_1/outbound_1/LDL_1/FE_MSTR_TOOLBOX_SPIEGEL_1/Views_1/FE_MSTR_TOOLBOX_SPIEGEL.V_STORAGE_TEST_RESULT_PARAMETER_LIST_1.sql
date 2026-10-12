/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for fe_mstr_toolbox_spiegel.v_storage_test_result_parameter_list_1
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version 
#  1.0  20.05.2024    Simeon Nikolaev          New colums -  "_ENG"
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_parameter_list_1 AS
SELECT 
        storage_test_exec_sid
       ,orig_store_nr
       ,STRING_AGG('KW'||  ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),5) || ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),1,4), ',' ORDER BY d_reconstruction_week) AS reconstructin_week_list
       
       ,STRING_AGG('CW'||  ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),5) || ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),1,4), ',' ORDER BY d_reconstruction_week) AS reconstructin_week_list_eng
       
       ,STRING_AGG('KW'||  ' ' || SUBSTR(CAST(d_excluded_week AS STRING),5) || ' ' || SUBSTR(CAST(d_excluded_week AS STRING),1,4), ',' ORDER BY d_excluded_week) AS excluded_week_list
       
       ,STRING_AGG('CW'||  ' ' || SUBSTR(CAST(d_excluded_week AS STRING),5) || ' ' || SUBSTR(CAST(d_excluded_week AS STRING),1,4), ',' ORDER BY d_excluded_week) AS excluded_week_list_eng
       
       ,CASE 
         WHEN STRING_AGG('KW'||  ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),5) || ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),1,4), ',' ORDER BY d_reconstruction_week) IS NULL OR STRING_AGG('KW'||  ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),5) || ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),1,4), ',' ORDER BY d_reconstruction_week)='' 
         THEN 'Kein Umbau' 
         ELSE STRING_AGG('KW'||  ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),5) || ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),1,4), ',' ORDER BY d_reconstruction_week) 
         END AS reconstructin_week_list_display
       
       ,CASE 
         WHEN STRING_AGG('CW'||  ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),5) || ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),1,4), ',' ORDER BY d_reconstruction_week) IS NULL  OR STRING_AGG('CW'||  ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),5) || ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),1,4), ',' ORDER BY d_reconstruction_week)='' 
         THEN 'None' 
         ELSE STRING_AGG('CW'||  ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),5) || ' ' || SUBSTR(CAST(d_reconstruction_week AS STRING),1,4), ',' ORDER BY d_reconstruction_week) 
         END AS reconstructin_week_list_display_eng
       
       ,CASE 
         WHEN STRING_AGG('KW'||  ' ' || SUBSTR(CAST(d_excluded_week AS STRING),5) || ' ' || SUBSTR(CAST(d_excluded_week AS STRING),1,4), ',' ORDER BY d_excluded_week) IS NULL OR STRING_AGG('KW'||  ' ' || SUBSTR(CAST(d_excluded_week AS STRING),5) || ' ' || SUBSTR(CAST(d_excluded_week AS STRING),1,4), ',' ORDER BY d_excluded_week)='' 
         THEN 'Keine' 
         ELSE STRING_AGG('KW'||  ' ' || SUBSTR(CAST(d_excluded_week AS STRING),5) || ' ' || SUBSTR(CAST(d_excluded_week AS STRING),1,4), ',' ORDER BY d_excluded_week) 
         END AS excluded_week_list_display
       
       ,CASE 
         WHEN STRING_AGG('CW'||  ' ' || SUBSTR(CAST(d_excluded_week AS STRING),5) || ' ' || SUBSTR(CAST(d_excluded_week AS STRING),1,4), ',' ORDER BY d_excluded_week) IS NULL OR STRING_AGG('CW'||  ' ' || SUBSTR(CAST(d_excluded_week AS STRING),5) || ' ' || SUBSTR(CAST(d_excluded_week AS STRING),1,4), ',' ORDER BY d_excluded_week)='' 
         THEN 'None' 
         ELSE STRING_AGG('CW'||  ' ' || SUBSTR(CAST(d_excluded_week AS STRING),5) || ' ' || SUBSTR(CAST(d_excluded_week AS STRING),1,4), ',' ORDER BY d_excluded_week) 
         END AS excluded_week_list_display_eng
FROM
(
    SELECT     
         storage_test_exec_sid 
        ,storage_test_result_grp_sid
        ,orig_store_nr
        ,MAX(d_reconstruction_week)  AS d_reconstruction_week
        ,MAX(d_excluded_week)  AS d_excluded_week
                 
    FROM
    ( SELECT 
       tr.storage_test_exec_sid 
      ,grp.storage_test_result_grp_sid
      ,loc.src_orig_store_nr AS orig_store_nr
      ,MAX(CASE WHEN storage_test_param_type_cd = 'Reconstruction_Week' THEN test_week END) AS d_reconstruction_week
      ,MAX(CASE WHEN storage_test_param_type_cd = 'Excluded_Week'       THEN test_week END) AS d_excluded_week
    FROM ldl_p_lew_core.t_storage_test_parameter_1 tr
    INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_storage_test_execution_ext_1 ext
           ON tr.storage_test_exec_sid = ext.storage_test_exec_sid
    INNER JOIN ldl_p_lew_core.t_storage_test_result_group_1 grp  
            ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
    INNER JOIN ldl_p_lew_core.t_location_1  loc 
            ON loc.loc_sid = grp.loc_sid_store
    WHERE storage_test_param_type_cd IN ('Reconstruction_Week', 'Excluded_Week')
     AND UPPER(storage_test_result_grp_type_cd) = UPPER('Store')
    GROUP BY 1,2,3
    ) AS src
    GROUP BY 1,2,3
)
GROUP BY 1,2
;