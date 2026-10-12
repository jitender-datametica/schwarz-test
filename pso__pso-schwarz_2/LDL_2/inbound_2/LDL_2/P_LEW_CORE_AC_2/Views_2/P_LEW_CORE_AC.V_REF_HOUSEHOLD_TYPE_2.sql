CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_HOUSEHOLD_TYPE_2 AS 
    SELECT 
        household_type_id
        ,household_type_descr
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated
FROM P_LEW_CORE.T_REF_HOUSEHOLD_TYPE_2 ;