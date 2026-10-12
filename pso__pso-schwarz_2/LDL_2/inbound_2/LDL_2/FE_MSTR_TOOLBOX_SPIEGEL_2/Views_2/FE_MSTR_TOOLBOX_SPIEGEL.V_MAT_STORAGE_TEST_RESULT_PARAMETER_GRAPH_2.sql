CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_STORAGE_TEST_RESULT_PARAMETER_GRAPH_2(
	STORAGE_TEST_EXEC_SID
	,ORIG_STORE_NR
	,RECONSTRUCTIN_WEEK_LIST_GRAPH
	,EXCLUDED_WEEK_LIST_GRAPH
	,TEST_WEEK_COMP
) AS

SELECT 
        EXREC.STORAGE_TEST_EXEC_SID
       ,EXREC.ORIG_STORE_NR
       ,EXREC.D_RECONSTRUCTION_WEEK AS RECONSTRUCTIN_WEEK_LIST_GRAPH
       ,EXREC.D_EXLUDED_WEEK        AS EXCLUDED_WEEK_LIST_GRAPH
	   ,CMPWK.TEST_WEEK
       FROM
		(
			SELECT     
			  STORAGE_TEST_EXEC_SID 
			 ,STORAGE_TEST_RESULT_GRP_SID
			 ,ORIG_STORE_NR
			 ,MAX($4)  AS D_RECONSTRUCTION_WEEK
			 ,MAX($5)  AS D_EXLUDED_WEEK
						
			FROM
				( SELECT 
					TR.STORAGE_TEST_EXEC_SID 
					,GRP.STORAGE_TEST_RESULT_GRP_SID
					,LOC.SRC_ORIG_STORE_NR AS ORIG_STORE_NR
					,STORAGE_TEST_PARAM_TYPE_CD
					,TEST_WEEK
				FROM P_LEW_CORE.T_STORAGE_TEST_PARAMETER_2 TR
				INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_EXECUTION_EXT_2 EXT
					ON TR.STORAGE_TEST_EXEC_SID = EXT.STORAGE_TEST_EXEC_SID
				INNER JOIN P_LEW_CORE.T_STORAGE_TEST_RESULT_GROUP_2 GRP  
						ON GRP.STORAGE_TEST_RESULT_GRP_SID = TR.STORAGE_TEST_RESULT_GRP_SID
				INNER JOIN P_LEW_CORE.T_LOCATION_2  LOC 
						ON LOC.LOC_SID = GRP.LOC_SID_STORE
				WHERE storage_test_param_type_cd IN ('Reconstruction_Week', 'Excluded_Week')
				AND UPPER(storage_test_result_grp_type_cd) = UPPER( 'Store')
				GROUP BY 1,2,3,4,5
				) AS src
				PIVOT (
						MAX (test_week) 
						FOR storage_test_param_type_cd IN ('Reconstruction_Week', 'Excluded_Week')
					) AS pvt1
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
			FROM p_lew_core.t_storage_test_result_2 tr
			INNER JOIN 
			(
			 SELECT  
				 storage_test_result_grp_sid
				,loc.src_orig_store_nr AS orig_store_nr
				,storage_test_result_grp_type_cd 
				,test_week
			 FROM p_lew_core.t_storage_test_result_group_2 grp
			 INNER JOIN p_lew_core.t_location_2  loc 
			   ON loc.loc_sid = grp.loc_sid_store
			 WHERE UPPER(storage_test_result_grp_type_cd) = UPPER( 'Store')
			   AND test_week<>-1 
			) grp 
			ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
	
			) AS src
		
			INNER JOIN
			(
				SELECT 
					storage_test_exec_sid
					,orig_store_nr
					, MAX( reconstruction_week ) OVER (PARTITION BY storage_test_exec_sid,orig_store_nr) AS max_reconstruction_week
					, analysis_start_week 
					, excluded_week_header
				FROM FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_PARAMETER_2
			)AS ps
			ON src.storage_test_exec_sid = ps.storage_test_exec_sid
			AND src.orig_store_nr = ps.orig_store_nr
			AND src.test_week > ps.max_reconstruction_week 
			AND src.test_week < ps.analysis_start_week
		
		)cmpwk
		ON exrec.storage_test_exec_sid= cmpwk.storage_test_exec_sid
		AND exrec.orig_store_nr= cmpwk.orig_store_nr


GROUP BY 1,2,3,4,5
;