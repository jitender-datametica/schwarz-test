CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_cash_register_print_scenario_metric AS WITH
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
     FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship AS rel
      INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification AS cls ON rel.bus_dt
         = cls.bus_dt AND rel.country_org_cd = cls.country_org_cd AND rel.cash_register_event_sid = cls.cash_register_event_sid
        
     WHERE cls.scenario_id IN (6, 60100, 60200, 60300)
      AND rel.cash_register_event_rel_type_cd IN ('SELF', 'SUCCESSOR', 'EVENT_AROUND_LOGOFF', 'SUCC_ALL_NPI_EVENTS')) AS
    t1
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
     FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship AS rel
      INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification AS cls ON rel.bus_dt
         = cls.bus_dt AND rel.country_org_cd = cls.country_org_cd AND rel.cash_register_event_sid = cls.cash_register_event_sid
        
     WHERE cls.scenario_id IN (12, 120100, 120200, 120300, 120400, 120600, 120700, 120900, 120800)
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
   FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship AS rel
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_classification AS cls ON rel.bus_dt =
       cls.bus_dt AND rel.country_org_cd = cls.country_org_cd AND rel.cash_register_event_sid = cls.cash_register_event_sid
      
   WHERE cls.scenario_id NOT IN (6, 60100, 60200, 60300, 12, 120100, 120200, 120300, 120400, 120600, 120700, 120800,
      120900)), cte_store_order_reason AS (SELECT org.int_org_sid AS store_sid,
   ord.order_reason_cd
  FROM ldl_data_production_core_app_fraud_detection.t_fraud_detection_order AS ord
   INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization AS org ON ord.int_org_sid = org.int_org_sid OR
     ord.int_org_sid = org.sales_company_sid
  WHERE ord.order_parameter_status_cd = 'RV'
   AND org.dwh_valid_fg
   AND org.int_org_type_cd = 'STORE'), cte_return_same_original AS (SELECT country_org_cd,
   bus_dt,
   cash_register_event_sid,
   SUM(1) AS rel_cnt
  FROM ldl_data_production_core_app_fraud_detection.t_cash_register_event_relationship AS cer
  GROUP BY country_org_cd,
   bus_dt,
   cash_register_event_sid), cte_transaction_types AS (SELECT retail_event_line_scenario_id,
     CASE
     WHEN retail_event_line_scenario_id = 480
     THEN 'Preisanzeige'
     ELSE CAST(retail_event_line_scenario_name AS STRING)
     END AS retail_event_line_scenario_name,
    retail_event_line_scenario_short_name,
    retail_event_line_scenario_descr
   FROM ldl_data_production_core_rel.t_retail_event_line_scenario AS main
   WHERE lang_cd = 'DE'
    AND retail_event_line_scenario_id NOT IN (SELECT CAST(tech_cash_register_event_type_cd AS INTEGER) AS
        tech_cash_register_event_type_cd
       FROM ldl_data_production_core_rel.t_technical_cash_register_event_type AS cre
       WHERE lang_cd = 'DE'
       UNION ALL
       SELECT retail_event_scenario_id
       FROM ldl_data_production_core_rel.t_retail_event_scenario AS res
       WHERE lang_cd = 'DE')
   UNION ALL
   SELECT CAST(tech_cash_register_event_type_cd AS INTEGER) AS retail_event_line_scenario_id,
    tech_cash_register_event_type_descr AS retail_event_line_scenario_name,
    tech_cash_register_event_type_descr AS retail_event_line_scenario_short_name,
    tech_cash_register_event_type_descr AS retail_event_line_scenario_descr
   FROM ldl_data_production_core_rel.t_technical_cash_register_event_type AS main
   WHERE lang_cd = 'DE'
   UNION ALL
   SELECT retail_event_scenario_id AS retail_event_line_scenario_id,
    retail_event_scenario_name AS retail_event_line_scenario_name,
    retail_event_scenario_name AS retail_event_line_scenario_short_name,
    retail_event_scenario_descr AS retail_event_line_scenario_descr
   FROM ldl_data_production_core_rel.t_retail_event_scenario AS main
   WHERE lang_cd = 'DE') (SELECT cls.scenario_id,
   m.metric_id,
   cls.cust_sid,
   cls.cust_ident_type_cd,
   CAST(cls.cash_register_event_sid AS STRING) AS cash_register_event_sid,
   cls.cash_register_event_nr,
   cls.cashier_nr,
   cls.bus_dt,
   cls.store_sid,
   reas.order_reason_cd,
   CAST(cls.rel_cash_register_event_sid AS STRING) AS rel_cash_register_event_sid,
   main.cash_register_event_nr AS rel_cash_register_event_nr,
   main.cashier_nr AS rel_cashier_nr,
    CASE
    WHEN COALESCE(d.double_val, 1) = 1
    THEN main.cash_register_event_line_seq
    ELSE NULL
    END AS cash_register_event_line_seq,
   COALESCE(d.double_val, 1) AS cash_register_event_line_seq_dbl,
    CASE
    WHEN COALESCE(d.double_val, 1) = 0
    THEN main.event_auth_by_nr
    WHEN COALESCE(d.double_val, 1) = 2
    THEN main.event_auth_by_nr
    ELSE main.line_auth_by_nr
    END AS auth_nr,
   main.line_auth_by_nr,
   main.event_auth_by_nr,
   main.parent_line_seq,
   main.retail_event_line_scenario_id,
   FORMAT_TIMESTAMP('%H:%M:%S', main.event_start_tmsp) AS event_start_tmsp,
   FORMAT_TIMESTAMP('%H:%M:%S', main.event_end_tmsp) AS event_end_tmsp,
    CASE
    WHEN COALESCE(d.double_val, 1) = 0
    THEN FORMAT_DATE('%d.%m.%Y', main.bus_dt)
    WHEN COALESCE(d.double_val, 1) = 1
    THEN FORMAT_TIMESTAMP('%H:%M:%S', main.event_line_start_tmsp)
    ELSE FORMAT_TIMESTAMP('%H:%M:%S', main.event_start_tmsp)
    END AS event_line_start_tmsp,
   FORMAT_TIMESTAMP('%H:%M:%S', CASE
     WHEN COALESCE(d.double_val, 1) = 1
     THEN main.event_line_end_tmsp
     ELSE main.event_end_tmsp
     END) AS event_line_end_tmsp,
   main.bus_dt AS rel_bus_dt,
   main.store_sid AS rel_store_sid,
   main.store_nr,
   main.country_org_cd,
   main.cash_register_nr,
   main.prod_retail_line_type_cd,
   main.prod_variant_sid,
    CASE
    WHEN COALESCE(d.double_val, 1) = 0
    THEN CAST(main.cash_register_event_nr AS STRING)
    WHEN COALESCE(d.double_val, 1) = 2
    THEN ''
    ELSE CAST(COALESCE(main.local_prod_nr, CAST(CAST(main.cash_register_event_nr AS FLOAT64) * 1000 + main.cash_register_event_line_seq
        AS STRING)) AS STRING)
    END AS local_prod_nr,
   main.prod_variant_input_nr,
   main.prod_variant_input_nr_type_cd,
    CASE
    WHEN COALESCE(d.double_val, 1) = 0
    THEN CAST(main.cash_register_event_nr AS STRING)
    WHEN COALESCE(d.double_val, 1) = 2
    THEN ''
    ELSE CAST(main.local_prod_nr AS STRING)
    END AS displayed_prod_variant_name_title,
    CASE
    WHEN COALESCE(d.double_val, 1) = 0
    THEN CAST('>> [' || header_sce.retail_event_line_scenario_name || ']<<' AS STRING)
    WHEN COALESCE(d.double_val, 1) = 2
    THEN ''
    ELSE CAST(COALESCE(main.prod_name, line_sce.retail_event_line_scenario_name) AS STRING)
    END AS displayed_prod_variant_name,
   main.prod_entry_method_cd,
   main.price_entry_method_cd,
   main.paym_line_type_cd,
   main.paym_type_id,
   main.fraud_detection_relevant_fg,
   main.prod_return_reason_sid,
   main.return_txt,
   main.parent_retail_event_sid,
   main.unit_price,
   main.prod_variant_cnt,
   main.prod_variant_qty,
   main.base_gross_val,
   main.retail_line_gross_val,
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
   main.orig_country_org_cd,
   main.orig_store_nr,
   main.orig_bus_dt,
   main.orig_cash_register_nr,
   main.orig_cash_register_event_nr,
   main.orig_cash_register_event_nr AS orig_cash_register_event_nr0
  FROM cte_cls_rel_cash_register AS cls
   INNER JOIN cte_store_order_reason AS reas ON cls.store_sid = reas.store_sid
   INNER JOIN ldl_data_production_core_app_fraud_detection.t_fraud_detection_mstr_metric AS m ON cls.scenario_id = m.scenario_id
    
   INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_event_scenario_to_relationship_type AS rl ON
     cls.scenario_id = rl.scenario_id AND cls.cash_register_event_rel_type_cd = rl.cash_register_event_rel_type_cd
   INNER JOIN ldl_data_production_core_app_fraud_detection.t_cash_register_print AS main ON cls.rel_bus_dt = main.bus_dt
       AND cls.country_org_cd = main.country_org_cd AND cls.rel_cash_register_event_sid = main.cash_register_event_sid
   LEFT JOIN cte_return_same_original AS sce_check ON cls.bus_dt = sce_check.bus_dt AND cls.cash_register_event_sid =
       sce_check.cash_register_event_sid AND cls.country_org_cd = sce_check.country_org_cd AND (cls.scenario_id = 8 AND
        sce_check.rel_cnt >= 3 OR cls.scenario_id <> 8)
   LEFT JOIN cte_transaction_types AS line_sce ON main.retail_event_line_scenario_id = line_sce.retail_event_line_scenario_id
    
   LEFT JOIN cte_transaction_types AS header_sce ON main.cash_register_event_scenario_id = header_sce.retail_event_line_scenario_id
    
   LEFT JOIN (SELECT TRUE AS base_val,
      0 AS double_val
     UNION ALL
     SELECT TRUE AS base_val,
      1 AS double_val
     UNION ALL
     SELECT TRUE AS base_val,
      2 AS double_val) AS d ON main.first_line_of_event_fg = d.base_val AND main.parent_line_seq = - 1 AND (d.double_val
         = 2 AND cls.cash_register_event_sid = cls.rel_cash_register_event_sid OR main.first_line_of_event_fg = d.base_val
         AND d.double_val < 2));