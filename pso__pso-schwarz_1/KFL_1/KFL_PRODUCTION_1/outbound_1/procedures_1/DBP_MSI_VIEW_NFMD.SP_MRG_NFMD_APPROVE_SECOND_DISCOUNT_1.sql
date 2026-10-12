CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_mrg_nfmd_approve_second_discount(IN P_KJWO_WW FLOAT64, IN P_MANDANT_ID FLOAT64, IN P_USER_ID STRING)
BEGIN
DECLARE sql_check STRING;
DECLARE stmt_check STRING;
DECLARE check ARRAY<JSON>;
DECLARE check_val STRING;
DECLARE sql_date_check STRING;
DECLARE stmt_date_check STRING;
DECLARE date_check ARRAY<JSON>;
DECLARE date_check_val STRING;
DECLARE iterator_check INT64 DEFAULT -1;
DECLARE iterator_date_check INT64 DEFAULT -1;
DECLARE sql_stmt STRING;
DECLARE stmt STRING;
DECLARE sql_stmt2 STRING;
DECLARE stmt2 STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_check  =  '''SELECT COUNT(1) AS A11860  FROM (SELECT mandant_id,    kjwo_ww,    aktion_id,    promo_start_dt,    selling_price_gross_local_val,    wrg_id,    promo_stores_cnt,    wup_id,    art_id,    discount_type_name,    second_discount_start_dt,    second_discount_end_dt,    wg_id,    stock_initial_cnt,    sales_promo_week_cnt,    promo_week_sell_rate,    sell_ratio_wk12,    sell_ratio_wk123,    sales_total_cnt,    current_sell_rate,    remaining_stock_cnt,    current_discount_rate,    current_week_nr,    remaining_weeks_cnt,    revenue_last_week_gross_local_val,    total_revenue_gross_local_val,    src_model_price_gross_local_val,    model_execution_tmsp,    art_warenwert,    sap_transfer_date,    submitted_date,    helper_last_manual,    last_manual_price,    previous_submitted_valid_from,    last_manual_updated_date,    last_manual_valid_from,    valid_from,    nb_of_markdowns,    helper_md_price,    helper_manual_price,    md_discount_opt,    md_price_opt,    manual_markdown_percentage,    manual_markdown_price,    manual_comment,    id40_submitted_price,    purchasing_price,    rohertrag,    previous_submitted_price,    article_cluster_id,    curve_type_cd,    rule_created_dt,    is_in_experiment_fg,    experiment_group_cd,    experiment_stores_cnt,    display_art_id,    rule_decision_record,    vk_netto,    umsatz_netto,    manual_markdown_price_netto,    checkbox_zr_default   FROM dbp_msi_view_nfmd.mv_nfmd_article_store_scorecard_1   WHERE kjwo_ww = @P_KJWO_WW    AND mandant_id = @P_MANDANT_ID    AND discount_type_name = "second_discount"    AND (manual_markdown_price > selling_price_gross_local_val OR (manual_markdown_price IS NULL OR manual_markdown_price           <= 0) OR previous_submitted_price IS NOT NULL AND ROUND(manual_markdown_price, 2) > previous_submitted_price)   LIMIT 1) AS t0 ''';
SET stmt_check  =  sql_check;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'A11860',  stmt_check)
INTO check  USING P_KJWO_WW AS P_KJWO_WW,  P_MANDANT_ID AS P_MANDANT_ID;
SET iterator_check  =  iterator_check  + 1;
SET check_val  =  JSON_EXTRACT_SCALAR(check[SAFE_OFFSET(iterator_check)], '$[0]');
SET sql_date_check  =  '''SELECT COUNT(1) AS A11860 FROM (SELECT FVIEW.mandant_id,    FVIEW.kjwo_ww,    FVIEW.aktion_id,    FVIEW.promo_start_dt,    FVIEW.selling_price_gross_local_val,    FVIEW.wrg_id,    FVIEW.promo_stores_cnt,    FVIEW.wup_id,    FVIEW.art_id,    FVIEW.discount_type_name,    FVIEW.second_discount_start_dt,    FVIEW.second_discount_end_dt,    FVIEW.wg_id,    FVIEW.stock_initial_cnt,    FVIEW.sales_promo_week_cnt,    FVIEW.promo_week_sell_rate,    FVIEW.sell_ratio_wk12,    FVIEW.sell_ratio_wk123,    FVIEW.sales_total_cnt,    FVIEW.current_sell_rate,    FVIEW.remaining_stock_cnt,    FVIEW.current_discount_rate,    FVIEW.current_week_nr,    FVIEW.remaining_weeks_cnt,    FVIEW.revenue_last_week_gross_local_val,    FVIEW.total_revenue_gross_local_val,    FVIEW.src_model_price_gross_local_val,    FVIEW.model_execution_tmsp,    FVIEW.art_warenwert,    FVIEW.sap_transfer_date,    FVIEW.submitted_date,    FVIEW.helper_last_manual,    FVIEW.last_manual_price,    FVIEW.previous_submitted_valid_from,    FVIEW.last_manual_updated_date,    FVIEW.last_manual_valid_from,    FVIEW.valid_from,    FVIEW.nb_of_markdowns,    FVIEW.helper_md_price,    FVIEW.helper_manual_price,    FVIEW.md_discount_opt,    FVIEW.md_price_opt,    FVIEW.manual_markdown_percentage,    FVIEW.manual_markdown_price,    FVIEW.manual_comment,    FVIEW.id40_submitted_price,    FVIEW.purchasing_price,    FVIEW.rohertrag,    FVIEW.previous_submitted_price,    FVIEW.article_cluster_id,    FVIEW.curve_type_cd,    FVIEW.rule_created_dt,    FVIEW.is_in_experiment_fg,    FVIEW.experiment_group_cd,    FVIEW.experiment_stores_cnt,    FVIEW.display_art_id,    FVIEW.rule_decision_record,    FVIEW.vk_netto,    FVIEW.umsatz_netto,    FVIEW.manual_markdown_price_netto,    FVIEW.checkbox_zr_default,    PRMS.mandant_id AS mandant_id0,    PRMS.dwh_created_tmsp,    PRMS.discount_steps,    PRMS.min_discount_pct,    PRMS.max_discount_pct,    PRMS.wrg_id AS wrg_id0,    PRMS.min_price_gross_local_val,    PRMS.no_touch_days_cnt,    PRMS.min_days_btw_discounts_cnt,    PRMS.max_days_btw_discounts_cnt,    PRMS.discount_day_of_week,    PRMS.validity_days_cnt,    PRMS.price_ending_threshold,    PRMS.max_discount_for_max_price_pct,    PRMS.max_price_for_max_discount,    PRMS.discount_type_fg,    PRMS.promo_lifecycle_weeks_cnt,    PRMS.experiment_cohorts_cnt,    PRMS.experiments_for_manual_evaluation_cnt,    PRMS.success_write_off_threshold,    PRMS.success_cohorts_threshold,    PRMS.export_day_of_week,    PRMS.apply_price_rounding_fg,    PRMS.frontend_data_retention_period_weeks_cnt,    PRMS.second_discount_pct,    PRMS.second_discount_validity_wks_cnt,    PRMS.second_discount_lifecycle_weeks_cnt,    PRMS.td_update,    PRMS.td_insert   FROM dbp_msi_view_nfmd.mv_nfmd_article_store_scorecard_1 AS FVIEW    INNER JOIN dbp_data.nfmd_parameter_1 AS PRMS ON FVIEW.mandant_id = PRMS.mandant_id   WHERE FVIEW.kjwo_ww = @P_KJWO_WW    AND FVIEW.mandant_id = @P_MANDANT_ID    AND FVIEW.discount_type_name = "second_discount"    AND (FVIEW.remaining_stock_cnt > 0 OR @P_MANDANT_ID = 5)    AND CAST(FVIEW.valid_from AS DATE) NOT BETWEEN UDF_SCHEMA.NEXT_DAY_BQ(CURRENT_DATE("Europe/Berlin"), PRMS.discount_day_of_week) AND (IF(CURRENT_DATE("Europe/Berlin") = LAST_DAY(CURRENT_DATE("Europe/Berlin")), LAST_DAY(DATE_ADD(CURRENT_DATE("Europe/Berlin")         ,INTERVAL 3 MONTH)), DATE_ADD(CURRENT_DATE("Europe/Berlin"), INTERVAL 3 MONTH)))   LIMIT 1) AS t0 ''';
SET stmt_date_check  =  sql_date_check;

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'A11860',  stmt_date_check)
INTO date_check  USING P_KJWO_WW AS P_KJWO_WW,  P_MANDANT_ID AS P_MANDANT_ID;
SET iterator_date_check  =  iterator_date_check  + 1;
SET date_check_val  =  JSON_EXTRACT_SCALAR(date_check[SAFE_OFFSET(iterator_date_check)], '$[0]');

