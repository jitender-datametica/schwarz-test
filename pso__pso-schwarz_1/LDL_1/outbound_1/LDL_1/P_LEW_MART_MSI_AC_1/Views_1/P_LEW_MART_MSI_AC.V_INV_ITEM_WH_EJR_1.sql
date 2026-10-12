CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_inv_item_wh_ejr_1 (client_id, wh_id, inv_id, inv_start_date, inv_end_date,
item_id, val_rtl_ejr_asis, val_rtl_net_ejr_asis, val_return_ejr_asis, val_return_net_ejr_asis, currency_iso_cd) AS
SELECT *
FROM ldl_p_lew_mart_msi.v_inv_item_wh_ejr_1;