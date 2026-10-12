CREATE OR REPLACE VIEW smp_production_insights.v_sales_gtin_article_week_1 (division_id, country_id, cy_week, gtin_id,
gtin_name, article_id, article_id_list, article_parent_id_list, sales_gross_val, sales_piece_qty, store_cnt, gtin_price
, cy_week_start_dt) AS SELECT W.division_id,
 W.country_id,
 W.cy_week,
 W.gtin_id,
 W.gtin_name,
 REPLACE(TO_JSON_STRING(F.VALUE), '"', '') AS article_id,
 W.article_id_list,
 W.article_parent_id_list,
 W.sales_gross_val,
 W.sales_piece_qty,
 W.store_cnt,
 W.gtin_price,
 W.cy_week_start_dt
FROM smp_production_insights.t_sales_gtin_week_1 AS W
 CROSS JOIN UNNEST(UDF_SCHEMA.flatten(PARSE_JSON(TO_JSON_STRING(SPLIT(ARTICLE_ID_LIST, ', '))), '', FALSE, FALSE, 'both'
   )) AS F;