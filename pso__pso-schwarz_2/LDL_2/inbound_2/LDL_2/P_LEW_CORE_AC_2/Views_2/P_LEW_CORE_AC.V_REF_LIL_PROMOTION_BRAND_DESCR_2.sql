CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_LIL_PROMOTION_BRAND_DESCR_2
(
    promotion_brand_id
    , lang_cd
    , promotion_brand_descr
    , promotion_brand_short_descr
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    promotion_brand_id
    , lang_cd
    , promotion_brand_descr
    , promotion_brand_short_descr
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM P_LEW_CORE.T_REF_LIL_PROMOTION_BRAND_DESCR_2 ;

