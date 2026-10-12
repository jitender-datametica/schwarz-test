CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_STORAGE_TEST_PARAMETER AS 
    SELECT 
        storage_test_exec_sid
       ,storage_test_result_grp_sid
       ,storage_test_param_type_cd
       ,param_txt
       ,param_pct
       ,param_meas
       ,param_fg
       ,dwh_load_id
       ,dwh_created
       ,dwh_updated

FROM P_LEW_CORE.T_STORAGE_TEST_PARAMETER ;