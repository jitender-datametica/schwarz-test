CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_promotion_sales_cluster_cum_1 AS SELECT A.promo_sale_cluster_cd,
 A.promo_sale_cluster_descr AS promo_sale_cluster_desc,
 A.last_week_nr,
 B.promo_sale_cluster_cd AS cum_promo_sale_cluster_cd,
 B.promo_sale_cluster_descr AS cum_promo_sale_cluster_desc,
 B.last_week_nr AS cum_last_week_nr
FROM ldl_dig_fe_mstr_lidldigital.v_dim_promotion_sales_cluster_1 AS A
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_promotion_sales_cluster_1 AS B ON A.promo_sale_cluster_cd >= B.promo_sale_cluster_cd
    AND B.promo_sale_cluster_cd <> - 1;