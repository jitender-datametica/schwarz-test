DELETE FROM  ETL_PROCESS.T_PRCS_MAIN;

INSERT INTO ETL_PROCESS.T_PRCS_MAIN (AGGREGATE,DEPENDENCY,ACTIVATE_TMSP) 
VALUES
        ('t_fact_fraud_detection_by_cash_register_event','t_cancellation_line','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event','t_discount_line','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event','t_payment_line','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event','t_price_information_event','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event','t_product_retail_line','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event','t_retail_event','2020-01-01 00:00:00.000'),
        ('t_fact_fraud_detection_by_cash_register_event','t_technical_cash_register_event','2020-01-01 00:00:00.000'),
        ('t_fact_retail_by_store_day','t_tcache_fact_retail_by_store_day','2020-01-01 00:00:00.000'),
        ('t_fact_retail_by_store_day_benchmark','t_fact_retail_by_store_day','2020-01-01 00:00:00.000'),
        ('t_fact_retail_by_store_day_product','t_product_retail_line','2020-01-01 00:00:00.000'),
        ('t_fact_turnover_by_store_day','t_tcache_fact_turnover_by_store_day','2020-01-01 00:00:00.000'),
        ('t_fact_turnover_by_store_day_benchmark','t_fact_turnover_by_store_day','2020-01-01 00:00:00.000'),
        ('t_fact_turnover_by_store_day_product','t_product_retail_line','2020-01-01 00:00:00.000'),
        ('t_fact_write_off_by_organization_day_product','t_write_off_event','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day','t_daily_vat_statistics','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day','t_fact_retail_by_store_day_product','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day','t_plan_by_day','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day','t_retail_event','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day','t_revenue_accrual','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_retail_by_store_day','t_revenue_statistics','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day','t_daily_vat_statistics','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day','t_internal_organization','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day','t_plan_by_day','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day','t_product_retail_line','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day','t_product_variant','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day','t_retail_event','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day','t_revenue_accrual','2020-01-01 00:00:00.000'),
        ('t_tcache_fact_turnover_by_store_day','t_revenue_statistics','2020-01-01 00:00:00.000'),
        ('t_tcache_write_off_by_organization_day','t_write_off_event','2020-01-01 00:00:00.000')
;
