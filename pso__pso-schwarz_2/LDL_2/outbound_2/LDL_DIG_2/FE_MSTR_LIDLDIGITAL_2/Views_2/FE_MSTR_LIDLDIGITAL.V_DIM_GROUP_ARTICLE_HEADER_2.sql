CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_group_article_header_2 AS WITH GROUP_HEADER_LIST AS (SELECT
  DISTINCT REL.group_header_prod_nr,
   REL.group_header_prod_sid,
   VAR.prod_variant_sid AS group_header_var_sid
  FROM ldl_dig_fe_mstr_lidldigital.v_rel_group_header_component_2 AS REL
   LEFT JOIN ldl_dig_lec_share.v_meta_srg_prod_variant_sid_2 AS VAR ON REL.group_header_prod_nr = VAR.prod_variant_nr) (SELECT
   *
  FROM (SELECT gh.group_header_prod_sid,
      gh.group_header_prod_nr,
      PRD.prod_name AS group_header_name,
      PRD.prod_descr AS group_header_descr,
      IFNULL(PRD.ian_nr, ' ') AS gh_ian_nr,
      IFNULL(NULLIF(PRD.prod_brick_cd, ''), '-1') AS gh_brick_cd,
      IFNULL(NULLIF(PRD.brand_class_cd, ''), '-1') AS gh_brand_class_cd,
      IFNULL(PRD.brand_sid, -1) AS gh_brand_sid,
      IFNULL(NULLIF(PRD.prod_promo_class_cd, ''), '-1') AS gh_promo_class_cd,
      IFNULL(NULLIF(PRD.prod_purch_org_type_cd, ''), '-1') AS gh_purch_org_type_cd,
      IFNULL(VAR0.main_supplier_sid, -1) AS gh_main_supplier_sid,
      IFNULL(NULLIF(PRD.prod_org_lvl_name, ''), '-1') AS gh_prod_org_lvl_name
     FROM GROUP_HEADER_LIST AS gh
      LEFT JOIN ldl_dig_lec_share.v_dim_product_2 AS PRD ON gh.group_header_prod_sid = PRD.prod_sid AND PRD.dwh_valid_fg
      LEFT JOIN ldl_dig_lec_share.v_dim_product_variant_2 AS VAR0 ON gh.group_header_var_sid = VAR0.prod_variant_sid AND
       VAR0.dwh_valid_fg
     UNION ALL
     SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0) AS group_header_prod_sid,
      '' AS group_header_prod_nr,
      '' AS group_header_name,
      '' AS group_header_descr,
      '' AS gh_ian_nr,
      '-1' AS gh_brick_cd,
      '-1' AS gh_brand_class_cd,
      ROUND(CAST('-1' AS BIGNUMERIC), 0) AS gh_brand_sid,
      '-1' AS gh_promo_class_cd,
      '-1' AS gh_purch_org_type_cd,
      ROUND(CAST('-1' AS BIGNUMERIC), 0) AS gh_main_supplier_sid,
      '-1' AS gh_prod_org_lvl_name));