
--T_PAYMENT_LINE



UPDATE ldl_data_production_core_rel.t_payment_line SET
 cashier_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_RETAIL_EVENT


UPDATE ldl_data_production_core_rel.t_retail_event SET
 cashier_nr = '-1',
 auth_by_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_TAX_LINE


UPDATE ldl_data_production_core_rel.t_tax_line SET
 cashier_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_SUBTOTAL_LINE


UPDATE ldl_data_production_core_rel.t_subtotal_line SET
 cashier_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_PRODUCT_RETAIL_LINE


UPDATE ldl_data_production_core_rel.t_product_retail_line SET
 cashier_nr = '-1',
 auth_by_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_PRICE_INFORMATION_EVENT


UPDATE ldl_data_production_core_rel.t_price_information_event SET
 cashier_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_CANCELLATION_LINE


UPDATE ldl_data_production_core_rel.t_cancellation_line SET
 cashier_nr = '-1',
 auth_by_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_DISCOUNT_LINE


UPDATE ldl_data_production_core_rel.t_discount_line SET
 cashier_nr = '-1',
 auth_by_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);


--T_TECHNICAL_CASH_REGISTER_EVENT


UPDATE ldl_data_production_core_rel.t_technical_cash_register_event SET
 cashier_nr = '-1',
 dwh_updated_tmsp = CAST(CURRENT_DATE AS TIMESTAMP)
WHERE cashier_nr <> '-1' AND bus_dt < DATE_ADD(CURRENT_DATE, INTERVAL CAST(- CAST(${sql_input_1} AS FLOAT64) AS INTEGER
    ) WEEK);