/*
#----------------------------------------------------------------------------
# Description:
# Static view for Reporting.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     26.02.2024      Simeon Nikolaev          Initial Version
#
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_REF_COMPENSATION_WEEK(
  STORAGE_TEST_EXEC_SID
 ,ORIG_STORE_NR
 ,TEST_WEEK
 ,COMPENSATION_WEEK_FG
) AS
SELECT DISTINCT
	 main.storage_test_exec_sid
	,main.orig_store_nr
	,main.test_week
	,CASE WHEN cmpwk.test_week = main.test_week THEN 1 ELSE 0 END AS compensation_week_fg
	FROM 
	(
		SELECT DISTINCT
			tr.storage_test_exec_sid 
			,grp.orig_store_nr
			,grp.test_week
		FROM p_lew_core.t_storage_test_result tr
		INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_EXECUTION_EXT ext
			ON tr.storage_test_exec_sid = ext.storage_test_exec_sid
		INNER JOIN 
			(
				SELECT
				storage_test_result_grp_sid
				,storage_test_result_grp_type_cd 
				,loc.src_orig_store_nr AS orig_store_nr
				,test_week
				FROM p_lew_core.t_storage_test_result_group grp
				INNER JOIN p_lew_core.t_location  loc 
				ON loc.loc_sid = grp.loc_sid_store
				WHERE UPPER(storage_test_result_grp_type_cd) = UPPER( 'Store')
			)grp 
			ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
	)main
	
	INNER JOIN
	
	(
		SELECT DISTINCT		 
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
			FROM p_lew_core.t_storage_test_result tr
			INNER JOIN 
			(
			 SELECT  
				 storage_test_result_grp_sid
				,loc.src_orig_store_nr AS orig_store_nr
				,storage_test_result_grp_type_cd 
				,test_week
			 FROM p_lew_core.t_storage_test_result_group grp
			 INNER JOIN p_lew_core.t_location  loc 
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
			FROM FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_PARAMETER
		)AS ps
		ON src.storage_test_exec_sid = ps.storage_test_exec_sid
		AND src.orig_store_nr = ps.orig_store_nr
		AND src.test_week > ps.max_reconstruction_week 
		AND src.test_week < ps.analysis_start_week
		
	)cmpwk
	ON main.storage_test_exec_sid= cmpwk.storage_test_exec_sid
	AND main.orig_store_nr= cmpwk.orig_store_nr	

;