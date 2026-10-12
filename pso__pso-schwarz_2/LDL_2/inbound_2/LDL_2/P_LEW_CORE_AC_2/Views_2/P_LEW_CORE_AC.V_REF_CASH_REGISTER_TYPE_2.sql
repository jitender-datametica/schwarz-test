CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_CASH_REGISTER_TYPE_2 AS 
    SELECT 
         cash_register_type_cd
        ,cash_register_type_name
        ,cash_register_type_descr
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_REF_CASH_REGISTER_TYPE_2 ;