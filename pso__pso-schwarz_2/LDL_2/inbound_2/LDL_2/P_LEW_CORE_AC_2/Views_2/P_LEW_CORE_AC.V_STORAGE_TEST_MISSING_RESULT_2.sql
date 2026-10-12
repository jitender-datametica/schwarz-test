CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_STORAGE_TEST_MISSING_RESULT_2 AS 
    SELECT 
        storage_test_exec_sid
       ,storage_test_result_grp_sid
       ,storage_test_metric_type_cd
       ,reason_descr
       ,dwh_load_id
       ,dwh_created
       ,dwh_updated

FROM P_LEW_CORE.T_STORAGE_TEST_MISSING_RESULT_2 ;