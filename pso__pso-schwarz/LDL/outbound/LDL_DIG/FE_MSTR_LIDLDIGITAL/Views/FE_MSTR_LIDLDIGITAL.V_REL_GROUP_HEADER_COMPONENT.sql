CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_rel_group_header_component AS WITH GROUP_HEAD AS (SELECT CONCAT(cust_order_sid
    , '_', cust_order_pos_nr) AS group_order_pos,
   prod_sid AS group_header_prod_sid,
   prod_qty AS group_header_qty
  FROM ldl_dig_lec_share.v_fact_customer_order_line
  WHERE is_bundle_header_fg), GROUP_COMP AS (SELECT CONCAT(cust_order_sid, '_', bundle_header_pos_nr) AS group_order_pos
   ,
   prod_variant_sid,
   prod_qty AS group_component_qty
  FROM ldl_dig_lec_share.v_fact_customer_order_line
  WHERE bundle_header_pos_nr <> 0) (SELECT SRG_PROD.prod_nr AS group_id,
   gh.group_header_prod_sid,
   SRG_PROD.prod_nr AS group_header_prod_nr,
   gc.prod_variant_sid,
   SRG_VAR.prod_variant_nr,
   CAST(ROUND(AVG(IF(gh.group_header_qty = 0, 0, SAFE_DIVIDE(gc.group_component_qty, gh.group_header_qty))), 0) AS INTEGER)
   AS group_component_qty
  FROM GROUP_HEAD AS gh
   LEFT JOIN GROUP_COMP AS gc ON gh.group_order_pos = gc.group_order_pos
   LEFT JOIN ldl_dig_lec_share.v_meta_srg_prod_sid AS SRG_PROD ON gh.group_header_prod_sid = SRG_PROD.prod_sid
   LEFT JOIN ldl_dig_lec_share.v_meta_srg_prod_variant_sid AS SRG_VAR ON gc.prod_variant_sid = SRG_VAR.prod_variant_sid
  GROUP BY group_id,
   gh.group_header_prod_sid,
   group_header_prod_nr,
   gc.prod_variant_sid,
   SRG_VAR.prod_variant_nr);