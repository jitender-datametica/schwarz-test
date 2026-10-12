CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_STR_WK_ITEM_GRP_WRITEOFF_2
(
  cy_partial_week
, cy_week
, byr
, currency_iso_cd
, client_id
, wh_id
, loc_sid_wh
, move_to_store_id
, item_grp_int_sid
, itemgroup_int_id
, writeoff_val
, writeoff_val_bytd
, writeoff_val_p1y
, writeoff_val_p1y_bytd
, writeoff_val_p1y_wk
, writeoff_val_p1y_wk_bytd
, rev_ejr_val
, rev_ejr_val_bytd
, rev_ejr_val_p1y
, rev_ejr_val_p1y_bytd
, rev_ejr_val_p1y_wk
, rev_ejr_val_p1y_wk_bytd
, writeoff_val_total
, writeoff_val_total_bytd
, writeoff_val_total_p1y
, writeoff_val_total_p1y_bytd
, writeoff_val_total_p1y_wk
, writeoff_val_total_p1y_wk_bytd
)
AS
   SELECT
      cy_partial_week
    , cy_week
    , byr
    , currency_iso_cd
    , client_id
    , wh_id
    , loc_sid_wh
    , move_to_store_id
    , item_grp_int_sid
    , itemgroup_int_id
    , writeoff_val
    , writeoff_val_bytd
    , writeoff_val_p1y
    , writeoff_val_p1y_bytd
    , writeoff_val_p1y_wk
    , writeoff_val_p1y_wk_bytd
    , rev_ejr_val
    , rev_ejr_val_bytd
    , rev_ejr_val_p1y
    , rev_ejr_val_p1y_bytd
    , rev_ejr_val_p1y_wk
    , rev_ejr_val_p1y_wk_bytd
    , writeoff_val_total
    , writeoff_val_total_bytd
    , writeoff_val_total_p1y
    , writeoff_val_total_p1y_bytd
    , writeoff_val_total_p1y_wk
    , writeoff_val_total_p1y_wk_bytd
  FROM p_lew_mart_lead.t_agg_str_wk_item_grp_writeoff_2
;