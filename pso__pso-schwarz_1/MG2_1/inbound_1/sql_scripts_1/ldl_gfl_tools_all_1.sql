DELETE FROM  ETL_PROCESS.T_PRCS_MAIN_1;

INSERT INTO ETL_PROCESS.T_PRCS_MAIN_1 (AGGREGATE,DEPENDENCY,ACTIVATE_TMSP) 
VALUES
        ('t_fact_fraud_detection_by_cash_register_event_1','t_cancellation_line_1','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event_1','t_discount_line_1','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event_1','t_payment_line_1','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event_1','t_price_information_event_1','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event_1','t_product_retail_line_1','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event_1','t_retail_event_1','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event_1','t_technical_cash_register_event_1','2020-01-01 00:00:00.000'),
        ('t_fact_retail_by_store_day_1','t_tcache_fact_retail_by_store_day_1','2020-01-01 00:00:00.000'),
        ('t_fact_retail_by_store_day_benchmark_1','t_fact_retail_by_store_day_1','2020-01-01 00:00:00.000'),
        ('t_fact_retail_by_store_day_product_1','t_product_retail_line_1','2020-01-01 00:00:00.000'),
        ('t_fact_turnover_by_store_day','t_tcache_fact_turnover_by_store_day_1','2020-01-01 00:00:00.000'),
        ('t_fact_turnover_by_store_day_benchmark','t_fact_turnover_by_store_day','2020-01-01 00:00:00.000'),
        ('t_fact_turnover_by_store_day_product','t_product_retail_line_1','2020-01-01 00:00:00.000'),
        ('t_fact_write_off_by_organization_day_product_1','t_write_off_event_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day_1','t_daily_vat_statistics_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day_1','t_fact_retail_by_store_day_product_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day_1','t_plan_by_day_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day_1','t_retail_event_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day_1','t_revenue_accrual_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day_1','t_revenue_statistics_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_1','t_daily_vat_statistics_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_1','t_internal_organization_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_1','t_plan_by_day_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_1','t_product_retail_line_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_1','t_product_variant_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_1','t_retail_event_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_1','t_revenue_accrual_1','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_1','t_revenue_statistics_1','2020-01-01 00:00:00.000'),
        ('t_tcache_write_off_by_organization_day_1','t_write_off_event_1','2020-01-01 00:00:00.000')
;
