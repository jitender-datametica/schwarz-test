CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_STORAGE_TEST_EXECUTION_1 AS 
    SELECT 
        client_id
       ,storage_test_exec_sid
       ,storage_test_exec_name
       ,end_week
       ,dur_week_cnt
       ,min_training_day_cnt
       ,spread_pct
       ,dwh_load_id
       ,dwh_created
       ,dwh_updated

FROM P_LEW_CORE.T_STORAGE_TEST_EXECUTION_1 ;