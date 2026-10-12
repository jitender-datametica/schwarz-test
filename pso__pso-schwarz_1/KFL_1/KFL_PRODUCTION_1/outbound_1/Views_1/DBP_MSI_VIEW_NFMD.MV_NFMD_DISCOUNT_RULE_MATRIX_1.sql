CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_nfmd_discount_rule_matrix_1 AS SELECT mandant_id,
 price_class_cd,
 hwg_id,
 curve_type_cd,
 experiment_group_cd,
    CAST(TRUNC(CAST(sell_wk34_from_wk3_rate_min * 100 AS BIGNUMERIC)) AS STRING) || '% - ' || CAST(TRUNC(CAST(sell_wk34_from_wk3_rate_max * 100 AS BIGNUMERIC)
     ) AS STRING) || '%' AS sell_wk34_from_wk3_rate,
 sell_wk34_from_wk3_rate_min,
 sell_wk34_from_wk3_rate_max,
 suggested_discount_rate,
 wrg_id,
 rule_created_dt,
 rule_decision_record,
 rule_status
FROM kfl_production_dbp_view.v_nfmd_discount_rule_matrix_1;