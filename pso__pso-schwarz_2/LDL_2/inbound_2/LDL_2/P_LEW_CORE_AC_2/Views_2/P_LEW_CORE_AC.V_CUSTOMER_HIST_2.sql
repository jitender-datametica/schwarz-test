CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CUSTOMER_HIST_2 AS 
    SELECT 
        client_id
        ,customer_sid
        ,dwh_valid_from
        ,dwh_valid_to
        ,deleted_fg
        ,lplus_geo_area_sid
        ,lplus_geo_area_cd
        ,gender_cd
        ,age_range_cd
        ,household_type_id
        ,household_type_forecasted_fg
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated
FROM P_LEW_CORE.T_CUSTOMER_HIST_2 ;