CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_LIL_RETAILER_DESCR_2
(
    client_id
    , retailer_sid
    , lang_cd
    , retailer_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    client_id
    , retailer_sid
    , lang_cd
    , retailer_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM P_LEW_CORE.T_LIL_RETAILER_DESCR_2 ;
