CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_WH_DAY_WRITEOFF_1
(
  client_id
, loc_sid_wh
, wh_id
, dat_calendar
, currency_iso_cd
, writeoff_val
, writeoff_val_bytd
, writeoff_val_p1y
, writeoff_val_p1y_bytd
, writeoff_val_p1y_wk
, writeoff_val_p1y_wk_bytd
, writeoff_wg_val
, writeoff_wg_val_bytd
, writeoff_wg_val_p1y
, writeoff_wg_val_p1y_bytd
, writeoff_wg_val_p1y_wk
, writeoff_wg_val_p1y_wk_bytd
, rev_val
, rev_val_bytd
, rev_val_p1y
, rev_val_p1y_bytd
, rev_val_p1y_wk
, rev_val_p1y_wk_bytd
, writeoff_val_total
, writeoff_val_total_bytd
, writeoff_val_total_p1y
, writeoff_val_total_p1y_bytd
, writeoff_val_total_p1y_wk
, writeoff_val_total_p1y_wk_bytd
)
AS
   SELECT
      client_id
    , loc_sid_wh
    , wh_id
    , dat_calendar
    , currency_iso_cd
    , writeoff_val
    , writeoff_val_bytd
    , writeoff_val_p1y
    , writeoff_val_p1y_bytd
    , writeoff_val_p1y_wk
    , writeoff_val_p1y_wk_bytd
    , writeoff_wg_val
    , writeoff_wg_val_bytd
    , writeoff_wg_val_p1y
    , writeoff_wg_val_p1y_bytd
    , writeoff_wg_val_p1y_wk
    , writeoff_wg_val_p1y_wk_bytd
    , rev_val
    , rev_val_bytd
    , rev_val_p1y
    , rev_val_p1y_bytd
    , rev_val_p1y_wk
    , rev_val_p1y_wk_bytd
    , writeoff_val_total
    , writeoff_val_total_bytd
    , writeoff_val_total_p1y
    , writeoff_val_total_p1y_bytd
    , writeoff_val_total_p1y_wk
    , writeoff_val_total_p1y_wk_bytd
  FROM p_lew_mart_lead.v_agg_wh_day_writeoff_1
;