CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_storage_test_result_store_1 (
    client_id,
    storage_test_exec_sid,
    storage_test_result_grp_sid,
    storage_test_result_grp_type_cd,
    orig_store_nr,
    test_week,
    test_week_cnt,
    reconstruction_week,
    reconstructin_week_list_display,
    excluded_week_list_display,
    test_week_list,
    analysis_start_week_fg,
    test_week_header,
    receipt_avg,
    work_time_hr,
    sales_net_val,
    sales_qty_work_time,
    receipt_cnt,
    sales_net_val_pv,
    sales_qty_work_time_hr,
    writeoff_net_val,
    writeoff_net_pct,
    receipt_avg_contr,
    work_time_hr_contr,
    sales_net_val_contr,
    sales_qty_work_time_contr,
    receipt_cnt_contr,
    sales_net_val_pv_contr,
    sales_qty_work_time_hr_contr,
    writeoff_net_val_contr,
    writeoff_net_pct_contr,
    receipt_avg_spread,
    work_time_hr_spread,
    sales_net_val_spread,
    sales_qty_work_time_spread,
    receipt_cnt_spread,
    sales_net_val_pv_spread,
    sales_qty_work_time_hr_spread,
    writeoff_net_val_spread,
    writeoff_net_pct_spread,
    receipt_avg_effect,
    work_time_hr_effect,
    sales_net_val_effect,
    sales_qty_work_time_effect,
    receipt_cnt_effect,
    sales_net_val_pv_effect,
    sales_qty_work_time_hr_effect,
    writeoff_net_val_effect,
    writeoff_net_pct_effect,
    sales_net_val_contr_spread,
    sales_net_val_pv_contr_spread,
    sales_qty_work_time_hr_contr_spread,
    receipt_cnt_contr_spread,
    receipt_avg_contr_spread,
    work_time_hr_contr_spread,
    sales_qty_work_time_contr_spread,
    writeoff_net_pct_contr_spread,
    writeoff_net_val_contr_spread,
    max_sales_net_val_contr_spread,
    min_sales_net_val_contr_spread,
    max_sales_net_val_pv_contr_spread,
    min_sales_net_val_pv_contr_spread,
    max_sales_qty_work_time_hr_contr_spread,
    min_sales_qty_work_time_hr_contr_spread,
    max_receipt_cnt_contr_spread,
    min_receipt_cnt_contr_spread,
    max_receipt_avg_contr_spread,
    min_receipt_avg_contr_spread,
    max_work_time_hr_contr_spread,
    min_work_time_hr_contr_spread,
    max_sales_qty_work_time_contr_spread,
    min_sales_qty_work_time_contr_spread,
    max_writeoff_net_pct_contr_spread,
    min_writeoff_net_pct_contr_spread,
    max_writeoff_net_val_contr_spread,
    min_writeoff_net_val_contr_spread
) AS

WITH grp AS (
    SELECT 
        grp.storage_test_result_grp_sid,
        grp.storage_test_result_grp_type_cd,
        loc.src_orig_store_nr AS orig_store_nr,
        grp.test_week
    FROM ldl_p_lew_core.t_storage_test_result_group_1 grp
    INNER JOIN ldl_p_lew_core.t_location_1 loc 
        ON loc.loc_sid = grp.loc_sid_store
    WHERE UPPER(grp.storage_test_result_grp_type_cd) = 'STORE'
),

