DELETE FROM  ETL_PROCESS.T_PRCS_MAIN_2;

INSERT INTO ETL_PROCESS.T_PRCS_MAIN_2 (AGGREGATE,DEPENDENCY,ACTIVATE_TMSP) 
VALUES
        ('t_fact_fraud_detection_by_cash_register_event_2','t_cancellation_line_2','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event_2','t_discount_line_2','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event_2','t_payment_line_2','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event_2','t_price_information_event_2','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event_2','t_product_retail_line_2','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event_2','t_retail_event_2','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event_2','t_technical_cash_register_event_2','2020-01-01 00:00:00.000'),
        ('t_fact_retail_by_store_day_2','t_tcache_fact_retail_by_store_day_2','2020-01-01 00:00:00.000'),
        ('t_fact_retail_by_store_day_benchmark_2','t_fact_retail_by_store_day_2','2020-01-01 00:00:00.000'),
        ('t_fact_retail_by_store_day_product_2','t_product_retail_line_2','2020-01-01 00:00:00.000'),
        ('t_fact_turnover_by_store_day','t_tcache_fact_turnover_by_store_day_2','2020-01-01 00:00:00.000'),
        ('t_fact_turnover_by_store_day_benchmark','t_fact_turnover_by_store_day','2020-01-01 00:00:00.000'),
        ('t_fact_turnover_by_store_day_product','t_product_retail_line_2','2020-01-01 00:00:00.000'),
        ('t_fact_write_off_by_organization_day_product_2','t_write_off_event_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day_2','t_daily_vat_statistics_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day_2','t_fact_retail_by_store_day_product_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day_2','t_plan_by_day_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day_2','t_retail_event_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day_2','t_revenue_accrual_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day_2','t_revenue_statistics_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_2','t_daily_vat_statistics_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_2','t_internal_organization_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_2','t_plan_by_day_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_2','t_product_retail_line_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_2','t_product_variant_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_2','t_retail_event_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_2','t_revenue_accrual_2','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day_2','t_revenue_statistics_2','2020-01-01 00:00:00.000'),
        ('t_tcache_write_off_by_organization_day_2','t_write_off_event_2','2020-01-01 00:00:00.000')
;
