CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_STORAGE_TEST_PARAMETER_TYPE_1 AS 
    SELECT 
         storage_test_param_type_cd
        ,storage_test_param_type_descr
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_REF_STORAGE_TEST_PARAMETER_TYPE_1 ;