CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_REV_TOPSELL_ITEM_HR_2
AS
SELECT
hrl.client_id,
hrl.dat_formdate,
hrl.item_sid,
hrl.loc_sid_store_move_to,
hrl.wh_loc_sid,
hrl.wh_id,
hrl.cy_week,
hrl.currency_iso_cd,
hrl.time_hour_id,
hrl.qty_piece_ejr,
hrl.qty_weight_ejr,
hrl.qty_sold,
hrl.val_retail_net_ejr
FROM p_lew_mart_lead.v_agg_rev_topsell_item_hr_2 hrl
;



