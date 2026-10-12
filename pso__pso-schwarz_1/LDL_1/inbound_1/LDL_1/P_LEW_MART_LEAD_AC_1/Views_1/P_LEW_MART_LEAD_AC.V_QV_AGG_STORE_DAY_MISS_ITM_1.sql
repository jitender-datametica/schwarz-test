CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_QV_AGG_STORE_DAY_MISS_ITM_1
(
  client_id
, account_manager_id
, sales_manager_id
, move_to_store_id
, wh_id
, wh_id_exp
, aspect_id
, currency_iso_cd
, curr_tot_id
, dat_formdate
, miss_item_cnt_cy
, miss_item_cnt_fa_cy
, miss_item_cnt_py
, miss_item_cnt_fa_py
, store_day_cnt_cy
, store_day_cnt_fa_cy
, store_day_cnt_py
, store_day_cnt_fa_py
, miss_item_fg_cy
, miss_item_fg_fa_cy
, miss_item_fg_py
, miss_item_fg_fa_py
)
AS
SELECT
  client_id
, account_manager_id
, sales_manager_id
, move_to_store_id
, wh_id
, wh_id_exp
, aspect_id
, currency_iso_cd
, curr_tot_id
, dat_formdate
, miss_item_cnt_cy
, miss_item_cnt_fa_cy
, miss_item_cnt_py
, miss_item_cnt_fa_py
, store_day_cnt_cy
, store_day_cnt_fa_cy
, store_day_cnt_py
, store_day_cnt_fa_py
, miss_item_fg_cy
, miss_item_fg_fa_cy
, miss_item_fg_py
, miss_item_fg_fa_py
FROM P_LEW_MART_LEAD.V_QV_AGG_STORE_DAY_MISS_ITM_1
;