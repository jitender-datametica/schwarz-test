create or replace view SMP_PRODUCTION.INSIGHTS.V_SALES_GTIN_ARTICLE_WEEK(
	DIVISION_ID,
	COUNTRY_ID,
	CY_WEEK,
	GTIN_ID,
	GTIN_NAME,
	ARTICLE_ID,
	ARTICLE_ID_LIST,
	ARTICLE_PARENT_ID_LIST,
	SALES_GROSS_VAL,
	SALES_PIECE_QTY,
	STORE_CNT,
	GTIN_PRICE,
	CY_WEEK_START_DT
) as 
SELECT 
   w.division_id
  ,w.country_id
  ,w.cy_week
  ,w.gtin_id
  ,w.gtin_name
  ,REPLACE(f.VALUE, '"', '') AS article_id
  ,w.article_id_list 
  ,w.article_parent_id_list 
  ,w.sales_gross_val
  ,w.sales_piece_qty
  ,w.store_cnt
  ,w.gtin_price
  ,w.cy_week_start_dt
FROM INSIGHTS.T_SALES_GTIN_WEEK w
, LATERAL FLATTEN (INPUT=>SPLIT(w.article_id_list, ', ')) f
;
