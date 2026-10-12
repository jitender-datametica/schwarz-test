CREATE OR REPLACE VIEW ldl_dig_core.v_agg_sales_promotion(
  wshop_cd 
    ,prod_sid
    ,promo_start_dt
    ,promo_sale_start_dt 
    ,sale_promo_type_cd 
    ,is_repeated_fg
    ,promo_dur_week_cnt
    ,first_week_start_dt
    ,analysis_start_dt
    ,analysis_end_dt
    ,sale_promo_status_cd
    ,promo_id
    ,tgt_prod_receive_cy_week
    ,first_delivery_cy_week
    ,supplier_order_qty
    ,tgt_prod_sale_qty
    ,is_first_promotion_fg
    ,promo_nr
    ,promo_descr
    ,amc_ian_nr
    ,is_tv_promo_fg
    ,return_cond_descr
    ,is_catalog_promo_fg

)
OPTIONS(DESCRIPTION = `AGGREGATION OF MULTIPLE AMC ROW ENTRIES FOR THE SAME PROMOTION IN A SINGLE ROW`) AS WITH AGGR AS
  (SELECT wshop_cd,
   prod_sid,
   promo_start_dt,
   promo_sale_start_dt,
   sale_promo_type_cd,
   is_repeated_fg,
   promo_dur_week_cnt,
   first_week_start_dt,
   analysis_start_dt,
   analysis_end_dt,
   sale_promo_status_cd,
   promo_id,
   tgt_prod_receive_cy_week,
   first_delivery_cy_week,
   supplier_order_qty,
   tgt_prod_sale_qty,
   MIN(CASE
     WHEN promo_start_dt > DATE(EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2, EXTRACT(MONTH FROM CURRENT_TIMESTAMP()), 1)
      AND is_repeated_fg = CAST('false' AS BOOL)
     THEN promo_start_dt
     ELSE NULL
     END) OVER (PARTITION BY CAST(prod_sid AS STRING), wshop_cd RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS first_date
  FROM (SELECT wshop_cd,
     prod_sid,
     promo_start_dt,
     promo_sale_start_dt,
     sale_promo_type_cd,
     is_repeated_fg,
     promo_dur_week_cnt,
     first_week_start_dt,
     analysis_start_dt,
     analysis_end_dt,
     sale_promo_status_cd,
     MIN(promo_id) AS promo_id,
     MIN(tgt_prod_receive_cy_week) AS tgt_prod_receive_cy_week,
     MIN(first_delivery_cy_week) AS first_delivery_cy_week,
     SUM(supplier_order_qty) AS supplier_order_qty,
     SUM(tgt_prod_sale_qty) AS tgt_prod_sale_qty
    FROM ldl_dig_core.t_dim_sales_promotion
    WHERE dwh_valid_fg
     AND sale_promo_status_cd = 'ACTIVE'
    GROUP BY wshop_cd,
     prod_sid,
     sale_promo_type_cd,
     sale_promo_status_cd,
     promo_start_dt,
     promo_sale_start_dt,
     first_week_start_dt,
     analysis_start_dt,
     analysis_end_dt,
     promo_dur_week_cnt,
     is_repeated_fg) AS t1) (SELECT t3.wshop_cd,
   t3.prod_sid,
   t3.promo_start_dt,
   t3.promo_sale_start_dt,
   t3.sale_promo_type_cd,
   t3.is_repeated_fg,
   t3.promo_dur_week_cnt,
   t3.first_week_start_dt,
   t3.analysis_start_dt,
   t3.analysis_end_dt,
   t3.sale_promo_status_cd,
   t3.promo_id,
   t3.tgt_prod_receive_cy_week,
   t3.first_delivery_cy_week,
   t3.supplier_order_qty,
   t3.tgt_prod_sale_qty,
    CASE
    WHEN t3.promo_start_dt = t3.first_date
    THEN 1
    ELSE 0
    END AS is_first_promotion_fg,
   PROMO.promo_nr,
   PROMO.promo_descr,
   PROMO.amc_ian_nr,
   PROMO.is_tv_promo_fg,
   PROMO.return_cond_descr,
   PROMO.is_catalog_prod_fg
  FROM AGGR AS t3
   INNER JOIN ldl_dig_core.t_dim_sales_promotion AS PROMO ON t3.promo_id = PROMO.promo_id
  WHERE PROMO.dwh_valid_fg
   AND PROMO.sale_promo_status_cd = 'ACTIVE');
