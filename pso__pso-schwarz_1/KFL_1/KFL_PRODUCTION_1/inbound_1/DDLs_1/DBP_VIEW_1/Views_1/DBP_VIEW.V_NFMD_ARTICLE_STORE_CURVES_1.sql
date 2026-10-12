create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_NFMD_ARTICLE_STORE_CURVES_1(
	MANDANT_ID,
	AKTION_ID,
	ART_ID,
	WUP_ID,
	WRG_ID,
	WG_ID,
	KJWO_WW,
	CURVE_WEEK_NR,
	PROMO_START_DT,
	SELLING_PRICE_GROSS_LOCAL_VAL,
	STOCK_INITIAL_CNT,
	WEEKLY_SALES_CNT,
	CUMULATED_SALES_CNT,
	WEEKLY_REVENUE_GROSS_LOCAL_VAL,
	WEEKLY_SELL_RATE,
	WEEKLY_PRICE_RATE,
	MODEL_EXECUTION_TMSP,
	AI_MODEL_ID
) as 
    SELECT 
        mandant_id
        ,aktion_id
        ,art_id
        ,wup_id
        ,wrg_id
        ,wg_id
        ,kjwo_ww
        ,curve_week_nr
        ,promo_start_dt
        ,selling_price_gross_local_val
        ,stock_initial_cnt
        ,weekly_sales_cnt
        ,cumulated_sales_cnt
        ,weekly_revenue_gross_local_val
        ,weekly_sell_rate
        ,weekly_price_rate
        ,model_execution_tmsp
        ,ai_model_id


FROM DBP_DATA.nfmd_article_store_curves_1 ;
