/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_CLIENT_ORDER_HIST_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski, Michal           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_mdm_item_client_order_hist_2 (client_id, mdm_item_sid, client_id_order,
cbx_order_version, cy_week_advertise, cy_week_import, client_sell_from_dt, client_order_carton_weight,
client_order_total_qty, client_order_total_carton_qty, client_order_notes, ldl_store_cnt, kfl_large_store_cnt,
kfl_small_store_cnt, purch_net_euro_price, sales_vat_pct, sales_gross_euro_price, deleted_fg, dwh_valid_from,
dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_item_sid,
 client_id_order,
 cbx_order_version,
 cy_week_advertise,
 cy_week_import,
 client_sell_from_dt,
 client_order_carton_weight,
 client_order_total_qty,
 client_order_total_carton_qty,
 client_order_notes,
 ldl_store_cnt,
 kfl_large_store_cnt,
 kfl_small_store_cnt,
 purch_net_euro_price,
 sales_vat_pct,
 sales_gross_euro_price,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core_ac.v_mdm_item_client_order_hist_2;