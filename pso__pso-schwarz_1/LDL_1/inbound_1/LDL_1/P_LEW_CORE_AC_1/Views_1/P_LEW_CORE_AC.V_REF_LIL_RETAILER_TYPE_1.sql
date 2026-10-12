CREATE OR REPLACE VIEW P_LEW_CORE_AC.v_ref_lil_retailer_type_1
(
    retailer_type_cd
    , retailer_type_descr
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    retailer_type_cd
    , retailer_type_descr
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM P_LEW_CORE.t_ref_lil_retailer_type_1 ;