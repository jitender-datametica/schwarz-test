/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_CLIENT_STORAGE_TEST_RESULT_PARAMETER_LIST
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version 
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_client_storage_test_result_parameter_list
(
     client_id
    ,storage_test_exec_sid 
    ,orig_store_nr
    ,reconstructin_week_list
    ,excluded_week_list
) AS
SELECT 
       client_id
       ,storage_test_exec_sid
       ,orig_store_nr
       -- Converted LISTAGG to STRING_AGG and || to CONCAT
       ,STRING_AGG(CONCAT('KW', SUBSTR(CAST(d_reconstruction_week AS STRING), 5), ' ', SUBSTR(CAST(d_reconstruction_week AS STRING), 1, 4)), ',' 
                   ORDER BY storage_test_exec_sid, orig_store_nr, d_reconstruction_week) AS reconstructin_week_list
       ,STRING_AGG(CONCAT('KW', SUBSTR(CAST(d_excluded_week AS STRING), 5), ' ', SUBSTR(CAST(d_excluded_week AS STRING), 1, 4)), ',' 
                   ORDER BY storage_test_exec_sid, orig_store_nr, d_excluded_week) AS excluded_week_list
FROM
(
    SELECT     
         client_id
        ,storage_test_exec_sid 
        ,storage_test_result_grp_sid
        ,orig_store_nr
        -- Replaced $5 and $6 with the named PIVOT outputs
        ,MAX(Reconstruction_Week) AS d_reconstruction_week
        ,MAX(Excluded_Week)       AS d_excluded_week
                 
    FROM
    ( 
        SELECT * FROM ( 
            SELECT 
                 ext.client_id
                ,tr.storage_test_exec_sid 
                ,grp.storage_test_result_grp_sid
                ,loc.src_orig_store_nr AS orig_store_nr
                ,storage_test_param_type_cd
                ,test_week
            FROM ldl_p_lew_core.t_storage_test_parameter tr
            INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_storage_test_execution_ext ext
                   ON tr.storage_test_exec_sid = ext.storage_test_exec_sid
            INNER JOIN ldl_p_lew_core.t_storage_test_result_group grp  
                    ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
            INNER JOIN ldl_p_lew_core.t_location loc 
                    ON loc.loc_sid = grp.loc_sid_store
            WHERE storage_test_param_type_cd IN ('Reconstruction_Week', 'Excluded_Week')
              AND UPPER(storage_test_result_grp_type_cd) = UPPER('Store')
            GROUP BY 1,2,3,4,5,6
        )
        PIVOT (
            MAX(test_week) 
            FOR storage_test_param_type_cd IN ('Reconstruction_Week', 'Excluded_Week')
        )
    )
    GROUP BY 1,2,3,4
)
GROUP BY 1,2,3;