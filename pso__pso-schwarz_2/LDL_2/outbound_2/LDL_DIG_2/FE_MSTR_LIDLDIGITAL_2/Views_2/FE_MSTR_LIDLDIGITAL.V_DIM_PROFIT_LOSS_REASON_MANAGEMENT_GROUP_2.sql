CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_profit_loss_reason_management_group_2 AS SELECT CASE
  WHEN profit_loss_reason_mgmt_group_cd = ''
  THEN '-1'
  ELSE IFNULL(profit_loss_reason_mgmt_group_cd, '-1')
  END AS profit_loss_reason_mgmt_group_cd,
 CAST(profit_loss_reason_mgmt_group_descr AS STRING) AS profit_loss_reason_mgmt_group_descr
FROM ldl_dig_lec_share.v_dim_profit_loss_reason_management_group_core_view_2
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;