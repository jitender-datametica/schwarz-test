CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_STORAGE_TEST_RESULT_GROUP_1 AS 
    SELECT 
        storage_test_result_grp_sid
       ,storage_test_result_grp_type_cd
       ,loc_sid_store
       ,test_week
       ,item_grp_int_sid
       ,sub_item_grp_sid
       ,storage_test_promo_type_cd
       ,user_defined_grp_name
       ,dwh_load_id
       ,dwh_created
       ,dwh_updated

FROM P_LEW_CORE.T_STORAGE_TEST_RESULT_GROUP_1 ;