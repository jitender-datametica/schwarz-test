CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_storage_test_result_general AS

WITH base_aggs AS (
    SELECT   
         tr.storage_test_exec_sid 
        ,tr.storage_test_result_grp_sid
        ,grp.storage_test_result_grp_type_cd 
        ,grp.test_week
        
        -- Actual Values (SUM)
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Average_Receipt' THEN tr.actual_val END) AS receipt_avg
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Hours' THEN tr.actual_val END) AS work_time_hr
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.actual_val END) AS sales_net_val
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Piece_Performance' THEN tr.actual_val END) AS sales_qty_work_time
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Receipt_Count' THEN tr.actual_val END) AS receipt_cnt
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Calculation' THEN tr.actual_val END) AS sales_net_val_pv
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Quantity' THEN tr.actual_val END) AS sales_qty_work_time_hr
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Writeoff' THEN tr.actual_val END) AS writeoff_net_val
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Relative_Writeoff' THEN tr.actual_val END) AS writeoff_net_pct
        
        -- Anticipated Values (SUM)
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Average_Receipt' THEN tr.anticipated_val END) AS receipt_avg_contr
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Hours' THEN tr.anticipated_val END) AS work_time_hr_contr
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.anticipated_val END) AS sales_net_val_contr
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Piece_Performance' THEN tr.anticipated_val END) AS sales_qty_work_time_contr
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Receipt_Count' THEN tr.anticipated_val END) AS receipt_cnt_contr
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Calculation' THEN tr.anticipated_val END) AS sales_net_val_pv_contr
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Quantity' THEN tr.anticipated_val END) AS sales_qty_work_time_hr_contr
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Writeoff' THEN tr.anticipated_val END) AS writeoff_net_val_contr
        , SUM(CASE WHEN tr.storage_test_metric_type_cd = 'Relative_Writeoff' THEN tr.anticipated_val END) AS writeoff_net_pct_contr
        
        -- Spread PCT (MAX)
        , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Average_Receipt' THEN tr.spread_pct END) AS receipt_avg_spread
        , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Hours' THEN tr.spread_pct END) AS work_time_hr_spread
        , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Net_Sales' THEN tr.spread_pct END) AS sales_net_val_spread
        , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Piece_Performance' THEN tr.spread_pct END) AS sales_qty_work_time_spread
        , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Receipt_Count' THEN tr.spread_pct END) AS receipt_cnt_spread
        , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Calculation' THEN tr.spread_pct END) AS sales_net_val_pv_spread
        , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Sales_Quantity' THEN tr.spread_pct END) AS sales_qty_work_time_hr_spread
        , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Writeoff' THEN tr.spread_pct END) AS writeoff_net_val_spread
        , MAX(CASE WHEN tr.storage_test_metric_type_cd = 'Relative_Writeoff' THEN tr.spread_pct END) AS writeoff_net_pct_spread

    FROM ldl_p_lew_core.t_storage_test_result tr
    INNER JOIN (
        SELECT 
             storage_test_result_grp_sid
            ,storage_test_result_grp_type_cd 
            ,test_week
        FROM ldl_p_lew_core.t_storage_test_result_group
        WHERE UPPER(storage_test_result_grp_type_cd) = 'GENERAL'
        GROUP BY 1, 2, 3
    ) grp 
        ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
    WHERE tr.storage_test_metric_type_cd IN (
        'Average_Receipt', 'Net_Hours', 'Net_Sales', 'Piece_Performance', 'Receipt_Count', 
        'Sales_Calculation', 'Sales_Quantity', 'Writeoff', 'Relative_Writeoff'
    )
    GROUP BY 1, 2, 3, 4
),

