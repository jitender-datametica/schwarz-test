/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_STORE_2
#----------------------------------------------------------------------------
# History:
#  1.0  28.11.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_STORAGE_TEST_RESULT_STORE_2(
	 storage_test_exec_sid
	,orig_store_nr
	,store_desc
) AS
SELECT 
      tr.storage_test_exec_sid
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
 	  GROUP BY 1,2,3
;