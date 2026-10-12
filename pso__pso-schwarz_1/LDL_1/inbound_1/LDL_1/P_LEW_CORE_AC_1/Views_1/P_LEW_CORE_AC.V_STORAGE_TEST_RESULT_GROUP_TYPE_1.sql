CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_STORAGE_TEST_RESULT_GROUP_TYPE_1 AS 
    SELECT 
         storage_test_result_grp_type_cd
        ,storage_test_result_grp_type_descr
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_STORAGE_TEST_RESULT_GROUP_TYPE_1 ;