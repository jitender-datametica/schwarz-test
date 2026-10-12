CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_ker_position_name AS SELECT DISTINCT fiscal_year,
 profit_loss_position_nr AS ker_position_nr,
 profit_loss_position_name AS ker_position_name,
 profit_loss_position_display_order_nr AS ker_position_display_order_nr
FROM ldl_dig_lec_share.v_rel_cost_element_group_profit_loss_position
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand0,
 '-1' AS dm__operand1,
 '-1' AS dm__operand2,
 ROUND(CAST('1000' AS BIGNUMERIC), 0) AS dm__operand3;