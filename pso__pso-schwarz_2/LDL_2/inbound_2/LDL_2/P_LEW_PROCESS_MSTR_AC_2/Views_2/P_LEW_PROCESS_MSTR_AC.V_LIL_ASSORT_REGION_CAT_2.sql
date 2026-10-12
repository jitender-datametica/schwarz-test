CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_LIL_ASSORT_REGION_CAT_2
(
    client_id
    , region_sid
    , assort_cat_sid
    , assort_region_cat_id
    , assort_parnt_cat_name_de
    , assort_parnt_cat_name_en
    , assort_chld_cat_name_de
    , assort_chld_cat_name_en
    , sel_srt_cd
    , data_avbl_nopromo_fg
    , data_avbl_promo_fg
    , active_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    client_id
    , region_sid
    , assort_cat_sid
    , assort_region_cat_id
    , assort_parnt_cat_name_de
    , assort_parnt_cat_name_en
    , assort_chld_cat_name_de
    , assort_chld_cat_name_en
    , sel_srt_cd
    , data_avbl_nopromo_fg
    , data_avbl_promo_fg
    , active_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM P_LEW_PROCESS_MSTR.T_LIL_ASSORT_REGION_CAT_2 ;

