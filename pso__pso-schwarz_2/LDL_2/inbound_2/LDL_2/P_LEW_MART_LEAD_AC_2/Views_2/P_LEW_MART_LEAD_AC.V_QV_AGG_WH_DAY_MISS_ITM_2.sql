CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_QV_AGG_WH_DAY_MISS_ITM_2
(
  client_id
, country_group_id
, gl_region_id
, wh_id
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
, country_group_id
, gl_region_id
, wh_id
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
FROM P_LEW_MART_LEAD.V_QV_AGG_WH_DAY_MISS_ITM_2
;