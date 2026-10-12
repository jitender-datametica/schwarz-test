
--T_PAYMENT_LINE_2



UPDATE ldl_data_production_core_rel.t_payment_line_2 SET
 cashier_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_RETAIL_EVENT_2


UPDATE ldl_data_production_core_rel.t_retail_event_2 SET
 cashier_nr = '-1',
 auth_by_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_TAX_LINE_2


UPDATE ldl_data_production_core_rel.t_tax_line_2 SET
 cashier_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_SUBTOTAL_LINE_2


UPDATE ldl_data_production_core_rel.t_subtotal_line_2 SET
 cashier_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_PRODUCT_RETAIL_LINE_2


UPDATE ldl_data_production_core_rel.t_product_retail_line_2 SET
 cashier_nr = '-1',
 auth_by_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_PRICE_INFORMATION_EVENT_2


UPDATE ldl_data_production_core_rel.t_price_information_event_2 SET
 cashier_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_CANCELLATION_LINE_2


UPDATE ldl_data_production_core_rel.t_cancellation_line_2 SET
 cashier_nr = '-1',
 auth_by_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_DISCOUNT_LINE_2


UPDATE ldl_data_production_core_rel.t_discount_line_2 SET
 cashier_nr = '-1',
 auth_by_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_TECHNICAL_CASH_REGISTER_EVENT_2


UPDATE ldl_data_production_core_rel.t_technical_cash_register_event_2 SET
 cashier_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);