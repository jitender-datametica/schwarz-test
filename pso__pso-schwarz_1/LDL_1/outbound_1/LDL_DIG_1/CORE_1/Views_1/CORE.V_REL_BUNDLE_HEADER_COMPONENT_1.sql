CREATE OR REPLACE VIEW ldl_dig_core.v_rel_bundle_header_component_1 (bundle_header_prod_sid
OPTIONS(description='Unique identifier (surrogate key) of the Bundle Header Product'), bundle_header_prod_nr
OPTIONS(description='The original number of the Bundle Header Product'), bundle_header_prod_variant_sid
OPTIONS(description='Unique Identifier for the product variant of the bundle header to which this bundle item_1 belongs'),
bundle_component_prod_variant_sid
OPTIONS(description='Unique identifier (surrogate key) of the Product Variant that is sold as component in the bundle'),
bundle_component_prod_variant_nr
OPTIONS(description='The original number of the Product Variant that is sold as component in the bundle'),
bundle_component_qty OPTIONS(description='For each component the amount of pieces that are part of the bundle'))
OPTIONS(DESCRIPTION = `A VIEW THAT CONTAINS UNIQUE COMBINATIONS OF PRODUCTS SOLD AS BUNDLE HEADERS AND PRODUCT VARIANTS SOLD AS COMPONENTS OF THOSE BUNDLES`)
AS WITH BUNDLE_HEADER AS (SELECT CONCAT(cust_order_sid, '_', cust_order_pos_nr) AS bundle_header_key,
   prod_sid,
   prod_nr,
   prod_variant_sid,
   prod_qty AS bundle_header_prod_qty
  FROM ldl_dig_core.t_fact_customer_order_line_1
  WHERE is_bundle_header_fg), BUNDLE_COMPONENT AS (SELECT CONCAT(cust_order_sid, '_', bundle_header_pos_nr) AS
   bundle_header_key,
   prod_variant_sid,
   prod_variant_nr,
   prod_qty AS bundle_component_prod_qty
  FROM ldl_dig_core.t_fact_customer_order_line_1
  WHERE bundle_header_pos_nr <> 0) (SELECT bh.prod_sid AS bundle_header_prod_sid,
   bh.prod_nr AS bundle_header_prod_nr,
   bh.prod_variant_sid AS bundle_header_prod_variant_sid,
   bc.prod_variant_sid AS bundle_component_prod_variant_sid,
   bc.prod_variant_nr AS bundle_component_prod_variant_nr,
   CAST(ROUND(AVG(IF(bh.bundle_header_prod_qty = 0, 0, SAFE_DIVIDE(bc.bundle_component_prod_qty, bh.bundle_header_prod_qty))), 0) AS INTEGER)
   AS bundle_component_qty
  FROM BUNDLE_HEADER AS bh
   LEFT JOIN BUNDLE_COMPONENT AS bc ON bh.bundle_header_key = bc.bundle_header_key
  GROUP BY bundle_header_prod_sid,
   bundle_header_prod_nr,
   bundle_header_prod_variant_sid,
   bundle_component_prod_variant_sid,
   bundle_component_prod_variant_nr);