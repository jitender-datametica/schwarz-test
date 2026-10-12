CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm_2 (client_id, loc_sid, item_sid, uom_sid_cond,
curr_cd, cond_val_adv, cond_val, cond_val_adv_cmpy, cond_val_cmpy, cond_val_adv_ent, cond_val_ent, net_val_adv, net_val
, net_val_adv_cmpy, net_val_cmpy, net_val_adv_ent, net_val_ent, tax_rate_adv, tax_rate, tax_rate_adv_cmpy, tax_rate_cmpy
, tax_rate_adv_ent, tax_rate_ent, reason_price_modifi_adv, reason_price_modifi_adv_cmpy, reason_price_modifi_adv_ent,
dwh_valid_from, dwh_valid_to, val_lev, val_adv_lev, cond_val_eff_calc, net_val_eff_calc, cond_val_adv_calc,
cond_val_calc, net_val_adv_calc, net_val_calc, tax_rate_adv_calc, tax_rate_calc, reason_price_modifi_adv_calc) AS SELECT
 *
FROM ldl_p_lew_bil.v_item_loc_sales_cond_denorm_2;