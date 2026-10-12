CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_LIL_PERIOD_TYPE
(
    period_type_id
    , period_type_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    period_type_id
    , period_type_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM P_LEW_CORE.T_REF_LIL_PERIOD_TYPE ;
