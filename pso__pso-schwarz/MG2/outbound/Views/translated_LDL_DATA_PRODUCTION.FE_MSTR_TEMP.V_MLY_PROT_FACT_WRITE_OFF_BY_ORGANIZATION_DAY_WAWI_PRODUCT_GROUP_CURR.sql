CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_temp.v_mly_prot_fact_write_off_by_organization_day_wawi_product_group_curr
(cal_dt, store_sid, int_org_type_cd, country_org_sid, country_org_cd, wawi_variant_sid, wawi_product_sid,
write_off_for_breakage_net_val, write_off_for_sell_by_dt_net_val, write_off_for_deliv_quality_net_val,
write_off_for_defective_non_food_net_val, write_off_for_donations_net_val, write_off_for_taken_prod_net_val,
write_off_for_discounts_net_val, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd, write_off_net_val,
write_off_for_force_majeure_net_val, write_off_for_stock_clearance_net_val, curr_cd, curr_group_fg, local_group_fg) AS
SELECT main.bus_dt AS cal_dt,
 main.int_org_sid AS store_sid,
 main.int_org_type_cd,
 main.country_org_sid,
 main.country_org_cd,
 main.wawi_variant_sid,
 main.wawi_product_sid,
  main.write_off_for_breakage_net_val / fer.exchange_rate AS write_off_for_breakage_net_val,
  main.write_off_for_sell_by_dt_net_val / fer.exchange_rate AS write_off_for_sell_by_dt_net_val,
  main.write_off_for_deliv_quality_net_val / fer.exchange_rate AS write_off_for_deliv_quality_net_val,
  main.write_off_for_defective_non_food_net_val / fer.exchange_rate AS write_off_for_defective_non_food_net_val,
  main.write_off_for_donations_net_val / fer.exchange_rate AS write_off_for_donations_net_val,
  main.write_off_for_taken_prod_net_val / fer.exchange_rate AS write_off_for_taken_prod_net_val,
  main.write_off_for_discounts_net_val / fer.exchange_rate AS write_off_for_discounts_net_val,
 main.dwh_created_tmsp,
 main.dwh_updated_tmsp,
 main.dwh_load_id,
 main.dwh_node_cd,
  main.write_off_net_val / fer.exchange_rate AS write_off_net_val,
  main.write_off_for_force_majeure_net_val / fer.exchange_rate AS write_off_for_force_majeure_net_val,
  main.write_off_for_stock_clearance_net_val / fer.exchange_rate AS write_off_for_stock_clearance_net_val,
 fer.src_curr_cd AS curr_cd,
  CASE
  WHEN fer.src_curr_cd = 'EUR'
  THEN 1
  ELSE 0
  END AS curr_group_fg,
  CASE
  WHEN fer.src_curr_cd = fer.tgt_curr_cd
  THEN 1
  ELSE 0
  END AS curr_local_fg
FROM ldl_data_production_fe_mstr_temp.t_mly_prot_fact_write_off_by_organization_day_wawi_product AS main
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate AS fer ON main.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
 AND fer.src_curr_cd = 'EUR'
 AND fer.active_fg;