src_base AS (
    SELECT 
        ext.client_id,
        tr.storage_test_exec_sid,
        tr.storage_test_result_grp_sid,
        grp.storage_test_result_grp_type_cd,
        grp.orig_store_nr,
        grp.test_week,
        tr.actual_val,
        tr.anticipated_val,
        tr.spread_pct,
        tr.storage_test_metric_type_cd,
        CONCAT(tr.storage_test_metric_type_cd, '_contr') AS storage_test_metric_type_cd1,
        CONCAT(tr.storage_test_metric_type_cd, '_spread') AS storage_test_metric_type_cd2
    FROM ldl_p_lew_core.t_storage_test_result_1 tr
    INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_storage_test_execution_ext_1 ext
        ON tr.storage_test_exec_sid = ext.storage_test_exec_sid
    INNER JOIN grp 
        ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
    WHERE tr.storage_test_metric_type_cd IN (
        'Average_Receipt', 'Net_Hours', 'Net_Sales', 'Piece_Performance', 
        'Receipt_Count', 'Sales_Calculation', 'Sales_Quantity', 'Writeoff', 'Relative_Writeoff'
    )
),

pvt_actual AS (
    SELECT * FROM (
        SELECT client_id, storage_test_exec_sid, storage_test_result_grp_sid, storage_test_result_grp_type_cd, orig_store_nr, test_week, anticipated_val, spread_pct, storage_test_metric_type_cd1, storage_test_metric_type_cd2, actual_val, storage_test_metric_type_cd FROM src_base
    ) PIVOT (
        SUM(actual_val) FOR storage_test_metric_type_cd IN (
            'Average_Receipt' AS average_receipt, 
            'Net_Hours' AS net_hours, 
            'Net_Sales' AS net_sales, 
            'Piece_Performance' AS piece_performance, 
            'Receipt_Count' AS receipt_count,
            'Sales_Calculation' AS sales_calculation, 
            'Sales_Quantity' AS sales_quantity, 
            'Writeoff' AS writeoff, 
            'Relative_Writeoff' AS relative_writeoff
        )
    )
),

pvt_contr AS (
    SELECT * FROM (
        SELECT client_id, storage_test_exec_sid, storage_test_result_grp_sid, storage_test_result_grp_type_cd, orig_store_nr, test_week, spread_pct, storage_test_metric_type_cd2, average_receipt, net_hours, net_sales, piece_performance, receipt_count, sales_calculation, sales_quantity, writeoff, relative_writeoff, anticipated_val, storage_test_metric_type_cd1 FROM pvt_actual
    ) PIVOT (
        SUM(anticipated_val) FOR storage_test_metric_type_cd1 IN (
            'Average_Receipt_contr' AS average_receipt_contr, 
            'Net_Hours_contr' AS net_hours_contr, 
            'Net_Sales_contr' AS net_sales_contr, 
            'Piece_Performance_contr' AS piece_performance_contr, 
            'Receipt_Count_contr' AS receipt_count_contr,
            'Sales_Calculation_contr' AS sales_calculation_contr, 
            'Sales_Quantity_contr' AS sales_quantity_contr, 
            'Writeoff_contr' AS writeoff_contr, 
            'Relative_Writeoff_contr' AS relative_writeoff_contr
        )
    )
),

pvt_final AS (
    SELECT * FROM (
        SELECT client_id, storage_test_exec_sid, storage_test_result_grp_sid, storage_test_result_grp_type_cd, orig_store_nr, test_week, average_receipt, net_hours, net_sales, piece_performance, receipt_count, sales_calculation, sales_quantity, writeoff, relative_writeoff, average_receipt_contr, net_hours_contr, net_sales_contr, piece_performance_contr, receipt_count_contr, sales_calculation_contr, sales_quantity_contr, writeoff_contr, relative_writeoff_contr, spread_pct, storage_test_metric_type_cd2 FROM pvt_contr
    ) PIVOT (
        MAX(spread_pct) FOR storage_test_metric_type_cd2 IN (
            'Average_Receipt_spread' AS average_receipt_spread, 
            'Net_Hours_spread' AS net_hours_spread, 
            'Net_Sales_spread' AS net_sales_spread, 
            'Piece_Performance_spread' AS piece_performance_spread, 
            'Receipt_Count_spread' AS receipt_count_spread,
            'Sales_Calculation_spread' AS sales_calculation_spread, 
            'Sales_Quantity_spread' AS sales_quantity_spread, 
            'Writeoff_spread' AS writeoff_spread, 
            'Relative_Writeoff_spread' AS relative_writeoff_spread
        )
    )
),

