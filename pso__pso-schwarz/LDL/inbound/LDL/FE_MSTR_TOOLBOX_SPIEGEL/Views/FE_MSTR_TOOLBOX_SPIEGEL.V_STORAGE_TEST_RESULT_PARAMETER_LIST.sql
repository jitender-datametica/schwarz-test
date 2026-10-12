create or replace view LDL_PRODUCTION.FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_PARAMETER_LIST(
	STORAGE_TEST_EXEC_SID,
	ORIG_STORE_NR,
	RECONSTRUCTIN_WEEK_LIST,
	RECONSTRUCTIN_WEEK_LIST_ENG,
	EXCLUDED_WEEK_LIST,
	EXCLUDED_WEEK_LIST_ENG,
	RECONSTRUCTIN_WEEK_LIST_DISPLAY,
	RECONSTRUCTIN_WEEK_LIST_DISPLAY_ENG,
	EXCLUDED_WEEK_LIST_DISPLAY,
	EXCLUDED_WEEK_LIST_DISPLAY_ENG
) as
SELECT 
        storage_test_exec_sid
       ,orig_store_nr
       ,listagg('KW'||  ' ' || SUBSTRING(d_reconstruction_week,5) || ' ' || SUBSTRING(d_reconstruction_week,1,4), ',' ) 
	    WITHIN GROUP (ORDER BY storage_test_exec_sid ,orig_store_nr,d_reconstruction_week) AS RECONSTRUCTIN_WEEK_LIST
	   
	   ,listagg('CW'||  ' ' || SUBSTRING(d_reconstruction_week,5) || ' ' || SUBSTRING(d_reconstruction_week,1,4), ',' ) 
	     WITHIN GROUP (ORDER BY storage_test_exec_sid ,orig_store_nr,d_reconstruction_week) AS RECONSTRUCTIN_WEEK_LIST_ENG
       
	   ,listagg('KW'||  ' ' || SUBSTRING(d_excluded_week,5) || ' ' || SUBSTRING(d_excluded_week,1,4), ',' ) 
	     WITHIN GROUP (ORDER BY storage_test_exec_sid ,orig_store_nr,d_excluded_week) AS EXCLUDED_WEEK_LIST
       
	   ,listagg('CW'||  ' ' || SUBSTRING(d_excluded_week,5) || ' ' || SUBSTRING(d_excluded_week,1,4), ',' ) 
	     WITHIN GROUP (ORDER BY storage_test_exec_sid ,orig_store_nr,d_excluded_week) AS EXCLUDED_WEEK_LIST_ENG
	   
	   ,CASE 
		 WHEN reconstructin_week_list IS NULL OR reconstructin_week_list='' 
		 THEN 'Kein Umbau' 
		 ELSE reconstructin_week_list 
		 END AS RECONSTRUCTIN_WEEK_LIST_DISPLAY
	   
	   ,CASE 
		 WHEN RECONSTRUCTIN_WEEK_LIST_ENG IS NULL  OR RECONSTRUCTIN_WEEK_LIST_ENG='' 
		 THEN 'None' 
		 ELSE RECONSTRUCTIN_WEEK_LIST_ENG 
		 END AS RECONSTRUCTIN_WEEK_LIST_DISPLAY_ENG
	   
	   ,CASE 
		 WHEN excluded_week_list IS NULL OR excluded_week_list='' 
		 THEN 'Keine' 
		 ELSE excluded_week_list 
		 END AS EXCLUDED_WEEK_LIST_DISPLAY
	   
	   ,CASE 
		 WHEN excluded_week_list_eng IS NULL OR excluded_week_list_eng='' 
		 THEN 'None' 
		 ELSE excluded_week_list_eng 
		 END AS EXCLUDED_WEEK_LIST_DISPLAY_ENG
FROM
(
    SELECT     
         storage_test_exec_sid 
	    ,storage_test_result_grp_sid
	    ,orig_store_nr
        ,MAX($4)  AS d_reconstruction_week
        ,MAX($5)  AS d_excluded_week
                 
    FROM
    ( SELECT 
       tr.storage_test_exec_sid 
      ,grp.storage_test_result_grp_sid
      ,loc.src_orig_store_nr AS orig_store_nr
      ,storage_test_param_type_cd
      ,test_week
    FROM P_LEW_CORE.t_storage_test_parameter tr
    INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_EXECUTION_EXT ext
           ON tr.storage_test_exec_sid = ext.storage_test_exec_sid
    INNER JOIN p_lew_core.t_storage_test_result_group grp  
            ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
	INNER JOIN p_lew_core.t_location  loc 
	        ON loc.loc_sid = grp.loc_sid_store
    WHERE storage_test_param_type_cd IN ('Reconstruction_Week', 'Excluded_Week')
     AND UPPER(storage_test_result_grp_type_cd) = UPPER( 'Store')
    GROUP BY 1,2,3,4,5
    ) AS src
    PIVOT (
            MAX (test_week) 
            FOR storage_test_param_type_cd IN ('Reconstruction_Week', 'Excluded_Week')
        ) AS pvt1
    GROUP BY 1,2,3
)
GROUP BY 1,2
;