IF CAST(check_val AS FLOAT64) = 0 AND CAST(date_check_val AS FLOAT64) = 0 THEN
    BEGIN
    SET sql_stmt  = '''
MERGE INTO dbp_msi_view_nfmd.ts_nfmd_manual_price_release_1 AS F 
USING (
    SELECT 
        *, 
        (SELECT MAX(COALESCE(V2.execution_tmsp, CAST("1900-01-01 00:00:00" AS DATETIME))) 
         FROM dbp_view.v_mandant_1 AS V1 
         LEFT JOIN dbp_view.v_nfmd_pipeline_export_log_1 AS V2 ON V1.mandant_id = V2.mandant_id 
         WHERE V1.mandant_id = @P_MANDANT_ID) AS last_sap_transper_tmsp
    FROM dbp_msi_view_nfmd.mv_nfmd_article_store_scorecard_1
) AS WB 
ON F.kjwo_ww = WB.kjwo_ww 
    AND F.mandant_id = WB.mandant_id 
    AND F.art_id = WB.art_id 
    AND F.wup_id = WB.wup_id 
    AND COALESCE(F.last_transfer_tmsp, CAST("1900-01-01 00:00:00" AS DATETIME)) = WB.last_sap_transper_tmsp 
    AND WB.discount_type_name = "second_discount" 
    AND (WB.remaining_stock_cnt > 0 OR @P_MANDANT_ID = 5) 

WHEN MATCHED 
    AND WB.kjwo_ww = @P_KJWO_WW 
    AND WB.mandant_id = @P_MANDANT_ID 
    AND ROUND(WB.manual_markdown_price, 2) < COALESCE(WB.previous_submitted_price, ROUND(WB.selling_price_gross_local_val, 2)) 
    AND (F.manual_promo_price_gross_local_val <> ROUND(WB.manual_markdown_price, 2) OR CAST(WB.valid_from AS DATE) <> F.manual_promo_price_dt) 
    AND WB.last_manual_price IS NOT NULL 
    THEN UPDATE SET  
        dwh_created_tmsp = CAST(CURRENT_TIMESTAMP() AS DATETIME),  
        user_id = @P_USER_ID,  
        wrg_id = WB.wrg_id,  
        manual_promo_price_gross_local_val = CAST(ROUND(WB.manual_markdown_price, 2) AS NUMERIC),  
        manual_promo_price_dt = CAST(WB.valid_from AS DATE),  
        model_price_gross_local_val = CAST(WB.src_model_price_gross_local_val AS NUMERIC),  
        discount_type_name = WB.discount_type_name 

WHEN MATCHED 
    AND WB.kjwo_ww = @P_KJWO_WW 
    AND WB.mandant_id = @P_MANDANT_ID 
    AND ROUND(WB.manual_markdown_price, 2) = COALESCE(WB.previous_submitted_price, ROUND(WB.selling_price_gross_local_val, 2)) 
    AND (F.manual_promo_price_gross_local_val <> ROUND(WB.manual_markdown_price, 2) OR CAST(WB.valid_from AS DATE) <> F.manual_promo_price_dt) 
    THEN DELETE 

WHEN NOT MATCHED THEN INSERT (
    mandant_id, aktion_id, art_id, wup_id, discount_type_name, kjwo_ww, wrg_id,  
    manual_promo_price_gross_local_val, model_price_gross_local_val, manual_promo_price_dt, last_transfer_tmsp, user_id,  
    dwh_created_tmsp
) VALUES (
    CAST(WB.mandant_id AS INTEGER), WB.aktion_id, CAST(WB.art_id AS INTEGER), CAST(WB.wup_id AS INTEGER), 
    WB.discount_type_name, CAST(WB.kjwo_ww AS INTEGER), WB.wrg_id, CAST(WB.manual_markdown_price AS NUMERIC), 
    CAST(WB.src_model_price_gross_local_val AS NUMERIC), CAST(WB.valid_from AS DATE), 
    (SELECT MAX(execution_tmsp) FROM dbp_view.v_nfmd_pipeline_export_log_1 WHERE mandant_id = @P_MANDANT_ID), 
    @P_USER_ID, CAST(CURRENT_TIMESTAMP() AS DATETIME)
)
''';
  

    EXECUTE IMMEDIATE (sql_stmt) USING P_KJWO_WW AS P_KJWO_WW,  P_MANDANT_ID AS P_MANDANT_ID,  P_USER_ID AS P_USER_ID;

    SET sql_stmt2  =  '''INSERT INTO dbp_msi_view_nfmd.ts_nfmd_manual_price_release_log_1 (mandant_id, dwh_created_tmsp, kjwo_ww,  user_id) (SELECT CAST(@P_MANDANT_ID AS INTEGER) AS mandant_id,   CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_tmsp,   CAST(@P_KJWO_WW AS INTEGER) AS kjwo_ww,   @P_USER_ID AS user_id) ''';
    SET stmt2  =  sql_stmt2;

    EXECUTE IMMEDIATE (stmt2) USING P_KJWO_WW AS P_KJWO_WW,  P_MANDANT_ID AS P_MANDANT_ID,  P_USER_ID AS P_USER_ID;

    SET sql_commit  =  'COMMIT TRANSACTION'    ;

    EXECUTE IMMEDIATE (sql_commit);
    END;
ELSE
    BEGIN
    RAISE USING MESSAGE = 'A price is null, zero, negative, higher than the inital price, higher than the previous submitted and loaded price or a valid from date is incorrect';
    END;
END IF;

END;




