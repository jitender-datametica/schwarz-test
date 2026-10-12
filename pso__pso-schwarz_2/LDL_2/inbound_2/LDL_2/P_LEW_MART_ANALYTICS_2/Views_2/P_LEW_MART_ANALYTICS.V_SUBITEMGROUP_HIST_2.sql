CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_SUBITEMGROUP_HIST_2
(
    client_id
    , sub_item_grp_sid
    , item_grp_int_sid
    , main_item_grp_sid
    , item_grp_int_cd
    , main_item_grp_cd
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id,
   sub_item_grp_sid,
   item_grp_int_sid,
   main_item_grp_sid,
   item_grp_int_cd,
   main_item_grp_cd,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core_ac.v_subitemgroup_hist_2
;