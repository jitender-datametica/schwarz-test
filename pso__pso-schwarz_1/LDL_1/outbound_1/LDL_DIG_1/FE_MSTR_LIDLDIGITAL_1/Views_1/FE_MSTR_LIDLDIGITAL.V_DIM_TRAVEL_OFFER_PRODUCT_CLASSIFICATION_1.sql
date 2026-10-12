CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_travel_offer_product_classification_1 (trav_offer_prod_class_cd,
trav_offer_prod_class_descr) AS SELECT trav_offer_prod_class_cd,
 trav_offer_prod_class_cd -- DESCR is null in the source view
 AS trav_offer_prod_class_descr
FROM ldl_dig_lec_share.v_dim_travel_offer_product_classification_core_view_1
UNION ALL
SELECT '-1',
 '';