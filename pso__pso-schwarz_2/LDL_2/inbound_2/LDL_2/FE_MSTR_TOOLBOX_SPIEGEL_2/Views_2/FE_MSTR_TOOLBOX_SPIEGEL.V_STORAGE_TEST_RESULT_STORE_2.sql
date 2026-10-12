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

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_STORAGE_TEST_RESULT_STORE_2(
	 storage_test_exec_sid
	,orig_store_nr
	,store_desc
) AS
SELECT 
    storage_test_exec_sid
	,orig_store_nr
	,store_desc
FROM FE_MSTR_TOOLBOX_SPIEGEL.T_STORAGE_TEST_RESULT_STORE_2
;