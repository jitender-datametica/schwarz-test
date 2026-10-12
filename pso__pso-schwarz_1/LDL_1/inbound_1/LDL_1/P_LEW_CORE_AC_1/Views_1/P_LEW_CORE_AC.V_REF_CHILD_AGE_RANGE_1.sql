CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_CHILD_AGE_RANGE_1 AS 
    SELECT 
        child_age_range_cd
        ,child_age_range_name
        ,child_age_range_descr
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated
FROM P_LEW_CORE.T_REF_CHILD_AGE_RANGE_1 ;