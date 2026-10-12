CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_GENDER AS 
    SELECT 
        gender_cd
        ,gender_descr
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated
FROM P_LEW_CORE.T_REF_GENDER ;