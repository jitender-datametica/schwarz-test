/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_CLIENT_STORAGE_TEST_RESULT_PARAMETER_LIST_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version 
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_CLIENT_STORAGE_TEST_RESULT_PARAMETER_LIST_2
(
     client_id
	,storage_test_exec_sid 
    ,orig_store_nr
	,reconstructin_week_list
	,excluded_week_list
)AS

SELECT 
       client_id
       ,storage_test_exec_sid
       ,orig_store_nr
       ,listagg('KW'|| SUBSTRING(d_reconstruction_week,5) || ' ' || SUBSTRING(d_reconstruction_week,1,4), ',' ) 
	            WITHIN GROUP (ORDER BY storage_test_exec_sid ,orig_store_nr,d_reconstruction_week)                 AS reconstructin_week_list
       ,listagg('KW'|| SUBSTRING(d_excluded_week,5) || ' ' || SUBSTRING(d_excluded_week,1,4), ',' ) 
	            WITHIN GROUP (ORDER BY storage_test_exec_sid ,orig_store_nr,d_excluded_week)                       AS excluded_week_list
FROM
(
    SELECT     
	     client_id
        ,storage_test_exec_sid 
	    ,storage_test_result_grp_sid
	    ,orig_store_nr
        ,MAX($5)  AS d_reconstruction_week
        ,MAX($6)  AS d_excluded_week
                 
    FROM
                    ( SELECT 
                         ext.client_id
                        ,tr.storage_test_exec_sid 
					    ,grp.storage_test_result_grp_sid
                        ,loc.src_orig_store_nr AS orig_store_nr
                        ,storage_test_param_type_cd
 					    ,test_week
                    FROM P_LEW_CORE.t_storage_test_parameter_2 tr
                    INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_EXECUTION_EXT_2 ext
                           ON tr.storage_test_exec_sid = ext.storage_test_exec_sid
                    INNER JOIN p_lew_core.t_storage_test_result_group_2 grp  
                            ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
					INNER JOIN p_lew_core.t_location_2  loc 
	                        ON loc.loc_sid = grp.loc_sid_store
                    WHERE storage_test_param_type_cd IN ('Reconstruction_Week', 'Excluded_Week')
                      AND UPPER(storage_test_result_grp_type_cd) = UPPER( 'Store')
   					GROUP BY 1,2,3,4,5,6
                    ) AS src
                    PIVOT (
                            MAX (test_week) 
                            FOR storage_test_param_type_cd IN ('Reconstruction_Week', 'Excluded_Week')
                        ) AS pvt1
    GROUP BY 1,2,3,4
)
GROUP BY 1,2,3
;