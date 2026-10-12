CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_rel_cost_element_group_lvl_3_ker_position_1 AS SELECT fiscal_year,
 ce_group_lvl3_nr,
 ce_group_lvl3_name_de,
 profit_loss_position_nr AS ker_position_nr,
 profit_loss_position_name AS ker_position_name
FROM ldl_dig_lec_share.v_rel_cost_element_group_profit_loss_position_1
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand0,
 '-1' AS dm__operand1,
 '' AS dm__operand2,
 '-1' AS dm__operand3,
 '' AS dm__operand4;