CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_LIL_REGION_DESCR
(
    client_id
    , region_sid
    , lang_cd
    , region_name
    , region_long_descr
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    client_id
    , region_sid
    , lang_cd
    , region_name
    , region_long_descr
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM P_LEW_CORE.T_LIL_REGION_DESCR ;
