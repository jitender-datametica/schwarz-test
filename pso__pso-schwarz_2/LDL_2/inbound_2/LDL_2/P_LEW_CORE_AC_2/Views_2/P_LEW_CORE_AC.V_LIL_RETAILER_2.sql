CREATE OR REPLACE VIEW P_LEW_CORE_AC.v_lil_retailer_2
(
    client_id
    , retailer_sid
    , src_retailer_cd
    , retailer_type_cd
    , retailer_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    client_id
    , retailer_sid
    , src_retailer_cd
    , retailer_type_cd
    , retailer_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM P_LEW_CORE.t_lil_retailer_2;