derived_metrics AS (
    SELECT 
        *,
        
        receipt_avg - receipt_avg_contr AS receipt_avg_effect,
        work_time_hr - work_time_hr_contr AS work_time_hr_effect,
        sales_net_val - sales_net_val_contr AS sales_net_val_effect,
        sales_qty_work_time - sales_qty_work_time_contr AS sales_qty_work_time_effect,
        receipt_cnt - receipt_cnt_contr AS receipt_cnt_effect,
        sales_net_val_pv - sales_net_val_pv_contr AS sales_net_val_pv_effect,
        sales_qty_work_time_hr - sales_qty_work_time_hr_contr AS sales_qty_work_time_hr_effect,
        writeoff_net_val - writeoff_net_val_contr AS writeoff_net_val_effect,
        writeoff_net_pct - writeoff_net_pct_contr AS writeoff_net_pct_effect,

        
        sales_net_val_contr * sales_net_val_spread AS sales_net_val_contr_spread,
        sales_net_val_pv_contr * sales_net_val_pv_spread AS sales_net_val_pv_contr_spread,
        sales_qty_work_time_hr_contr * sales_qty_work_time_hr_spread AS sales_qty_work_time_hr_contr_spread,
        receipt_cnt_contr * receipt_cnt_spread AS receipt_cnt_contr_spread,
        receipt_avg_contr * receipt_avg_spread AS receipt_avg_contr_spread,
        work_time_hr_contr * work_time_hr_spread AS work_time_hr_contr_spread,
        sales_qty_work_time_contr * sales_qty_work_time_spread AS sales_qty_work_time_contr_spread,
        writeoff_net_pct_contr * writeoff_net_pct_spread AS writeoff_net_pct_contr_spread,
        writeoff_net_val_contr * writeoff_net_val_spread AS writeoff_net_val_contr_spread
    FROM base_aggs
)

SELECT 
    *,
    
    IF(sales_net_val_spread IS NULL, NULL, sales_net_val_contr + sales_net_val_contr_spread) AS max_sales_net_val_contr_spread,
    IF(sales_net_val_spread IS NULL, NULL, sales_net_val_contr - sales_net_val_contr_spread) AS min_sales_net_val_contr_spread,

    IF(sales_net_val_pv_spread IS NULL, NULL, sales_net_val_pv_contr + sales_net_val_pv_contr_spread) AS max_sales_net_val_pv_contr_spread,
    IF(sales_net_val_pv_spread IS NULL, NULL, sales_net_val_pv_contr - sales_net_val_pv_contr_spread) AS min_sales_net_val_pv_contr_spread,

    IF(sales_qty_work_time_hr_spread IS NULL, NULL, sales_qty_work_time_hr_contr + sales_qty_work_time_hr_contr_spread) AS max_sales_qty_work_time_hr_contr_spread,
    IF(sales_qty_work_time_hr_spread IS NULL, NULL, sales_qty_work_time_hr_contr - sales_qty_work_time_hr_contr_spread) AS min_sales_qty_work_time_hr_contr_spread,

    IF(receipt_cnt_spread IS NULL, NULL, receipt_cnt_contr + receipt_cnt_contr_spread) AS max_receipt_cnt_contr_spread,
    IF(receipt_cnt_spread IS NULL, NULL, receipt_cnt_contr - receipt_cnt_contr_spread) AS min_receipt_cnt_contr_spread,

    IF(receipt_avg_spread IS NULL, NULL, receipt_avg_contr + receipt_avg_contr_spread) AS max_receipt_avg_contr_spread,
    IF(receipt_avg_spread IS NULL, NULL, receipt_avg_contr - receipt_avg_contr_spread) AS min_receipt_avg_contr_spread,

    IF(work_time_hr_spread IS NULL, NULL, work_time_hr_contr + work_time_hr_contr_spread) AS max_work_time_hr_contr_spread,
    IF(work_time_hr_spread IS NULL, NULL, work_time_hr_contr - work_time_hr_contr_spread) AS min_work_time_hr_contr_spread,

    IF(sales_qty_work_time_spread IS NULL, NULL, sales_qty_work_time_contr + sales_qty_work_time_contr_spread) AS max_sales_qty_work_time_contr_spread,
    IF(sales_qty_work_time_spread IS NULL, NULL, sales_qty_work_time_contr - sales_qty_work_time_contr_spread) AS min_sales_qty_work_time_contr_spread,

    IF(writeoff_net_pct_spread IS NULL, NULL, writeoff_net_pct_contr + writeoff_net_pct_contr_spread) AS max_writeoff_net_pct_contr_spread,
    IF(writeoff_net_pct_spread IS NULL, NULL, writeoff_net_pct_contr - writeoff_net_pct_contr_spread) AS min_writeoff_net_pct_contr_spread,

    IF(writeoff_net_val_spread IS NULL, NULL, writeoff_net_val_contr + writeoff_net_val_contr_spread) AS max_writeoff_net_val_contr_spread,
    IF(writeoff_net_val_spread IS NULL, NULL, writeoff_net_val_contr - writeoff_net_val_contr_spread) AS min_writeoff_net_val_contr_spread
    
FROM derived_metrics;