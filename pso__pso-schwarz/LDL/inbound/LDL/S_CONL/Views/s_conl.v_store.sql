CREATE OR REPLACE VIEW s_conl.v_store
AS
SELECT
    client_id
    , country_iso_cd
    , loc_sid_store
    , src_werks
    , src_orig_store_nr
    , src_store_id
    , src_wh_id
    , loc_name
    , loc_name2
    , global_loc_id
    , country_pol_sid
    , country_pol_cd
    , storetype_mark
    , closing_dt
    , opening_dt
    , real_opening_dt
    , global_loc_type_cd
    , addr_sid
    , test_store_fg
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , region_cd
    , mde_lang_cd
    , qty_min_dflt
    , dat_opening_ovis
    , dat_closing_ovis
    , dummy_store_fg
    , pseudo_store_fg
    , dwh_actual_fg
    , active_fg
    , active_future_fg

FROM p_lew_bil_ac.v_store
WHERE client_id IN
 (SELECT
client_id
FROM s_conl.t_user_mapping WHERE lower(user_name) = lower(current_user));

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECT "p_lew_bil_ac.v_warehouse" ***/

