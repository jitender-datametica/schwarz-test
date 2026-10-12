/*
#-----------------------------------------------------------------------------
# Description:
# This view provides SortimentModularitat context into LDL.P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_SALES_PIECE_PERF_ITEM_1 view.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     11.06.2025		Malgorzata Cyganska             Initial Version.

#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_store_day_sales_piece_perf_item_somo_1 (client_id, src_orig_store_nr,
loc_sid_store, dwh_cal_dt, currency_iso_cd, item_id, orig_item_nr, container_id, container_hist_id, sales_pieces,
sales_pieces_total, sales_pieces_fa, sales_pieces_fa_total, val_rtl_net_ejr, average_price, piece_receipt, cnt_customer
, time_working_netto_fg, wh_id, move_to_store_id, cy_month, open_store_fg OPTIONS(description='Open store flag'),
bereinigt_fg OPTIONS(description='Bereinigt flag'), bereinigt_vjw_fg
OPTIONS(description='Bereinigt VJ same week day flag'), bereinigt_vjm_fg
OPTIONS(description='Bereinigt VJ same calendar_1 day flag'), bereinigt_vvj_fg OPTIONS(description='Bereinigt VVJ flag'),
bereinigt_vvjw_fg OPTIONS(description='Bereinigt VVJ same week day flag'), bereinigt_vvjm_fg
OPTIONS(description='Bereinigt VVJ same calendar_1 day flag'), bereinigt_vvvj_fg
OPTIONS(description='Bereinigt VVVJ flag'), bereinigt_vvvjw_fg OPTIONS(description='Bereinigt VVVJ same week day flag'),
bereinigt_vvvjm_fg OPTIONS(description='Bereinigt VVVJ same calendar_1 day flag')) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_store_day_sales_piece_perf_item_somo_1;