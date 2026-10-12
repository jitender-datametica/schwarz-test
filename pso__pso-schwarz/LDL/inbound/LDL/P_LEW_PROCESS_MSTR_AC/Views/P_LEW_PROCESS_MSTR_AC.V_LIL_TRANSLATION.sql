CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_LIL_TRANSLATION
(
    context
    , trans_id
    , src_trans_cd
    , lang_cd
    , orig_text
    , trans_text
    , active_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    context
    , trans_id
    , src_trans_cd
    , lang_cd
    , orig_text
    , trans_text
    , active_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM P_LEW_PROCESS_MSTR.T_LIL_TRANSLATION ;
