CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_utilisation_type_1 AS SELECT util_action_cd,
 util_action_cd AS util_action_descr
FROM ldl_dig_lec_share.v_dim_utilisation_type_core_view_1
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;