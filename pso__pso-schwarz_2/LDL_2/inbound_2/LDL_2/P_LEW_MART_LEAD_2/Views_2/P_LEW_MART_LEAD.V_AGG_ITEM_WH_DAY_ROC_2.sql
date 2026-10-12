CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_ITEM_WH_DAY_ROC_2
/*
#DescStart#
#$Revision: 10070 $, $LastChangedBy: ckumbhale $
#SubjectAreas#: One-to-one view on dimension table for network connectivity of baking chambers
#DescEnd#
*/
(
client_id
,wh_loc_sid
,wh_id
,aspect_id
,currency_iso_cd
,item_sid
,dat_formdate
,cy_week
,cy_month
,busyear
,stock_slot_fg
,stock_case_size_fg
,qty_piece_five_weeks_fg
,qty_piece_vs_case_size_fg
,flags_combined
,qty_piece_stc_wh
,qty_total_goodsout_avg_35_days
)
AS
   SELECT
   agg.client_id
   ,agg.wh_loc_sid
   ,agg.wh_id
   ,agg.aspect_id
   ,cry.curr_cd_from AS currency_iso_cd
   ,agg.item_sid
   ,agg.dat_formdate
   ,agg.cy_week
   ,agg.cy_month
   ,agg.busyear
   ,agg.stock_slot_fg
   ,agg.stock_case_size_fg
   ,agg.qty_piece_five_weeks_fg
   ,agg.qty_piece_vs_case_size_fg
   ,agg.flags_combined
   ,agg.qty_piece_stc_wh
   ,agg.qty_total_goodsout_avg_35_days
   FROM p_lew_mart_lead.t_agg_item_wh_day_roc_2 agg
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_2 AS cry
   ON    agg.client_id = cry.client_id
   AND   CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND   CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 c
   ON    c.client_id       = cry.client_id
   AND   c.x_rate_type_sid = cry.x_rate_type_sid
   AND   c.src_kurst       = '@BEWE'
   ;