/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_MISSING_USERDEFINED_GROUP
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_MISSING_USERDEFINED_GROUP
(
    storage_test_exec_sid 
   ,storage_test_result_grp_sid 
   ,storage_test_result_grp_type_cd 
   ,reason_descr
   ,user_defined_grp_name
)AS
SELECT 
    storage_test_exec_sid 
   ,tr.storage_test_result_grp_sid 
   ,grp.storage_test_result_grp_type_cd 
   ,tr.reason_descr
   ,grp.user_defined_grp_name
FROM p_lew_core.t_storage_test_missing_result tr
INNER JOIN (SELECT   grp.storage_test_result_grp_sid
		,grp.storage_test_result_grp_type_cd 
		,grp.test_week
        ,grp.user_defined_grp_name
    	FROM p_lew_core.t_storage_test_result_group grp
	WHERE UPPER(storage_test_result_grp_type_cd) = UPPER( 'UserDefinedGroup')
	   AND grp.test_week=-1
	GROUP BY 1,2,3,4)grp 
ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
WHERE storage_test_metric_type_cd = '-' 
;