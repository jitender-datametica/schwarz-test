CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_WH_STOCK_DAY_CASE_SIZE_DELTA
(
    client_id
    , wh_id
    , item
    , case_size
    , stock_dat
    , stock
    , load_id
)
AS
   SELECT
   client_id
   , wh_id
   , item
   , case_size
   , stock_dat
   , stock
   , load_id
  FROM p_lew_mart_wfm.v_wh_stock_day_case_size_delta
;