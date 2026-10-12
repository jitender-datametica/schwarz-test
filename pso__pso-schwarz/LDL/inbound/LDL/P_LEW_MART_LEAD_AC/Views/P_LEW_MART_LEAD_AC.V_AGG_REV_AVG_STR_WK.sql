CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_REV_AVG_STR_WK
(
    client_id
    , loc_sid_store
    , currency_iso_cd
    , busyear
    , month_id
    , cy_week_partial_week_id
    , rev_wktd_val
    , rev_mtd_val
    , rev_bytd_val
    , prev1y_rev_wktd_val
    , prev1y_rev_mtd_val
    , prev1y_rev_bytd_val
    , day_cnt_wk
    , day_cnt_mtd
    , day_cnt_bytd
    , day_cnt_py_wk
    , day_cnt_py_mtd
    , day_cnt_py_bytd
)
AS
   SELECT
       client_id,
   loc_sid_store,
   currency_iso_cd,
   busyear,
   month_id,
   cy_week_partial_week_id,
   rev_wktd_val,
   rev_mtd_val,
   rev_bytd_val,
   prev1y_rev_wktd_val,
   prev1y_rev_mtd_val,
   prev1y_rev_bytd_val,
   day_cnt_wk,
   day_cnt_mtd,
   day_cnt_bytd,
   day_cnt_py_wk,
   day_cnt_py_mtd,
   day_cnt_py_bytd
  FROM p_lew_mart_lead.t_agg_rev_avg_str_wk;