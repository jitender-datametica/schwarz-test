CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_manager_1 (prod_manager_cd, prod_manager_name,
prod_manager_team, prod_manager_team_lead) AS SELECT prod_manager_cd,
 prod_manager_name,
 prod_manager_team,
 prod_manager_team_lead
FROM ldl_dig_lec_share.v_dim_product_manager_1
UNION ALL
SELECT '-1',
 '',
 '',
 '';