CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_ITEM_FAMILYGROUP_HIST_1
(
    client_id
    , item_fam_grp_sid
    , sub_item_grp_sid
    , sub_item_grp_cd
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
   item_fam_grp_sid,
   sub_item_grp_sid,
   sub_item_grp_cd,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core_ac.v_item_familygroup_hist_1
;