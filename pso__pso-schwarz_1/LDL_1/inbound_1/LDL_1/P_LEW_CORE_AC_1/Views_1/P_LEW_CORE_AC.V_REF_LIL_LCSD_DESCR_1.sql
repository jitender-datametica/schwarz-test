CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_LIL_LCSD_DESCR_1
(
    lcsd_id
    , lang_cd
    , lcsd_descr
    , lcsd_short_descr
    , lcsd_explain
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    lcsd_id
    , lang_cd
    , lcsd_descr
    , lcsd_short_descr
    , lcsd_explain
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM P_LEW_CORE.T_REF_LIL_LCSD_DESCR_1 ;
