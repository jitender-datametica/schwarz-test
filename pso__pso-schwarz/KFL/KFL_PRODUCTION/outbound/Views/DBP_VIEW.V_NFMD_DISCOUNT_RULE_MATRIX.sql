CREATE OR REPLACE VIEW kfl_production_dbp_view.v_nfmd_discount_rule_matrix AS SELECT mandant_id,
 price_class_cd,
 hwg_id,
 curve_type_cd,
 experiment_group_cd,
 rule_created_dt,
 sell_wk34_from_wk3_rate_min,
 sell_wk34_from_wk3_rate_max,
 wrg_id,
 suggested_discount_rate,
 rule_decision_record,
 rule_status
FROM kfl_production_dbp_data.nfmd_discount_rule_matrix;