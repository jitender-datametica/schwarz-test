CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_storage_test_result_parameter_graph_2 AS
SELECT 
        exrec.storage_test_exec_sid
       ,exrec.orig_store_nr
       ,exrec.d_reconstruction_week AS reconstructin_week_list_graph
       ,exrec.d_exluded_week        AS excluded_week_list_graph
       ,cmpwk.test_week             AS test_week_comp
       FROM
        (
            SELECT     
              storage_test_exec_sid 
             ,storage_test_result_grp_sid
             ,orig_store_nr
             ,MAX(d_reconstruction_week)  AS d_reconstruction_week
             ,MAX(d_exluded_week)         AS d_exluded_week
                        
            FROM
                ( SELECT 
                    tr.storage_test_exec_sid 
                    ,grp.storage_test_result_grp_sid
                    ,loc.src_orig_store_nr AS orig_store_nr
                    ,MAX(CASE WHEN storage_test_param_type_cd = 'Reconstruction_Week' THEN test_week END) AS d_reconstruction_week
                    ,MAX(CASE WHEN storage_test_param_type_cd = 'Excluded_Week'       THEN test_week END) AS d_exluded_week
                FROM ldl_p_lew_core.t_storage_test_parameter_2 tr
                INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_storage_test_execution_ext_2 ext
                    ON tr.storage_test_exec_sid = ext.storage_test_exec_sid
                INNER JOIN ldl_p_lew_core.t_storage_test_result_group_2 grp  
                        ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
                INNER JOIN ldl_p_lew_core.t_location_2  loc 
                        ON loc.loc_sid = grp.loc_sid_store
                WHERE storage_test_param_type_cd IN ('Reconstruction_Week', 'Excluded_Week')
                AND UPPER(storage_test_result_grp_type_cd) = UPPER('Store')
                GROUP BY 1,2,3
                ) AS src
            GROUP BY 1,2,3
        ) exrec
       LEFT JOIN
        (
            SELECT       
              src.storage_test_exec_sid
             ,src.orig_store_nr
             ,src.test_week
            FROM
            ( 
            SELECT DISTINCT 
                storage_test_exec_sid 
                ,orig_store_nr
                ,tr.storage_test_result_grp_sid 
                ,storage_test_result_grp_type_cd 
                ,test_week
            FROM ldl_p_lew_core.t_storage_test_result_2 tr
            INNER JOIN 
            (
             SELECT  
                 storage_test_result_grp_sid
                ,loc.src_orig_store_nr AS orig_store_nr
                ,storage_test_result_grp_type_cd 
                ,test_week
             FROM ldl_p_lew_core.t_storage_test_result_group_2 grp
             INNER JOIN ldl_p_lew_core.t_location_2  loc 
               ON loc.loc_sid = grp.loc_sid_store
             WHERE UPPER(storage_test_result_grp_type_cd) = UPPER('Store')
               AND CAST(test_week AS INT64) <> -1 
            ) grp 
            ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
    
            ) AS src
        
            INNER JOIN
            (
                SELECT 
                    storage_test_exec_sid
                    ,orig_store_nr
                    , MAX( CAST(reconstruction_week AS INT64) ) OVER (PARTITION BY storage_test_exec_sid,orig_store_nr) AS max_reconstruction_week
                    , analysis_start_week 
                    , excluded_week_header
                FROM ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_parameter_2
            )AS ps
            ON src.storage_test_exec_sid = ps.storage_test_exec_sid
            AND src.orig_store_nr = ps.orig_store_nr
            AND CAST(src.test_week AS INT64) > ps.max_reconstruction_week 
            AND CAST(src.test_week AS INT64) < CAST(ps.analysis_start_week AS INT64)
        
        )cmpwk
        ON exrec.storage_test_exec_sid= cmpwk.storage_test_exec_sid
        AND exrec.orig_store_nr= cmpwk.orig_store_nr

GROUP BY 1,2,3,4,5
;