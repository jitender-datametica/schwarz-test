CREATE OR REPLACE VIEW ldl_dig_core.v_dim_travel_offer_product_classification_1 (trav_offer_prod_class_cd,
trav_offer_prod_class_descr)
OPTIONS(DESCRIPTION = `A REGULAR VIEW TO FETCH THE CATEGORIZATION OF A PRODUCT.(DELUXE | PREMIUM | STANDARD)`) AS SELECT
DISTINCT trav_offer_prod_class_cd,
 NULL AS trav_offer_prod_class_descr
FROM ldl_dig_core.t_dim_travel_offer_1;