CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_regional_product_manager_1 (wshop_cd, reg_prod_manager_cd,
reg_prod_manager_name, reg_prod_manager_team_lead_name) AS SELECT wshop_cd,
 reg_prod_manager_cd,
 reg_prod_manager_name,
 reg_prod_manager_team_lead_name
FROM ldl_dig_lec_share.v_dim_regional_product_manager_1
UNION ALL
SELECT '-1',
 '-1',
 '',
 '';