CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_STORAGE_TEST_STORE_RELATION AS 
    SELECT 
         storage_test_exec_sid
        ,loc_sid_store
        ,rel_loc_sid_store
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_STORAGE_TEST_STORE_RELATION ;