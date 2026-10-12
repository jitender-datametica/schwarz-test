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
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_STORAGE_TEST_RESULT_STORES_CNT_1
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
,stores_cnt
FROM 
FE_MSTR_TOOLBOX_SPIEGEL.T_AGG_STORAGE_TEST_RESULT_STORES_CNT_1
;
