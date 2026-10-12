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
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_CLIENT_STORAGE_TEST_RESULT_PARAMETER_LIST
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
	,reconstructin_week_list
	,excluded_week_list
    FROM 
    FE_MSTR_TOOLBOX_SPIEGEL.T_CLIENT_STORAGE_TEST_RESULT_PARAMETER_LIST;