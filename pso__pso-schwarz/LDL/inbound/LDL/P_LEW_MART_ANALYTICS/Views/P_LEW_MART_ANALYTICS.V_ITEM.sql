CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_ITEM
(
    client_id
    , item_sid
    , src_matnr
    , src_orig_item_nr
    , src_dat_valid_from
    , src_case_size
    , item_sid_config
    , item_name
    , log_var_cd
    , config_item_cd
    , item_eks_cd
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id,
   item_sid,
   src_matnr,
   src_orig_item_nr,
   src_dat_valid_from,
   src_case_size,
   item_sid_config,
   item_name,
   log_var_cd,
   config_item_cd,
   item_eks_cd,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core_ac.v_item
;