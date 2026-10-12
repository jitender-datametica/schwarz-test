CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_cash_register_print_scenario_multi_lang_2 AS WITH
 cte_cls_rel_cash_register AS (SELECT t1.cash_register_event_sid_ow AS cash_register_event_sid,
    t1.scenario_id,
    t1.cust_sid,
    t1.cust_ident_type_cd,
    t1.cash_register_event_nr,
    t1.cashier_nr,
    t1.bus_dt,
    t1.store_sid,
    t1.country_org_cd,
    t1.rel_cash_register_event_sid,
    t1.rel_bus_dt,
    t1.cash_register_event_rel_type_cd
   FROM (SELECT DISTINCT MAX(CASE
        WHEN rel.cash_register_event_rel_type_cd = 'SUCCESSOR'
        THEN rel.rel_cash_register_event_sid
        ELSE 0
        END) OVER (PARTITION BY rel.cash_register_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
      AS cash_register_event_sid_ow,
      cls.scenario_id,
      cls.cust_sid,
      cls.cust_ident_type_cd,
      ROUND(CAST(RIGHT(SUBSTR(CAST(MAX(CASE
             WHEN rel.cash_register_event_rel_type_cd = 'SUCCESSOR'
             THEN rel.rel_cash_register_event_sid
             ELSE 0
             END) OVER (PARTITION BY rel.cash_register_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING), 1, 10), 10) AS BIGNUMERIC)
       , 0) AS cash_register_event_nr,
      cls.cashier_nr,
      cls.bus_dt,
      cls.store_sid,
      cls.country_org_cd,
       CASE
       WHEN rel.cash_register_event_rel_type_cd = 'SELF'
       THEN rel.cash_register_event_sid
       ELSE rel.rel_cash_register_event_sid
       END AS rel_cash_register_event_sid,
      rel.rel_bus_dt,
      rel.cash_register_event_rel_type_cd
     FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship_2 AS rel
      INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_2 AS cls ON rel.bus_dt
         = cls.bus_dt AND rel.country_org_cd = cls.country_org_cd AND rel.cash_register_event_sid = cls.cash_register_event_sid
        
     WHERE cls.scenario_id IN (6, 60100, 60200, 60300)
      AND rel.cash_register_event_rel_type_cd IN ('SELF', 'SUCCESSOR', 'EVENT_AROUND_LOGOFF', 'SUCC_ALL_NPI_EVENTS')) AS
    t1_2
   UNION ALL
   SELECT t5.cash_register_event_sid_ow AS cash_register_event_sid,
    t5.scenario_id,
    t5.cust_sid,
    t5.cust_ident_type_cd,
    t5.cash_register_event_nr,
    t5.cashier_nr,
    t5.bus_dt,
    t5.store_sid,
    t5.country_org_cd,
    t5.rel_cash_register_event_sid,
    t5.rel_bus_dt,
    t5.cash_register_event_rel_type_cd
   FROM (SELECT DISTINCT MAX(CASE
        WHEN rel.cash_register_event_rel_type_cd = 'SELF'
        THEN 0
        ELSE rel.rel_cash_register_event_sid
        END) OVER (PARTITION BY rel.cash_register_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
      AS cash_register_event_sid_ow,
      cls.scenario_id,
      cls.cust_sid,
      cls.cust_ident_type_cd,
      ROUND(CAST(RIGHT(SUBSTR(CAST(MAX(CASE
             WHEN rel.cash_register_event_rel_type_cd = 'SELF'
             THEN 0
             ELSE rel.rel_cash_register_event_sid
             END) OVER (PARTITION BY rel.cash_register_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS STRING)
          , 1, 10), 10) AS BIGNUMERIC), 0) AS cash_register_event_nr,
      cls.cashier_nr,
      cls.bus_dt,
      cls.store_sid,
      cls.country_org_cd,
       CASE
       WHEN rel.cash_register_event_rel_type_cd = 'SELF'
       THEN rel.cash_register_event_sid
       ELSE rel.rel_cash_register_event_sid
       END AS rel_cash_register_event_sid,
      rel.rel_bus_dt,
      rel.cash_register_event_rel_type_cd
     FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship_2 AS rel
      INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_2 AS cls ON rel.bus_dt
         = cls.bus_dt AND rel.country_org_cd = cls.country_org_cd AND rel.cash_register_event_sid = cls.cash_register_event_sid
        
     WHERE cls.scenario_id IN (12, 120100, 120200, 120300, 120400, 120600, 120700, 120800, 120900)
      AND rel.cash_register_event_rel_type_cd IN ('SELF', 'ORIGINAL')) AS t5
   UNION ALL
   SELECT cls.cash_register_event_sid,
    cls.scenario_id,
    cls.cust_sid,
    cls.cust_ident_type_cd,
    ROUND(CAST(cls.cash_register_event_nr AS BIGNUMERIC), 0) AS cash_register_event_nr,
    cls.cashier_nr,
    cls.bus_dt,
    cls.store_sid,
    cls.country_org_cd,
    rel.rel_cash_register_event_sid,
    rel.rel_bus_dt,
    rel.cash_register_event_rel_type_cd
   FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship_2 AS rel
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification_2 AS cls ON rel.bus_dt =
       cls.bus_dt AND rel.country_org_cd = cls.country_org_cd AND rel.cash_register_event_sid = cls.cash_register_event_sid
      
   WHERE cls.scenario_id NOT IN (6, 60100, 60200, 60300, 12, 120100, 120200, 120300, 120400, 120600, 120700, 120800,
      120900)), cte_return_same_original AS (SELECT country_org_cd,
   bus_dt,
   cash_register_event_sid,
   SUM(1) AS rel_cnt
  FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship_2 AS cer
  GROUP BY country_org_cd,
   bus_dt,
   cash_register_event_sid) (SELECT org.country_org_sid,
   cls.scenario_id,
   cls.cust_sid,
   cls.cust_ident_type_cd,
   CAST(cls.cash_register_event_sid AS STRING) AS cash_register_event_sid,
   cls.cash_register_event_nr,
   cls.cashier_nr,
   cls.bus_dt,
   cls.store_sid,
   CAST(cls.rel_cash_register_event_sid AS STRING) AS rel_cash_register_event_sid,
   main.cash_register_event_nr AS rel_cash_register_event_nr,
   main.cashier_nr AS rel_cashier_nr,
   main.cash_register_event_line_seq,
   1 AS cash_register_event_line_seq_dbl,
   main.event_auth_by_nr,
   main.line_auth_by_nr,
   main.event_auth_by_nr AS event_auth_by_nr0,
   main.parent_line_seq,
   main.retail_event_line_scenario_id,
   FORMAT_TIMESTAMP('%H:%M:%S', main.event_start_tmsp) AS event_start_tmsp,
   FORMAT_TIMESTAMP('%H:%M:%S', main.event_end_tmsp) AS event_end_tmsp,
    CASE
    WHEN main.retail_event_line_scenario_id = 855
    THEN main.event_end_tmsp
    ELSE main.event_line_start_tmsp
    END AS event_line_start_tmsp,
   main.event_line_end_tmsp,
   main.bus_dt AS rel_bus_dt,
   main.store_sid AS rel_store_sid,
   main.store_nr,
   main.country_org_cd,
   main.cash_register_nr,
   main.prod_retail_line_type_cd,
   sal_var.prod_sid,
   main.prod_variant_sid,
   main.local_prod_nr,
   main.prod_variant_input_nr,
   main.prod_variant_input_nr_type_cd,
   main.local_prod_nr AS displayed_prod_variant_name_title,
   main.prod_name AS displayed_prod_variant_name,
   main.prod_entry_method_cd,
   main.price_entry_method_cd,
   main.paym_line_type_cd,
   main.paym_type_id,
   main.fraud_detection_relevant_fg,
   main.prod_return_reason_sid,
   main.return_txt,
   main.parent_retail_event_sid,
    CASE
    WHEN main.cash_register_event_scenario_id = 480
    THEN main.tax_line_gross_val
    ELSE main.unit_price
    END AS unit_price,
    CASE
    WHEN main.cash_register_event_scenario_id = 480
    THEN 1
    ELSE main.prod_variant_cnt
    END AS prod_variant_cnt,
   main.prod_variant_qty,
   main.base_gross_val,
    CASE
    WHEN main.cash_register_event_scenario_id = 480
    THEN main.tax_line_gross_val
    ELSE main.retail_line_gross_val
    END AS retail_line_gross_val,
   main.retail_line_vat_val,
   main.local_paym_val,
   main.tax_line_gross_val AS txn_gross_val,
   main.tax_line_val AS txn_vat_val,
   main.tax_pct,
   main.cash_register_event_seq,
   main.dwh_created_tmsp,
   main.dwh_updated_tmsp,
   main.dwh_load_id,
   main.dwh_node_cd,
   main.cash_register_event_scenario_id,
   main.orig_country_org_cd,
   main.orig_store_nr,
   main.orig_bus_dt,
   main.orig_cash_register_nr,
   main.orig_cash_register_event_nr,
   main.orig_cash_register_event_nr AS orig_cash_register_event_nr0
  FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_suspicious_cash_register_event_2 AS susp
   INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_2 AS org_susp ON susp.store_sid = org_susp.int_org_sid
      AND org_susp.dwh_valid_fg
   INNER JOIN cte_cls_rel_cash_register AS cls ON susp.bus_dt = cls.bus_dt AND org_susp.country_org_cd = cls.country_org_cd
       AND susp.cash_register_event_sid = cls.cash_register_event_sid
   INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_scenario_to_relationship_type_2 AS rl ON
     cls.scenario_id = rl.scenario_id AND cls.cash_register_event_rel_type_cd = rl.cash_register_event_rel_type_cd
   LEFT JOIN cte_return_same_original AS sce_check ON cls.bus_dt = sce_check.bus_dt AND cls.cash_register_event_sid =
       sce_check.cash_register_event_sid AND cls.country_org_cd = sce_check.country_org_cd AND (cls.scenario_id = 8 AND
        sce_check.rel_cnt >= 3 OR cls.scenario_id <> 8)
   INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_print_2 AS main ON cls.rel_bus_dt = main.bus_dt
       AND cls.country_org_cd = main.country_org_cd AND cls.rel_cash_register_event_sid = main.cash_register_event_sid
   LEFT JOIN ldl_data_production_core_dim.t_dim_sales_variant_2 AS sal_var ON main.prod_variant_sid = sal_var.sales_variant_sid
      AND sal_var.dwh_valid_fg
   INNER JOIN (SELECT country_org_sid
    FROM ldl_data_production_core_dim.t_dim_internal_organization_2 AS org
    WHERE dwh_valid_fg
     AND is_country_org_fg) AS org ON TRUE);