pal AS (
    SELECT 
        storage_test_exec_sid,
        orig_store_nr,
        reconstructin_week_list,
        excluded_week_list,
        reconstructin_week_list_display,
        excluded_week_list_display
    FROM ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_parameter_list_1
    GROUP BY 1,2,3,4,5,6
),

paw AS (
    SELECT 
        storage_test_exec_sid,
        orig_store_nr,
        --, reconstruction_week
        test_week_cnt,
        reconstruction_week
    FROM ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_parameter_1
    GROUP BY 1,2,3,4
),

pa AS (
    SELECT 
        storage_test_exec_sid,
        orig_store_nr,
        MAX(reconstruction_week) OVER (PARTITION BY storage_test_exec_sid, orig_store_nr) AS max_reconstruction_week,
        analysis_start_week,
        excluded_week_header
        --,reconstruction_week
    FROM ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_parameter_1
),

ps_src_ordered AS (
    SELECT DISTINCT 
        tr.storage_test_exec_sid,
        grp.orig_store_nr,
        grp.storage_test_result_grp_sid,
        grp.storage_test_result_grp_type_cd,
        grp.test_week
    FROM ldl_p_lew_core.t_storage_test_result_1 tr
    INNER JOIN (
        SELECT 
            g.storage_test_result_grp_sid,
            l.src_orig_store_nr AS orig_store_nr,
            g.storage_test_result_grp_type_cd,
            g.test_week
        FROM ldl_p_lew_core.t_storage_test_result_group_1 g
        INNER JOIN ldl_p_lew_core.t_location_1 l 
            ON l.loc_sid = g.loc_sid_store
        WHERE UPPER(g.storage_test_result_grp_type_cd) = 'STORE'
          AND g.test_week <> -1
        GROUP BY 1,2,3,4
    ) grp ON grp.storage_test_result_grp_sid = tr.storage_test_result_grp_sid
),

ps AS (
    SELECT 
        src.storage_test_exec_sid,
        src.orig_store_nr,
        STRING_AGG(CONCAT('KW', ' ', SUBSTR(CAST(src.test_week AS STRING), 5), ' ', SUBSTR(CAST(src.test_week AS STRING), 1, 4)), ',' ORDER BY src.storage_test_exec_sid, src.orig_store_nr, src.test_week) AS d_test_week_list
    FROM ps_src_ordered src
    INNER JOIN (
        SELECT 
            storage_test_exec_sid,
            orig_store_nr,
            MAX(reconstruction_week) OVER (PARTITION BY storage_test_exec_sid, orig_store_nr) AS max_reconstruction_week,
            analysis_start_week,
            excluded_week_header
        FROM ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_parameter_1
    ) param
        ON src.storage_test_exec_sid = param.storage_test_exec_sid
       AND src.orig_store_nr = param.orig_store_nr
       AND src.test_week > param.max_reconstruction_week 
       AND src.test_week < CAST(param.analysis_start_week AS INT64)
    GROUP BY 1,2
)

