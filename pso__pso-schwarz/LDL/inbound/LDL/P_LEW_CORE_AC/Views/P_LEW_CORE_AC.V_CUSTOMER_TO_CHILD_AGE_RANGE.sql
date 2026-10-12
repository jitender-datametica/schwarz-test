CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CUSTOMER_TO_CHILD_AGE_RANGE AS 
    SELECT 
        client_id
        ,customer_sid
        ,child_age_range_cd
        ,child_age_range_forecasted_fg
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated
FROM P_LEW_CORE.T_CUSTOMER_TO_CHILD_AGE_RANGE ;