/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_STORES_CNT_1
#----------------------------------------------------------------------------
# History:
#  1.0  28.09.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_AGG_STORAGE_TEST_RESULT_STORES_CNT_1
(
 storage_test_exec_sid 
,storage_test_result_grp_sid
,storage_test_result_grp_type_cd
,test_week
,stores_cnt
)
AS
SELECT  storage_test_exec_sid 
       ,storage_test_result_grp_sid
       ,storage_test_result_grp_type_cd 
       ,test_week
       ,($5) AS stores_cnt
FROM 
( SELECT storage_test_exec_sid 
,tr.storage_test_result_grp_sid 
,storage_test_result_grp_type_cd 
,test_week
,storage_test_param_type_cd
,param_meas
 FROM P_LEW_CORE.t_storage_test_parameter_1 tr
INNER JOIN p_lew_core.t_storage_test_result_group_1 grp  
   ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
WHERE storage_test_param_type_cd IN ('Test_Store_Cnt')
  AND UPPER(storage_test_result_grp_type_cd) = UPPER( 'General')
) AS src
PIVOT  (
    SUM (param_meas) 
    FOR storage_test_param_type_cd IN ('Test_Store_Cnt')
       ) AS pvt1
;