SELECT  
    pvt1.client_id,
    pvt1.storage_test_exec_sid,
    pvt1.storage_test_result_grp_sid,
    pvt1.storage_test_result_grp_type_cd,
    pvt1.orig_store_nr,
    pvt1.test_week,
    paw.test_week_cnt,
    paw.reconstruction_week,
    pal.reconstructin_week_list_display,
    pal.excluded_week_list_display,
    CASE WHEN ps.d_test_week_list IS NOT NULL THEN ps.d_test_week_list ELSE 'Keine' END AS test_week_list,
    CASE WHEN pvt1.test_week >= CAST(pa.analysis_start_week AS INT64) THEN 1 ELSE 0 END AS analysis_start_week_fg,
    CASE 
        WHEN COALESCE(ps.d_test_week_list, 'Keine') = 'Keine' AND pal.excluded_week_list_display = 'Keine' THEN 'Keine'
        WHEN COALESCE(ps.d_test_week_list, 'Keine') = 'Keine' AND pal.excluded_week_list_display <> 'Keine' THEN pal.excluded_week_list_display || ''
        WHEN COALESCE(ps.d_test_week_list, 'Keine') <> 'Keine' AND pal.excluded_week_list_display = 'Keine' THEN ps.d_test_week_list 
        ELSE CONCAT(pal.excluded_week_list_display, ',', ps.d_test_week_list)  
    END AS test_week_header,
    
    MAX(pvt1.average_receipt) AS receipt_avg,
    MAX(pvt1.net_hours) AS work_time_hr,
    MAX(pvt1.net_sales) AS sales_net_val,
    MAX(pvt1.piece_performance) AS sales_qty_work_time,
    MAX(pvt1.receipt_count) AS receipt_cnt,
    MAX(pvt1.sales_calculation) AS sales_net_val_pv,
    MAX(pvt1.sales_quantity) AS sales_qty_work_time_hr,
    MAX(pvt1.writeoff) AS writeoff_net_val,
    MAX(pvt1.relative_writeoff) AS writeoff_net_pct,
    
    MAX(pvt1.average_receipt_contr) AS receipt_avg_contr,
    MAX(pvt1.net_hours_contr) AS work_time_hr_contr,
    MAX(pvt1.net_sales_contr) AS sales_net_val_contr,
    MAX(pvt1.piece_performance_contr) AS sales_qty_work_time_contr,
    MAX(pvt1.receipt_count_contr) AS receipt_cnt_contr,
    MAX(pvt1.sales_calculation_contr) AS sales_net_val_pv_contr,
    MAX(pvt1.sales_quantity_contr) AS sales_qty_work_time_hr_contr,
    MAX(pvt1.writeoff_contr) AS writeoff_net_val_contr,
    MAX(pvt1.relative_writeoff_contr) AS writeoff_net_pct_contr,
    
    MAX(pvt1.average_receipt_spread) AS receipt_avg_spread,
    MAX(pvt1.net_hours_spread) AS work_time_hr_spread,
    MAX(pvt1.net_sales_spread) AS sales_net_val_spread,
    MAX(pvt1.piece_performance_spread) AS sales_qty_work_time_spread,
    MAX(pvt1.receipt_count_spread) AS receipt_cnt_spread,
    MAX(pvt1.sales_calculation_spread) AS sales_net_val_pv_spread,
    MAX(pvt1.sales_quantity_spread) AS sales_qty_work_time_hr_spread,
    MAX(pvt1.writeoff_spread) AS writeoff_net_val_spread,
    MAX(pvt1.relative_writeoff_spread) AS writeoff_net_pct_spread,  

    MAX(pvt1.average_receipt) - MAX(pvt1.average_receipt_contr) AS receipt_avg_effect,
    MAX(pvt1.net_hours) - MAX(pvt1.net_hours_contr) AS work_time_hr_effect,
    MAX(pvt1.net_sales) - MAX(pvt1.net_sales_contr) AS sales_net_val_effect,
    MAX(pvt1.piece_performance) - MAX(pvt1.piece_performance_contr) AS sales_qty_work_time_effect,
    MAX(pvt1.receipt_count) - MAX(pvt1.receipt_count_contr) AS receipt_cnt_effect,
    MAX(pvt1.sales_calculation) - MAX(pvt1.sales_calculation_contr) AS sales_net_val_pv_effect,
    MAX(pvt1.sales_quantity) - MAX(pvt1.sales_quantity_contr) AS sales_qty_work_time_hr_effect,
    MAX(pvt1.writeoff) - MAX(pvt1.writeoff_contr) AS writeoff_net_val_effect,
    MAX(pvt1.relative_writeoff) - MAX(pvt1.relative_writeoff_contr) AS writeoff_net_pct_effect,
 
    MAX(pvt1.net_sales_contr) * MAX(pvt1.net_sales_spread) AS sales_net_val_contr_spread,
    MAX(pvt1.sales_calculation_contr) * MAX(pvt1.sales_calculation_spread) AS sales_net_val_pv_contr_spread,
    MAX(pvt1.sales_quantity_contr) * MAX(pvt1.sales_quantity_spread) AS sales_qty_work_time_hr_contr_spread,
    MAX(pvt1.receipt_count_contr) * MAX(pvt1.receipt_count_spread) AS receipt_cnt_contr_spread,
    MAX(pvt1.average_receipt_contr) * MAX(pvt1.average_receipt_spread) AS receipt_avg_contr_spread,
    MAX(pvt1.net_hours_contr) * MAX(pvt1.net_hours_spread) AS work_time_hr_contr_spread,
    MAX(pvt1.piece_performance_contr) * MAX(pvt1.piece_performance_spread) AS sales_qty_work_time_contr_spread,
    MAX(pvt1.relative_writeoff_contr) * MAX(pvt1.relative_writeoff_spread) AS writeoff_net_pct_contr_spread,
    MAX(pvt1.writeoff_contr) * MAX(pvt1.writeoff_spread) AS writeoff_net_val_contr_spread,

    CASE WHEN MAX(pvt1.net_sales_spread) IS NULL THEN NULL ELSE MAX(pvt1.net_sales_contr) + (MAX(pvt1.net_sales_contr) * MAX(pvt1.net_sales_spread)) END AS max_sales_net_val_contr_spread,
    CASE WHEN MAX(pvt1.net_sales_spread) IS NULL THEN NULL ELSE MAX(pvt1.net_sales_contr) - (MAX(pvt1.net_sales_contr) * MAX(pvt1.net_sales_spread)) END AS min_sales_net_val_contr_spread,
    CASE WHEN MAX(pvt1.sales_calculation_spread) IS NULL THEN NULL ELSE MAX(pvt1.sales_calculation_contr) + (MAX(pvt1.sales_calculation_contr) * MAX(pvt1.sales_calculation_spread)) END AS max_sales_net_val_pv_contr_spread,
    CASE WHEN MAX(pvt1.sales_calculation_spread) IS NULL THEN NULL ELSE MAX(pvt1.sales_calculation_contr) - (MAX(pvt1.sales_calculation_contr) * MAX(pvt1.sales_calculation_spread)) END AS min_sales_net_val_pv_contr_spread,
    CASE WHEN MAX(pvt1.sales_quantity_spread) IS NULL THEN NULL ELSE MAX(pvt1.sales_quantity_contr) + (MAX(pvt1.sales_quantity_contr) * MAX(pvt1.sales_quantity_spread)) END AS max_sales_qty_work_time_hr_contr_spread,
    CASE WHEN MAX(pvt1.sales_quantity_spread) IS NULL THEN NULL ELSE MAX(pvt1.sales_quantity_contr) - (MAX(pvt1.sales_quantity_contr) * MAX(pvt1.sales_quantity_spread)) END AS min_sales_qty_work_time_hr_contr_spread,
    CASE WHEN MAX(pvt1.receipt_count_spread) IS NULL THEN NULL ELSE MAX(pvt1.receipt_count_contr) + (MAX(pvt1.receipt_count_contr) * MAX(pvt1.receipt_count_spread)) END AS max_receipt_cnt_contr_spread,
    CASE WHEN MAX(pvt1.receipt_count_spread) IS NULL THEN NULL ELSE MAX(pvt1.receipt_count_contr) - (MAX(pvt1.receipt_count_contr) * MAX(pvt1.receipt_count_spread)) END AS min_receipt_cnt_contr_spread,
    CASE WHEN MAX(pvt1.average_receipt_spread) IS NULL THEN NULL ELSE MAX(pvt1.average_receipt_contr) + (MAX(pvt1.average_receipt_contr) * MAX(pvt1.average_receipt_spread)) END AS max_receipt_avg_contr_spread,
    CASE WHEN MAX(pvt1.average_receipt_spread) IS NULL THEN NULL ELSE MAX(pvt1.average_receipt_contr) - (MAX(pvt1.average_receipt_contr) * MAX(pvt1.average_receipt_spread)) END AS min_receipt_avg_contr_spread,
    CASE WHEN MAX(pvt1.net_hours_spread) IS NULL THEN NULL ELSE MAX(pvt1.net_hours_contr) + (MAX(pvt1.net_hours_contr) * MAX(pvt1.net_hours_spread)) END AS max_work_time_hr_contr_spread,
    CASE WHEN MAX(pvt1.net_hours_spread) IS NULL THEN NULL ELSE MAX(pvt1.net_hours_contr) - (MAX(pvt1.net_hours_contr) * MAX(pvt1.net_hours_spread)) END AS min_work_time_hr_contr_spread,
    CASE WHEN MAX(pvt1.piece_performance_spread) IS NULL THEN NULL ELSE MAX(pvt1.piece_performance_contr) + (MAX(pvt1.piece_performance_contr) * MAX(pvt1.piece_performance_spread)) END AS max_sales_qty_work_time_contr_spread,
    CASE WHEN MAX(pvt1.piece_performance_spread) IS NULL THEN NULL ELSE MAX(pvt1.piece_performance_contr) - (MAX(pvt1.piece_performance_contr) * MAX(pvt1.piece_performance_spread)) END AS min_sales_qty_work_time_contr_spread,
    CASE WHEN MAX(pvt1.relative_writeoff_spread) IS NULL THEN NULL ELSE MAX(pvt1.relative_writeoff_contr) + (MAX(pvt1.relative_writeoff_contr) * MAX(pvt1.relative_writeoff_spread)) END AS max_writeoff_net_pct_contr_spread,
    CASE WHEN MAX(pvt1.relative_writeoff_spread) IS NULL THEN NULL ELSE MAX(pvt1.relative_writeoff_contr) - (MAX(pvt1.relative_writeoff_contr) * MAX(pvt1.relative_writeoff_spread)) END AS min_writeoff_net_pct_contr_spread,
    CASE WHEN MAX(pvt1.writeoff_spread) IS NULL THEN NULL ELSE MAX(pvt1.writeoff_contr) + (MAX(pvt1.writeoff_contr) * MAX(pvt1.writeoff_spread)) END AS max_writeoff_net_val_contr_spread,
    CASE WHEN MAX(pvt1.writeoff_spread) IS NULL THEN NULL ELSE MAX(pvt1.writeoff_contr) - (MAX(pvt1.writeoff_contr) * MAX(pvt1.writeoff_spread)) END AS min_writeoff_net_val_contr_spread

FROM pvt_final AS pvt1
LEFT JOIN pal
    ON pvt1.storage_test_exec_sid = pal.storage_test_exec_sid
   AND pvt1.orig_store_nr = pal.orig_store_nr
LEFT JOIN paw
    ON pvt1.storage_test_exec_sid = paw.storage_test_exec_sid
   AND pvt1.orig_store_nr = paw.orig_store_nr
LEFT JOIN pa
    ON pvt1.storage_test_exec_sid = pa.storage_test_exec_sid
   AND pvt1.orig_store_nr = pa.orig_store_nr
LEFT JOIN ps
    ON pvt1.storage_test_exec_sid = ps.storage_test_exec_sid
   AND pvt1.orig_store_nr = ps.orig_store_nr
GROUP BY pvt1.client_id
        ,pvt1.storage_test_exec_sid 
        ,pvt1.storage_test_result_grp_sid
        ,pvt1.storage_test_result_grp_type_cd 
        ,pvt1.orig_store_nr
        ,pvt1.test_week
        ,paw.test_week_cnt
        ,paw.reconstruction_week
        ,pal.reconstructin_week_list_display
        ,pal.excluded_week_list_display
        ,ps.d_test_week_list
        ,pa.analysis_start_week;