CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_QV_AGG_WH_DAY_WGI_MISS_ITM_2
(
  client_id
, country_group_id
, gl_region_id
, wh_id
, aspect_id
, currency_iso_cd
, curr_tot_id
, dat_formdate
, itemgroup_int_id
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
  wgi.client_id
, trc.country_group_id
, twm.gl_region_id
, wgi.wh_id
, wgi.aspect_id
, wgi.currency_iso_cd
, wgi.curr_tot_id
, wgi.dat_formdate
, wgi.itemgroup_int_id
, SUM(wgi.miss_item_cnt_cy)
, SUM(wgi.miss_item_cnt_fa_cy)
, SUM(wgi.miss_item_cnt_py)
, SUM(wgi.miss_item_cnt_fa_py)

, SUM(wgi.store_day_cnt_cy)
, SUM(wgi.store_day_cnt_fa_cy)
, SUM(wgi.store_day_cnt_py)
, SUM(wgi.store_day_cnt_fa_py)

, MAX(wgi.miss_item_fg_cy)
, MAX(wgi.miss_item_fg_fa_cy)
, MAX(wgi.miss_item_fg_py)
, MAX(wgi.miss_item_fg_fa_py)
FROM P_LEW_MART_LEAD_AC.V_QV_AGG_STORE_DAY_WGI_MISS_ITM_2 AS wgi

LEFT OUTER JOIN P_LEW_MART_LEAD_AC.v_ref_client_lead_2 AS trc
ON wgi.client_id          = trc.client_id

LEFT OUTER JOIN P_LEW_MART_LEAD_AC.v_org_wh_merge_2 AS twm
ON  wgi.client_id         = twm.client_id
AND wgi.aspect_id         = twm.aspect_id
AND wgi.wh_id             = twm.wh_id

GROUP BY
  wgi.client_id
, trc.country_group_id
, twm.gl_region_id
, wgi.wh_id
, wgi.aspect_id
, wgi.currency_iso_cd
, wgi.curr_tot_id
, wgi.dat_formdate
, wgi.itemgroup_int_id
;