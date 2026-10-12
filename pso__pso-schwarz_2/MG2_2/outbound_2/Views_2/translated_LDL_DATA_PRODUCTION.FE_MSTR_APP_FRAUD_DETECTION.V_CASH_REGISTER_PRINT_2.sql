CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_cash_register_print_2 AS WITH
 cte_transaction_types AS (SELECT retail_event_line_scenario_id,
     CASE
     WHEN retail_event_line_scenario_id = 480
     THEN 'Preisanzeige'
     ELSE CAST(retail_event_line_scenario_name AS STRING)
     END AS retail_event_line_scenario_name,
    retail_event_line_scenario_short_name,
    retail_event_line_scenario_descr
   FROM ldl_data_production_core_rel.t_retail_event_line_scenario_2 AS main
   WHERE lang_cd = 'DE'
    AND retail_event_line_scenario_id NOT IN (SELECT CAST(tech_cash_register_event_type_cd AS INTEGER) AS
        tech_cash_register_event_type_cd
       FROM ldl_data_production_core_rel.t_technical_cash_register_event_type_2 AS cre
       WHERE lang_cd = 'DE'
       UNION ALL
       SELECT retail_event_scenario_id
       FROM ldl_data_production_core_rel.t_retail_event_scenario_2 AS res
       WHERE lang_cd = 'DE')
   UNION ALL
   SELECT CAST(tech_cash_register_event_type_cd AS INTEGER) AS retail_event_line_scenario_id,
    tech_cash_register_event_type_descr AS retail_event_line_scenario_name,
    tech_cash_register_event_type_descr AS retail_event_line_scenario_short_name,
    tech_cash_register_event_type_descr AS retail_event_line_scenario_descr
   FROM ldl_data_production_core_rel.t_technical_cash_register_event_type_2 AS main
   WHERE lang_cd = 'DE'
   UNION ALL
   SELECT retail_event_scenario_id AS retail_event_line_scenario_id,
    retail_event_scenario_name AS retail_event_line_scenario_name,
    retail_event_scenario_name AS retail_event_line_scenario_short_name,
    retail_event_scenario_descr AS retail_event_line_scenario_descr
   FROM ldl_data_production_core_rel.t_retail_event_scenario_2 AS main
   WHERE lang_cd = 'DE') (SELECT CAST(main.cash_register_event_sid AS STRING) AS rel_cash_register_event_sid,
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
    THEN CAST('>> ' || header_sce.retail_event_line_scenario_name || ' <<' AS STRING)
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
  FROM ldl_data_production_core_app_fraud_detection.t_cash_register_print_2 AS main
   LEFT JOIN (SELECT TRUE AS base_val,
      0 AS double_val
     UNION ALL
     SELECT TRUE AS base_val,
      1 AS double_val
     UNION ALL
     SELECT TRUE AS base_val,
      2 AS double_val) AS d ON main.first_line_of_event_fg = d.base_val AND main.parent_line_seq = - 1
   LEFT JOIN cte_transaction_types AS line_sce ON main.retail_event_line_scenario_id = line_sce.retail_event_line_scenario_id
    
   LEFT JOIN cte_transaction_types AS header_sce ON main.cash_register_event_scenario_id = header_sce.retail_event_line_scenario_id
    );